# -*- coding: utf-8 -*-
"""
Created on Wed Jan 25 15:58:32 2017

@author: morris
"""
# easternscheldt, uses xarrays
import matplotlib
matplotlib.use('Agg')
import oceanwaves
import matplotlib.pyplot as plt
import os
import sys
import numpy as np
from scipy.integrate import trapz, simps

def plspectra(pathInp, pathOut):
    
    if pathInp[-3:-1] == "NZ":
        region="NZ";
    else:
        region="OS";
    
    nameRun=os.path.split(pathInp)[1];    
    
    # get directory of land boundary
    tmp=os.path.split(pathInp)[0];
    tmp2=os.path.split(tmp)[0];
    tmp3=os.path.split(tmp2)[0];
    lb_file=os.path.join(tmp3, '0prepare', 'PhysChecks', 'landboundary.txt'); 
    
    Hs=[];
    Tp=[];
    # load results from file
    if region=='NZ':
        ow = oceanwaves.from_swan(os.path.join(pathInp, nameRun +"_04.SP1")) # obs
        ow2 = oceanwaves.from_swan(os.path.join(pathInp, nameRun +"_02.SP1")) # check
        
        # test locations intered in figures for
        Locations1=np.array([5,3,1,9,4]);
        Locations2=np.array([7]);
    else: # OS
        ow = oceanwaves.from_swan(os.path.join(pathInp,nameRun +"_05.SP1"))
        tab=os.path.join(pathInp,nameRun +"_05.TAB")
        # test locations intered in figures for
        Locations1=np.array([1,3,4,8,5,6]);
        Locations2=np.array([9,12,14,15,22,19]);

        fp=open(tab);
        
        counter=1;                
        # skip header
        for m in range(0,8):
           line=fp.readline();                        
        while line:
           if any(counter==Locations1) or any(counter==Locations2):
               cells=line.split();
               Hs.append(cells[3]);
               Tp.append(cells[4]);
           line=fp.readline();
           counter=counter+1; 
        fp.close()    
         

    lbx=[];
    lby=[];
    
    # load landboundary
    file = open(lb_file,'r') 
    for line in file:
        cells=line.split()
        lbx.append(cells[0]);
        lby.append(cells[1]);
    
    # make figure directory
    pathFigure = os.path.join(pathOut, 'spectra')
    if not os.path.isdir(pathFigure):
        os.mkdir(pathFigure)
    
#    # plot locations
#    fig1=plt.figure(1)
#    plt.plot(lbx,lby, 'k')
#    if region=='NZ':
#        for i in range(0, len(Locations1)):
#            plt.text(ow.location.location_x[Locations1[i]-1]-700, ow.location.location_y[Locations1[i]-1]-200, str(Locations1[i]) )
#        for i in range(0, len(Locations2)):
#            plt.text(ow2.location.location_x[Locations2[i]-1]-700, ow2.location.location_y[Locations2[i]-1]-200, str(Locations2[i]) )
#        plt.plot(ow.location.location_x[Locations1-1], ow.location.location_y[Locations1-1], '.r', ms=15)
#        plt.plot(ow2.location.location_x[Locations2-1], ow2.location.location_y[Locations2-1], '.b', ms=15)
#        plt.axis('equal')
#        plt.xlim((10000, 45000))
#        plt.ylim((400000, 425000))
#    else:
#        for i in range(0, len(Locations1)):
#            plt.text(ow.location.location_x[Locations1[i]-1], ow.location.location_y[Locations1[i]-1], str(Locations1[i]) )
#        for i in range(0, len(Locations2)):
#            plt.text(ow.location.location_x[Locations2[i]-1], ow.location.location_y[Locations2[i]-1], str(Locations2[i]) )
#        plt.plot(ow.location.location_x[Locations1-1], ow.location.location_y[Locations1-1], '.r', ms=15)
#        plt.plot(ow.location.location_x[Locations2-1], ow.location.location_y[Locations2-1], '.b', ms=15)
#        plt.axis('equal')
#        plt.xlim((30000, 80000))
#        plt.ylim((380000, 415000))
    
#    plt.xlabel('X[m]');
#    plt.ylabel('Y[m]');
#    fig1.savefig(os.path.join(pathFigure, nameRun + "_loc_" + region), dpi=200)   
#    plt.close(fig1);    
    
    # plot spectr   
    for i in range(0,len(Locations1)):
        fig2=plt.figure(2, figsize=(10,10))
        plt.subplot(3,2,i+1)    	
        energy2=[]
        freq2=[]  
        for j in range(0, len(ow.frequency)):
            if ow.energy[Locations1[i]-1,j]>0:
                energy2.append(ow.energy[Locations1[i]-1,j])
                freq2.append(ow.frequency[j])
        Hm0_spec=4*(trapz(energy2, freq2))**0.5;
        Tp_spec=1/freq2(np.where(max(energy2)==energy2));
        plt.plot(freq2,energy2)
        plt.xlim(0,2.5);
        plt.xlabel('Freq (Hz)')
        plt.ylabel('E ($m^{2}$/Hz)')
        plt.title('Oosterschelde; loc' + str(Locations1[i]))
        plt.tight_layout()
    
    if region == 'OS':
	    fig2.savefig(os.path.join(pathFigure, nameRun+"_spectra_"+region+"_1"), dpi=200)   
	    plt.close(fig2);   
      
    for i in range(0,len(Locations2)):
        if region == 'NZ':
            plt.subplot(3,2,6);
        else:
            fig3=plt.figure(3, figsize=(10,10))
            plt.subplot(3,2,i+1)
        energy2=[];
        freq2=[];  
        for j in range(0, len(ow.frequency)):
            if ow.energy[Locations2[i]-1,j]>0:
                energy2.append(ow.energy[Locations2[i]-1,j])
                freq2.append(ow.frequency[j])
        plt.plot(freq2,energy2)
        plt.xlim(0,2.5);
        plt.xlabel('Freq (Hz)')
        plt.ylabel('E ($m^{2}$/Hz)')
        plt.title('Oosterschelde; loc' + str(Locations2[i]))
        plt.tight_layout()
    
    if region == "NZ":
        fig2.savefig(os.path.join(pathFigure, nameRun+"_spectra_" + region), dpi=200)    
        plt.close(fig2); 
    else:
	    fig3.savefig(os.path.join(pathFigure, nameRun+"_spectra_"+ region + "_2"), dpi=200)
	    plt.close(fig3);       

if __name__=='__main__':
    if len(sys.argv) > 1:
        plspectra(sys.argv[1], sys.argv[2])  
    else:
        nameRun="U24D023Lm200OOa";
        pathInp=r"p:\1230058-os\swanmodel\TEST01\RUN_TEST\D023" + os.path.sep + nameRun
        pathOut=r"p:\1230058-os\swanmodel\TEST01\CONTROL"
    
        plspectra(pathInp, pathOut);
