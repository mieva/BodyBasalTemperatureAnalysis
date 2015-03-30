#!/usr/local/anaconda/bin/python
# -*- coding: utf-8 -*-

import MySQLdb as mdb

con = mdb.connect('localhost', 'michela', 'mieva', 'basaltemp');
cur = con.cursor();

# Insert new column
cur = con.cursor();
cur.execute("ALTER TABLE Chart ADD CicleNumber INT UNSIGNED");

ni = raw_input('How many values do you want to insert?  \n');
try:
    numiter = int(ni);
except ValueError:
    print("Invalid number");

for i in range(0, numiter):
#    print("done!");
    ciclenumber = raw_input("Please, enter values here: cicle number \n");
    try:
        ciclenumber = int(ciclenumber);

        print ciclenumber;

    except ValueError:
        print("Some invalid number");

#    with con:
    sql = "INSERT INTO Chart(CicleNumber) \
               VAlUES('%d')" % \
               (ciclenumber);
    try:
        cur.execute(sql);
        con.commit();
    except:
        # Rollback in case there is any error
        con.rollback();

# disconnect from server
#finally:  
if con:    
    con.close();
    

