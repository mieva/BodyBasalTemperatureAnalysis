#!/usr/local/anaconda/bin/python
# -*- coding: utf-8 -*-

import MySQLdb as mdb
import ROOT
import numpy as n
import ROOTgarbagecol


con = mdb.connect('localhost', 'michela', 'mieva', 'basaltemp');

with con:
    
    cur = con.cursor();
    cur.execute("SELECT * FROM Chart WHERE name = 'michela' AND ciclenum = 1");

    ndim = cur.rowcount;

    x = n.array([0.0]*ndim, dtype=float);
    y = n.array([0.0]*ndim, dtype=float);
    

    for i in range(cur.rowcount):
        
        row = cur.fetchone();
        print row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8]; 

        x[i] = row[3];
        y[i] = row[2];

print x;
print y;

ROOTgarbagecol.SetGarbageCollection();

# Def for ROOT draw()
ROOT.TCanvas.__init__._creates = False
ROOT.TH1D.__init__._creates = False
ROOT.TGraph.__init__._creates = False
ROOT.TF1.__init__._creates = False

 #tb = ROOT.TBrowser();
g = ROOT.TGraph(len(x), x,y);
g.SetTitle("Basal temperature chart");
g.GetXaxis().SetTitle("Day of cicle");
g.GetYaxis().SetTitle("Temperature");
g.Draw("AL");
