from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
from dotenv import load_dotenv
from functools import wraps
import os, bcrypt, secrets, smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime, timedelta

load_dotenv()

app = Flask(__name__)
app.config['MYSQL_HOST']     = os.getenv('MYSQL_HOST')
app.config['MYSQL_USER']     = os.getenv('MYSQL_USER')
app.config['MYSQL_PASSWORD'] = os.getenv('MYSQL_PASSWORD')
app.config['MYSQL_DB']       = os.getenv('MYSQL_DB')
app.secret_key               = os.getenv('SECRET_KEY', 'heritage_secret_123')

MAIL_EMAIL    = os.getenv('MAIL_EMAIL')
MAIL_PASSWORD = os.getenv('MAIL_PASSWORD')
APP_URL       = os.getenv('APP_URL', 'http://127.0.0.1:5000')

mysql = MySQL(app)

# ── Helpers ───────────────────────────────────────────────────

def hash_password(plain):
    return bcrypt.hashpw(plain.encode(), bcrypt.gensalt()).decode()

def check_password(plain, hashed):
    return bcrypt.checkpw(plain.encode(), hashed.encode())

def send_reset_email(to_email, reset_link, name):
    msg = MIMEMultipart('alternative')
    msg['Subject'] = '🏛️ HeritageDB — Reset Your Password'
    msg['From']    = MAIL_EMAIL
    msg['To']      = to_email
    html = f"""
    <div style="font-family:Arial,sans-serif;max-width:520px;margin:auto;
                background:#0d1117;color:#fff;border-radius:16px;overflow:hidden;">
      <div style="background:#f0a500;padding:24px;text-align:center;">
        <h1 style="margin:0;color:#000;">🏛️ HeritageDB</h1>
        <p style="margin:4px 0 0;color:#333;font-size:0.9rem;">Heritage Management System</p>
      </div>
      <div style="padding:32px;">
        <p>Hi <strong>{name}</strong>,</p>
        <p style="color:#ccc;margin-top:8px;">
          Click the button below to reset your password.
          This link expires in <strong>30 minutes</strong>.
        </p>
        <div style="text-align:center;margin:32px 0;">
          <a href="{reset_link}"
             style="background:#f0a500;color:#000;padding:14px 32px;
                    border-radius:8px;text-decoration:none;font-weight:700;">
            Reset My Password
          </a>
        </div>
        <p style="color:#555;font-size:0.8rem;">
          If you didn't request this, ignore this email.
        </p>
      </div>
      <div style="background:#111;padding:14px;text-align:center;
                  color:#444;font-size:0.75rem;">
        HeritageDB 2026 — Preserving India's Cultural Legacy
      </div>
    </div>"""
    msg.attach(MIMEText(html, 'html'))
    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as s:
        s.login(MAIL_EMAIL, MAIL_PASSWORD)
        s.sendmail(MAIL_EMAIL, to_email, msg.as_string())

def send_verification_email(to_email, verify_link, name):
    msg = MIMEMultipart('alternative')
    msg['Subject'] = '🏛️ HeritageDB — Verify Your Email'
    msg['From']    = MAIL_EMAIL
    msg['To']      = to_email
    html = f"""
    <div style="font-family:Arial,sans-serif;max-width:520px;margin:auto;
                background:#0d1117;color:#fff;border-radius:16px;overflow:hidden;">
      <div style="background:#f0a500;padding:24px;text-align:center;">
        <h1 style="margin:0;color:#000;">🏛️ HeritageDB</h1>
        <p style="margin:4px 0 0;color:#333;font-size:0.9rem;">Heritage Management System</p>
      </div>
      <div style="padding:32px;">
        <p>Hi <strong>{name}</strong>,</p>
        <p style="color:#ccc;margin-top:8px;">
          Thank you for registering! Please verify your email address
          by clicking the button below.
        </p>
        <div style="text-align:center;margin:32px 0;">
          <a href="{verify_link}"
             style="background:#f0a500;color:#000;padding:14px 32px;
                    border-radius:8px;text-decoration:none;font-weight:700;">
            Verify My Email
          </a>
        </div>
        <p style="color:#555;font-size:0.8rem;">
          If you didn't register on HeritageDB, ignore this email.
        </p>
      </div>
      <div style="background:#111;padding:14px;text-align:center;
                  color:#444;font-size:0.75rem;">
        HeritageDB 2026 — Preserving India's Cultural Legacy
      </div>
    </div>"""
    msg.attach(MIMEText(html, 'html'))
    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as s:
        s.login(MAIL_EMAIL, MAIL_PASSWORD)
        s.sendmail(MAIL_EMAIL, to_email, msg.as_string())

