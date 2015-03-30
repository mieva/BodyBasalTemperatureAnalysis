#!/usr/local/anaconda/bin/python
# -*- coding: utf-8 -*-

import MySQLdb as mdb
import ROOT
import numpy as n

con = mdb.connect('localhost', 'michela', 'mieva', 'basaltemp');

with con:
    
    cur = con.cursor();

#    cur.execute("SELECT Temp, CicleDay FROM Chart");
#    ndim = cur.rowcount;
#    a = n.fromiter(cur.fetchall(), dtype=[('y', n.float64), ('x', n.uint8)]*ndim);
#   a = a.view(n.float64).reshape(-1, ndim);

    cur.execute("SELECT CicleDay FROM Chart");
    ndim = cur.rowcount;

    x = n.fromiter(cur.fetchall(), count=-1, dtype=[('', n.uint8)]*ndim);
    x = x.view(n.uint8).reshape(-1, ndim);

    cur.execute("SELECT Temp FROM Chart");
    ndim = cur.rowcount;

    y = n.fromiter(cur.fetchall(), count=-1, dtype=[('', n.float64)]*ndim);
    y = y.view(n.float64).reshape(-1, ndim);

    


g = ROOT.TGraph(len(x), x,y);
g.SetTitle("Basal temperature chart");
g.GetXaxis().SetTitle("Day of cicle");
g.GetYaxis().SetTitle("Temperature");
g.Draw("AL");
