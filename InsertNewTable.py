#!/usr/bin/python
# -*- coding: utf-8 -*-

import MySQLdb as mdb

con = mdb.connect('localhost', 'michela', 'mieva', 'basaltemp');

#if(!$con )
#{
#  die('Could not connect: ' . mysql_error());
#}
#echo 'Connected successfully as michela <br />';

with con:
    
    cur = con.cursor();
    cur.execute("CREATE TABLE Chart ( \
                 Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, \
                 Name VARCHAR(25), \
                 Temp FLOAT UNSIGNED, \
                 CicleDay INT UNSIGNED, \
                 Day INT UNSIGNED, \
                 Month INT UNSIGNED, \
                 Year INT UNSIGNED, \
                 CMType VARCHAR(10), \
                 Sex VARCHAR(5))");

    # Show created table content
    cur.execute("DESC Chart");