# ── Decorators ────────────────────────────────────────────────

def login_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated

def admin_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('admin_login_page'))
        if session.get('role') != 'admin':
            return render_template("403.html"), 403
        return f(*args, **kwargs)
    return decorated

# ── Auth Routes — Visitor ─────────────────────────────────────

@app.route("/login", methods=["GET", "POST"])
def login():
    if 'user_id' in session:
        if session.get('role') == 'admin':
            return redirect(url_for('contributions'))
        return redirect(url_for('home'))

    if request.method == "POST":
        action   = request.form.get('action')
        email    = request.form.get('email', '').strip()
        password = request.form.get('password', '')
        cur      = mysql.connection.cursor()

        if action == 'register':
            firstname = request.form.get('firstname', '').strip()
            lastname  = request.form.get('lastname', '').strip()
            cur.execute(
                "SELECT Visitor_ID FROM Visitors WHERE Email = %s", (email,))
            if cur.fetchone():
                cur.close()
                return render_template("login.html",
                    error="This email is already registered. Please sign in.",
                    active_tab="register")
            hashed = hash_password(password)
            token  = secrets.token_urlsafe(32)
            cur.execute("""
                INSERT INTO Visitors
                    (FirstName, LastName, Email, Password, is_verified, verify_token)
                VALUES (%s, %s, %s, %s, 0, %s)
            """, (firstname, lastname, email, hashed, token))
            mysql.connection.commit()
            cur.close()
            verify_link = f"{APP_URL}/verify-email/{token}"
            try:
                send_verification_email(email, verify_link, firstname)
                return render_template("login.html",
                    success="Registration successful! Please check your email and verify your account before logging in.",
                    active_tab="login")
            except Exception as e:
                return render_template("login.html",
                    error=f"Registered but could not send verification email. Error: {str(e)}",
                    active_tab="login")

        elif action == 'login':
            cur.execute("""
                SELECT Visitor_ID, FirstName, Password, is_verified
                FROM Visitors WHERE Email = %s
            """, (email,))
            user = cur.fetchone()
            cur.close()
            if user and user[2] and check_password(password, user[2]):
                if not user[3]:
                    return render_template("login.html",
                        error="Please verify your email first. Check your inbox for the verification link.",
                        active_tab="login")
                session['user_id']   = user[0]
                session['user_name'] = user[1]
                session['role']      = 'visitor'
                return redirect(url_for('contribute'))
            return render_template("login.html",
                error="Invalid email or password.", active_tab="login")

    return render_template("login.html")


