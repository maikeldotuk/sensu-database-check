import os
import sys
import mysql.connector

MYSQL_USER=os.getenv('MYSQL_USER')
MYSQL_PASS=os.getenv('MYSQL_PASS')
MYSQL_HOST=os.getenv('MYSQL_HOST')
MYSQL_PORT=os.environ.get('MYSQL_PORT',3306)

try:
    mydb = mysql.connector.connect(
        host=MYSQL_HOST,
        user=MYSQL_USER,
        password=MYSQL_PASS,
        port=MYSQL_PORT
    )
    mycursor = mydb.cursor()
    mycursor.execute("SHOW DATABASES")
    names = []
    for x in mycursor:
        names.append(x[0])
    print('MYSQL is up and running with databases:' + str(names))
    sys.exit(0)
except Exception as err:
    print(f"Database Connection failed. Error: {err}")
    sys.exit(2)