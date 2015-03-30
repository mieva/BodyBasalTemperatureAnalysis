#!/usr/bin/python
# -*- coding: utf-8 -*-

import MySQLdb as mdb

con = mdb.connect('localhost', 'michela', 'mieva', 'basaltemp');
cur = con.cursor();

ni = raw_input('How many temp you want to insert?  \n');
try:
    numiter = int(ni);
except ValueError:
    print("Invalid number");

for i in range(0, numiter):
#    print("done!");
    name, temp, cicleday, day, month, year, cmtype, sex, ciclenum = raw_input("Please, enter values here: name, temp, day of cicle, date(D/M/Y), CM type, Sex, cicle number \n").split();
    try:
        temp = float(temp);
        cicleday = int(cicleday);
        day = int(day);
        month = int(month);
        year = int(year);
        ciclenum = int(ciclenum);

        # print name, temp, cicleday, day, month, year, cmtype, sex;

    except ValueError:
        print("Some invalid number");

#    with con:
    sql = "INSERT INTO Chart(Name, Temp, CicleDay, Day, Month, Year, CMType, Sex, CicleNumber) \
               VAlUES('%s', '%f', '%d', '%d', '%d', '%d', '%c', '%c', '%d')" % \
               (name, temp, cicleday, day, month, year, cmtype, sex, ciclenum);
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

#    con.commit();

    
#except mdb.Error, e:
  
#    if con:
#        con.rollback()
        
#    print "Error %d: %s" % (e.args[0],e.args[1])
#    sys.exit(1)
    