@app.route("/verify-email/<token>")
def verify_email(token):
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT Visitor_ID, FirstName
        FROM Visitors
        WHERE verify_token = %s AND is_verified = 0
    """, (token,))
    visitor = cur.fetchone()
    if not visitor:
        cur.close()
        return render_template("login.html",
            error="Invalid or already used verification link. Please login if already verified.")
    cur.execute("""
        UPDATE Visitors
        SET is_verified = 1, verify_token = NULL
        WHERE Visitor_ID = %s
    """, (visitor[0],))
    mysql.connection.commit()
    cur.close()
    return render_template("login.html",
        success="Email verified successfully! You can now log in and contribute.")


@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for('home'))


# ── Auth Routes — Admin ───────────────────────────────────────

@app.route("/admin/login", methods=["GET", "POST"])
def admin_login_page():
    if session.get('role') == 'admin':
        return redirect(url_for('contributions'))

    if request.method == "POST":
        email    = request.form.get('email', '').strip()
        password = request.form.get('password', '')
        cur = mysql.connection.cursor()
        cur.execute("""
            SELECT Admin_ID, Name, Password
            FROM Admin WHERE Email = %s
        """, (email,))
        user = cur.fetchone()
        cur.close()
        if user and user[2] and check_password(password, user[2]):
            session['user_id']   = user[0]
            session['user_name'] = user[1]
            session['role']      = 'admin'
            return redirect(url_for('contributions'))
        return render_template("admin_login.html",
            error="Invalid admin email or password.")

    return render_template("admin_login.html")


@app.route("/admin/logout")
def admin_logout_page():
    session.clear()
    return redirect(url_for('admin_login_page'))


# ── Password Reset ────────────────────────────────────────────

@app.route("/forgot-password", methods=["GET", "POST"])
def forgot_password():
    if request.method == "POST":
        email = request.form['email'].strip()
        cur   = mysql.connection.cursor()
        cur.execute(
            "SELECT FirstName, 'visitor' FROM Visitors WHERE Email = %s", (email,))
        user = cur.fetchone()
        if not user:
            cur.execute(
                "SELECT Name, 'admin' FROM Admin WHERE Email = %s", (email,))
            user = cur.fetchone()
        if user:
            name    = user[0]
            role    = user[1]
            token   = secrets.token_urlsafe(32)
            expires = datetime.now() + timedelta(minutes=30)
            cur.execute("""
                INSERT INTO password_reset_tokens (email, token, expires_at)
                VALUES (%s, %s, %s)
            """, (email, token, expires))
            mysql.connection.commit()
            cur.close()
            reset_link = f"{APP_URL}/reset-password/{token}?role={role}"
            try:
                send_reset_email(email, reset_link, name)
                return render_template("login.html",
                    success="Reset link sent! Check your email inbox.")
            except Exception as e:
                return render_template("login.html",
                    error=f"Could not send email. Error: {str(e)}")
        else:
            cur.close()
            return render_template("login.html",
                error="No account found with that email address.")
    return render_template("login.html")


@app.route("/reset-password/<token>", methods=["GET", "POST"])
def reset_password(token):
    role = request.args.get('role', 'visitor')
    cur  = mysql.connection.cursor()
    cur.execute("""
        SELECT email FROM password_reset_tokens
        WHERE token = %s AND used = 0 AND expires_at > NOW()
    """, (token,))
    record = cur.fetchone()
    if not record:
        cur.close()
        return render_template("reset_password.html",
            expired=True, token=token, role=role)
    email = record[0]
    if request.method == "POST":
        new_pass     = request.form['password']
        confirm_pass = request.form['confirm_password']
        if new_pass != confirm_pass:
            cur.close()
            return render_template("reset_password.html",
                error="Passwords do not match.", token=token, role=role)
        if len(new_pass) < 6:
            cur.close()
            return render_template("reset_password.html",
                error="Password must be at least 6 characters.", token=token, role=role)
        hashed = hash_password(new_pass)
        if role == 'admin':
            cur.execute(
                "UPDATE Admin SET Password = %s WHERE Email = %s", (hashed, email))
        else:
            cur.execute(
                "UPDATE Visitors SET Password = %s WHERE Email = %s", (hashed, email))
        cur.execute(
            "UPDATE password_reset_tokens SET used = 1 WHERE token = %s", (token,))
        mysql.connection.commit()
        cur.close()
        return render_template("login.html",
            success="Password updated! Please sign in with your new password.")
    cur.close()
    return render_template("reset_password.html", token=token, role=role)

# ── Home ──────────────────────────────────────────────────────

@app.route("/")
def home():
    cur = mysql.connection.cursor()
    cur.execute("SELECT COUNT(*) FROM Heritage_Site")
    site_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM Visitors")
    visitor_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM Review")
    review_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM Contribution")
    contribution_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM Admin")
    admin_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM Location")
    location_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM Architecture_Style")
    architecture_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM Image_Gallery")
    gallery_count = cur.fetchone()[0]
    cur.close()
    return render_template("index.html",
        site_count=site_count,
        visitor_count=visitor_count,
        review_count=review_count,
        contribution_count=contribution_count,
        admin_count=admin_count,
        location_count=location_count,
        architecture_count=architecture_count,
        gallery_count=gallery_count
    )

# ── Sites with Filters ────────────────────────────────────────

@app.route("/sites")
def sites():
    cur = mysql.connection.cursor()

    search = request.args.get('search', '').strip()
    state  = request.args.get('state', '').strip()
    unesco = request.args.get('unesco', '').strip()
    period = request.args.get('period', '').strip()

    query = """
        SELECT h.Site_ID, h.Site_Name, h.Description,
               h.Historical_Period, h.UNESCO_Status,
               l.city, l.state, i.Image_Url,
               AVG(r.Rating) as avg_rating,
               COUNT(r.Review_ID) as review_count
        FROM Heritage_Site h
        LEFT JOIN Location l ON h.Location_ID = l.Location_ID
        LEFT JOIN Image_Gallery i ON h.Site_ID = i.Site_ID
        LEFT JOIN Review r ON h.Site_ID = r.Site_ID
        WHERE 1=1
    """
    params = []

    if search:
        query += " AND (h.Site_Name LIKE %s OR l.city LIKE %s OR l.state LIKE %s)"
        params += [f'%{search}%', f'%{search}%', f'%{search}%']
    if state:
        query += " AND l.state = %s"
        params.append(state)
    if unesco:
        query += " AND h.UNESCO_Status = %s"
        params.append(unesco)
    if period:
        query += " AND h.Historical_Period LIKE %s"
        params.append(f'%{period}%')

    query += """
        GROUP BY h.Site_ID, h.Site_Name, h.Description,
                 h.Historical_Period, h.UNESCO_Status,
                 l.city, l.state, i.Image_Url
    """

    cur.execute(query, params)
    sites = cur.fetchall()

    cur.execute("SELECT DISTINCT state FROM Location ORDER BY state")
    states = [row[0] for row in cur.fetchall()]

    cur.execute(
        "SELECT DISTINCT UNESCO_Status FROM Heritage_Site ORDER BY UNESCO_Status")
    unesco_list = [row[0] for row in cur.fetchall()]

    cur.close()
    return render_template("sites.html",
        sites=sites,
        states=states,
        unesco_list=unesco_list,
        selected_state=state,
        selected_unesco=unesco,
        selected_period=period,
        search=search
    )

# ── Site Detail ───────────────────────────────────────────────

@app.route("/site/<int:site_id>")
def site_detail(site_id):
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT h.*, l.city, l.state, l.area, l.district, l.pincode
        FROM Heritage_Site h
        LEFT JOIN Location l ON h.Location_ID = l.Location_ID
        WHERE h.Site_ID = %s
    """, (site_id,))
    site = cur.fetchone()
    cur.execute(
        "SELECT * FROM Architecture_Style WHERE Site_ID = %s", (site_id,))
    architecture = cur.fetchone()
    cur.execute(
        "SELECT * FROM Image_Gallery WHERE Site_ID = %s", (site_id,))
    images = cur.fetchall()
    cur.execute("""
        SELECT r.*, v.FirstName, v.LastName
        FROM Review r
        LEFT JOIN Visitors v ON r.Visitor_ID = v.Visitor_ID
        WHERE r.Site_ID = %s
        ORDER BY r.Review_Date DESC
    """, (site_id,))
    reviews = cur.fetchall()
    cur.close()
    return render_template("site_detail.html",
        site=site, architecture=architecture,
        images=images, reviews=reviews)

