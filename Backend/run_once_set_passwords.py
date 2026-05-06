import bcrypt
import MySQLdb
from dotenv import load_dotenv
import os

load_dotenv()

db = MySQLdb.connect(
    host=os.getenv('MYSQL_HOST'),
    user=os.getenv('MYSQL_USER'),
    passwd=os.getenv('MYSQL_PASSWORD'),
    db=os.getenv('MYSQL_DB')
)
cur = db.cursor()

# ── Make sure Password column exists in both tables ───────────
cur.execute("""
    ALTER TABLE Admin 
    ADD COLUMN IF NOT EXISTS Password VARCHAR(255)
""")
cur.execute("""
    ALTER TABLE Visitors 
    ADD COLUMN IF NOT EXISTS Password VARCHAR(255)
""")
db.commit()

# ── Set hashed passwords ──────────────────────────────────────
admin_hashed   = bcrypt.hashpw(b'heritage@123', bcrypt.gensalt()).decode()
visitor_hashed = bcrypt.hashpw(b'heritage@123', bcrypt.gensalt()).decode()

cur.execute("UPDATE Admin SET Password = %s", (admin_hashed,))
cur.execute("UPDATE Visitors SET Password = %s", (visitor_hashed,))
db.commit()

cur.close()
db.close()

print("Done!")
print("All admins    → password: heritage@123")
print("All visitors  → password: heritage@123")
print()
print("Admin login URL: http://127.0.0.1:5000/admin/login")
print("Visitor login URL: http://127.0.0.1:5000/login")