# ── Submit Review ─────────────────────────────────────────────

@app.route("/submit_review/<int:site_id>", methods=["POST"])
def submit_review(site_id):
    firstname   = request.form['firstname']
    lastname    = request.form['lastname']
    email       = request.form['email']
    rating      = request.form['rating']
    review_text = request.form['review_text']
    cur = mysql.connection.cursor()
    cur.execute(
        "SELECT Visitor_ID FROM Visitors WHERE Email = %s", (email,))
    visitor = cur.fetchone()
    if visitor:
        visitor_id = visitor[0]
    else:
        cur.execute("""
            INSERT INTO Visitors (FirstName, LastName, Email)
            VALUES (%s, %s, %s)
        """, (firstname, lastname, email))
        mysql.connection.commit()
        visitor_id = cur.lastrowid
    cur.execute("""
        INSERT INTO Review (Rating, Review_Text, Review_Date, Visitor_ID, Site_ID)
        VALUES (%s, %s, CURDATE(), %s, %s)
    """, (rating, review_text, visitor_id, site_id))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('site_detail', site_id=site_id))

# ── Contribute ────────────────────────────────────────────────

@app.route("/contribute", methods=["GET", "POST"])
@login_required
def contribute():
    if request.method == "POST":
        firstname         = request.form['firstname']
        lastname          = request.form['lastname']
        email             = request.form['email']
        site_name         = request.form['site_name']
        description       = request.form['description']
        historical_period = request.form['historical_period']
        unesco_status     = request.form['unesco_status']
        city              = request.form['city']
        area              = request.form.get('area', '')
        district          = request.form['district']
        state             = request.form['state']
        pincode           = request.form.get('pincode', '')
        image_url         = request.form.get('image_url', '')

        cur = mysql.connection.cursor()
        cur.execute(
            "SELECT Visitor_ID FROM Visitors WHERE Email = %s", (email,))
        visitor = cur.fetchone()
        if visitor:
            visitor_id = visitor[0]
        else:
            cur.execute("""
                INSERT INTO Visitors (FirstName, LastName, Email)
                VALUES (%s, %s, %s)
            """, (firstname, lastname, email))
            mysql.connection.commit()
            visitor_id = cur.lastrowid

        cur.execute("""
            INSERT INTO Contribution (Status, date_submitted, Visitor_ID)
            VALUES ('Pending', CURDATE(), %s)
        """, (visitor_id,))
        mysql.connection.commit()
        contribution_id = cur.lastrowid

        cur.execute("""
            INSERT INTO pending_sites
                (Site_Name, Description, Historical_Period, UNESCO_Status,
                 City, Area, District, State, Pincode, Image_Url,
                 Submitted_By, Visitor_ID, Contribution_ID, submitted_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, CURDATE())
        """, (site_name, description, historical_period, unesco_status,
              city, area, district, state, pincode, image_url,
              firstname + ' ' + lastname, visitor_id, contribution_id))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('sites'))

    return render_template("contribute.html")

# ── Contribute Info ───────────────────────────────────────────

@app.route("/contribute_info/<int:site_id>", methods=["POST"])
def contribute_info(site_id):
    name  = request.form['name']
    email = request.form['email']
    parts = name.strip().split(' ', 1)
    firstname = parts[0]
    lastname  = parts[1] if len(parts) > 1 else ''
    cur = mysql.connection.cursor()
    cur.execute(
        "SELECT Visitor_ID FROM Visitors WHERE Email = %s", (email,))
    visitor = cur.fetchone()
    if visitor:
        visitor_id = visitor[0]
    else:
        cur.execute("""
            INSERT INTO Visitors (FirstName, LastName, Email)
            VALUES (%s, %s, %s)
        """, (firstname, lastname, email))
        mysql.connection.commit()
        visitor_id = cur.lastrowid
    cur.execute("""
        INSERT INTO Contribution (Status, date_submitted, Visitor_ID, Site_ID)
        VALUES ('Pending', CURDATE(), %s, %s)
    """, (visitor_id, site_id))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('site_detail', site_id=site_id))

# ── Locations ─────────────────────────────────────────────────

@app.route("/locations")
def locations():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Location")
    locations = cur.fetchall()
    cur.close()
    return render_template("locations.html", locations=locations)

# ── Architecture ──────────────────────────────────────────────

@app.route("/architecture")
def architecture():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT a.*, h.Site_Name FROM Architecture_Style a
        LEFT JOIN Heritage_Site h ON a.Site_ID = h.Site_ID
    """)
    architectures = cur.fetchall()
    cur.close()
    return render_template("architecture.html", architectures=architectures)

# ── Visitors — ADMIN ONLY ─────────────────────────────────────

@app.route("/visitors")
@admin_required
def visitors():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Visitors")
    visitors = cur.fetchall()
    cur.close()
    return render_template("visitors.html", visitors=visitors)

# ── Reviews ───────────────────────────────────────────────────

@app.route("/reviews")
def reviews():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT r.*, v.FirstName, v.LastName, h.Site_Name
        FROM Review r
        LEFT JOIN Visitors v ON r.Visitor_ID = v.Visitor_ID
        LEFT JOIN Heritage_Site h ON r.Site_ID = h.Site_ID
        ORDER BY r.Review_Date DESC
    """)
    reviews = cur.fetchall()
    cur.close()
    return render_template("reviews.html", reviews=reviews)

# ── Contributions — ADMIN ONLY ────────────────────────────────

@app.route("/contributions")
@admin_required
def contributions():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT c.Contribution_ID, c.Status, c.date_submitted,
               c.Contribution_date,
               v.FirstName, v.LastName,
               COALESCE(h.Site_Name, p.Site_Name) as Site_Name,
               p.Pending_ID
        FROM Contribution c
        LEFT JOIN Visitors v ON c.Visitor_ID = v.Visitor_ID
        LEFT JOIN Heritage_Site h ON c.Site_ID = h.Site_ID
        LEFT JOIN pending_sites p ON c.Contribution_ID = p.Contribution_ID
        ORDER BY c.date_submitted DESC
    """)
    contributions = cur.fetchall()

    cur.execute("""
        SELECT Contribution_ID, Site_Name, Description,
               Historical_Period, UNESCO_Status,
               City, Area, District, State, Pincode,
               Image_Url, Submitted_By
        FROM pending_sites
    """)
    rows = cur.fetchall()
    cur.close()

    pending_map = {}
    for row in rows:
        pending_map[row[0]] = {
            'site_name':    row[1],
            'description':  row[2],
            'period':       row[3],
            'unesco':       row[4],
            'city':         row[5],
            'area':         row[6],
            'district':     row[7],
            'state':        row[8],
            'pincode':      row[9],
            'image_url':    row[10],
            'submitted_by': row[11]
        }

    return render_template("contributions.html",
        contributions=contributions,
        pending_map=pending_map)

# ── Contribution Stats — ADMIN ONLY ──────────────────────────

@app.route("/contribution_stats")
@admin_required
def contribution_stats():
    cur = mysql.connection.cursor()

    # Top contributors overall
    cur.execute("""
        SELECT v.FirstName, v.LastName, COUNT(c.Contribution_ID) as total
        FROM Contribution c
        LEFT JOIN Visitors v ON c.Visitor_ID = v.Visitor_ID
        GROUP BY c.Visitor_ID, v.FirstName, v.LastName
        ORDER BY total DESC
        LIMIT 10
    """)
    top_contributors = cur.fetchall()

    # Active person of current month
    cur.execute("""
        SELECT v.FirstName, v.LastName, COUNT(c.Contribution_ID) as total
        FROM Contribution c
        LEFT JOIN Visitors v ON c.Visitor_ID = v.Visitor_ID
        WHERE MONTH(c.date_submitted) = MONTH(CURDATE())
        AND YEAR(c.date_submitted) = YEAR(CURDATE())
        GROUP BY c.Visitor_ID, v.FirstName, v.LastName
        ORDER BY total DESC
        LIMIT 1
    """)
    active_person = cur.fetchone()

    # Month wise contribution count
    cur.execute("""
        SELECT MONTHNAME(MIN(date_submitted)) as month,
               YEAR(date_submitted) as year,
               COUNT(*) as total
        FROM Contribution
        GROUP BY YEAR(date_submitted), MONTH(date_submitted)
        ORDER BY YEAR(date_submitted) DESC, MONTH(date_submitted) DESC
    """)
    monthly_stats = cur.fetchall()

    cur.close()
    return render_template("contribution_stats.html",
        top_contributors=top_contributors,
        active_person=active_person,
        monthly_stats=monthly_stats)

# ── Gallery ───────────────────────────────────────────────────

@app.route("/gallery")
def gallery():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT i.*, h.Site_Name FROM Image_Gallery i
        LEFT JOIN Heritage_Site h ON i.Site_ID = h.Site_ID
    """)
    images = cur.fetchall()
    cur.close()
    return render_template("gallery.html", images=images)

# ── Admins — ADMIN ONLY ───────────────────────────────────────

@app.route("/admins")
@admin_required
def admins():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Admin")
    admins = cur.fetchall()
    cur.close()
    return render_template("admins.html", admins=admins)

# ── Approve Contribution — ADMIN ONLY ────────────────────────

@app.route("/approve_contribution/<int:contribution_id>", methods=["POST"])
@admin_required
def approve_contribution(contribution_id):
    admin_id = session.get('user_id')
    cur = mysql.connection.cursor()

    cur.execute("""
        SELECT Site_Name, Description, Historical_Period, UNESCO_Status,
               City, Area, District, State, Pincode, Image_Url, Submitted_By
        FROM pending_sites WHERE Contribution_ID = %s
    """, (contribution_id,))
    pending = cur.fetchone()

    if pending:
        site_name, description, historical_period, unesco_status, \
        city, area, district, state, pincode, image_url, submitted_by = pending

        cur.execute("""
            INSERT INTO Location (city, area, pincode, state, district)
            VALUES (%s, %s, %s, %s, %s)
        """, (city, area, pincode, state, district))
        mysql.connection.commit()
        location_id = cur.lastrowid

        cur.execute("""
            INSERT INTO Heritage_Site
                (Site_Name, Description, Historical_Period, UNESCO_Status, Location_ID)
            VALUES (%s, %s, %s, %s, %s)
        """, (site_name, description, historical_period, unesco_status, location_id))
        mysql.connection.commit()
        site_id = cur.lastrowid

        if image_url:
            cur.execute("""
                INSERT INTO Image_Gallery (Image_Url, Upload_Date, Uploaded_By, Site_ID)
                VALUES (%s, CURDATE(), %s, %s)
            """, (image_url, submitted_by, site_id))
            mysql.connection.commit()

        cur.execute("""
            UPDATE Contribution
            SET Status = 'Approved', Contribution_date = CURDATE(), Site_ID = %s
            WHERE Contribution_ID = %s
        """, (site_id, contribution_id))
        mysql.connection.commit()

        cur.execute(
            "DELETE FROM pending_sites WHERE Contribution_ID = %s",
            (contribution_id,))
        mysql.connection.commit()

    else:
        cur.execute("""
            UPDATE Contribution
            SET Status = 'Approved', Contribution_date = CURDATE()
            WHERE Contribution_ID = %s
        """, (contribution_id,))
        mysql.connection.commit()

    cur.execute("""
        SELECT * FROM Admin_Verifies_Contribution
        WHERE Admin_ID = %s AND Contribution_ID = %s
    """, (admin_id, contribution_id))
    if not cur.fetchone():
        cur.execute("""
            INSERT INTO Admin_Verifies_Contribution (Admin_ID, Contribution_ID)
            VALUES (%s, %s)
        """, (admin_id, contribution_id))
        mysql.connection.commit()

    cur.close()
    return redirect(url_for('contributions'))

# ── Reject Contribution — ADMIN ONLY ─────────────────────────

@app.route("/reject_contribution/<int:contribution_id>", methods=["POST"])
@admin_required
def reject_contribution(contribution_id):
    admin_id = session.get('user_id')
    cur = mysql.connection.cursor()

    cur.execute("""
        SELECT Pending_ID FROM pending_sites WHERE Contribution_ID = %s
    """, (contribution_id,))
    pending = cur.fetchone()

    if pending:
        cur.execute(
            "DELETE FROM pending_sites WHERE Contribution_ID = %s",
            (contribution_id,))
        mysql.connection.commit()
        cur.execute("""
            UPDATE Contribution
            SET Status = 'Rejected', Contribution_date = CURDATE()
            WHERE Contribution_ID = %s
        """, (contribution_id,))
        mysql.connection.commit()

    else:
        cur.execute(
            "SELECT Site_ID FROM Contribution WHERE Contribution_ID = %s",
            (contribution_id,))
        result = cur.fetchone()
        if result and result[0]:
            site_id = result[0]
            cur.execute("""
                UPDATE Contribution
                SET Status = 'Rejected', Contribution_date = CURDATE(),
                    Site_ID = NULL
                WHERE Contribution_ID = %s
            """, (contribution_id,))
            mysql.connection.commit()
            cur.execute(
                "DELETE FROM Image_Gallery WHERE Site_ID = %s", (site_id,))
            mysql.connection.commit()
            cur.execute(
                "SELECT Location_ID FROM Heritage_Site WHERE Site_ID = %s",
                (site_id,))
            loc = cur.fetchone()
            cur.execute(
                "DELETE FROM Heritage_Site WHERE Site_ID = %s", (site_id,))
            mysql.connection.commit()
            if loc:
                cur.execute(
                    "DELETE FROM Location WHERE Location_ID = %s", (loc[0],))
                mysql.connection.commit()
        else:
            cur.execute("""
                UPDATE Contribution
                SET Status = 'Rejected', Contribution_date = CURDATE()
                WHERE Contribution_ID = %s
            """, (contribution_id,))
            mysql.connection.commit()

    cur.execute("""
        SELECT * FROM Admin_Verifies_Contribution
        WHERE Admin_ID = %s AND Contribution_ID = %s
    """, (admin_id, contribution_id))
    if not cur.fetchone():
        cur.execute("""
            INSERT INTO Admin_Verifies_Contribution (Admin_ID, Contribution_ID)
            VALUES (%s, %s)
        """, (admin_id, contribution_id))
        mysql.connection.commit()

    cur.close()
    return redirect(url_for('contributions'))


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)