# -*- coding: utf-8 -*-
"""
Created on Mon Feb 13 09:59:58 2017

@author: morris
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Feb 02 15:39:27 2017

@author: morris
"""
import os
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.pyplot import cm 

#def checkTransmission(pathInp, pathOut):

# specify which results interested in
pathInp=r"p:\1230058-os\swanmodel\TEST01\RUN_TEST4";
pathOut=r'p:\1230058-os\swanmodel\TEST01\CONTROL\HsforLocAndWS';
#checkTransmission(pathInp, pathOut);   

# range of conditions that will be available
Directions=np.array([203, 225, 248, 270, 293, 315, 338, 360]);
WindSpd=np.arange(10,54,4);
WatLev=np.concatenate((np.arange(-2,2.76,0.25),np.arange(2.99,3,2),np.arange(3,6.6,0.5)), axis=0)
OpenClose=['O', 'D']

# initialize variables
WH=[];
X=[];
Y=[];
RunID_avail=[]

# define random colors
color=cm.rainbow(np.linspace(0,1,len(WindSpd)))

# initialize structures
result = np.zeros((len(WindSpd), 2038))* np.nan # 2039 is the number of locations in TAB01
xVal=np.zeros(2038);
xVal=np.linspace(1, 2038, num=2038)

def find_intersections(A, B):

    # min, max and all for arrays
    amin = lambda x1, x2: np.where(x1<x2, x1, x2)
    amax = lambda x1, x2: np.where(x1>x2, x1, x2)
    aall = lambda abools: np.dstack(abools).all(axis=2)
    slope = lambda line: (lambda d: d[:,1]/d[:,0])(np.diff(line, axis=0))

    x11, x21 = np.meshgrid(A[:-1, 0], B[:-1, 0])
    x12, x22 = np.meshgrid(A[1:, 0], B[1:, 0])
    y11, y21 = np.meshgrid(A[:-1, 1], B[:-1, 1])
    y12, y22 = np.meshgrid(A[1:, 1], B[1:, 1])

    m1, m2 = np.meshgrid(slope(A), slope(B))
    m1inv, m2inv = 1/m1, 1/m2

    yi = (m1*(x21-x11-m2inv*y21) + y11)/(1 - m1*m2inv)
    xi = (yi - y21)*m2inv + x21

    xconds = (amin(x11, x12) < xi, xi <= amax(x11, x12), 
              amin(x21, x22) < xi, xi <= amax(x21, x22) )
    yconds = (amin(y11, y12) < yi, yi <= amax(y11, y12),
              amin(y21, y22) < yi, yi <= amax(y21, y22) )

    return xi[aall(xconds)], yi[aall(yconds)]



# determine available results
for i in range(0, len(Directions)):
    if os.path.isdir(pathInp + os.path.sep + "D" + str(Directions[i])):
        pathRes2=pathInp + os.path.sep + "D" + str(Directions[i]);
        for k in range(0, len(WatLev)):
            for l in range(0, len(OpenClose)):
                # initialize fig;
                fig=plt.figure(1, figsize=(30,80))
                figPlot=0;
                for j in range(0, len(WindSpd)):
                    if WatLev[k]<0:
                        WatKey='Lm';
                        WatLev_tmp=WatLev[k]*-1;
                    else:
                        WatKey='Lp';
                        WatLev_tmp=WatLev[k];
              
                    RunID_O="U" + str(WindSpd[j]) +"D" + str(Directions[i]) + WatKey + str(int(WatLev_tmp*100)) + "O" + OpenClose[l] + "a"
                    Tab_O = RunID_O + "_01.TAB"
                     
                    if os.path.exists(pathRes2 +os.path.sep +  RunID_O +os.path.sep +Tab_O):
                        fp=open(pathRes2 +os.path.sep +  RunID_O +os.path.sep +Tab_O) 
                        #skip header
                        counter=0;
                        for m in range(0,9):
                            line=fp.readline();                        
                        while line:
                            cells=line.split();
                            result[j,counter]=cells[3];
                            counter=counter+1;
                            line=fp.readline();
                        fp.close()
                        
                        if not all(np.isnan(result[j,:])):
#                            plt.plot(range(1, 2039), result[j,:], "-", c=color[j], label=str(WindSpd[j])+"m/s NZ")                         
                             result[j,result[j,:]==-9]=np.nan;
                             xVal = np.ma.masked_where(np.isnan(result[j,:]), xVal)
                             yVal = np.ma.masked_where(np.isnan(result[j,:]), result[j,:])
                             plt.subplot(2,1,1)                                
                             plt.plot(xVal[0:1038], yVal[0:1038], c=color[j], label=str(WindSpd[j])+"m/s")
                             plt.subplot(2,1,2)                                
                             plt.plot(xVal[1038:], yVal[1038:], c=color[j], label=str(WindSpd[j])+"m/s")
                             figPlot=1;
                             if j != len(WindSpd)-1:
                                 x,y=find_intersections(yVal, yVal)
                if figPlot==1:
                    plt.xlabel("Location #");
                    plt.ylabel("Wave Height [m]")
                    plt.legend(bbox_to_anchor=(1.01, 1), loc=2, borderaxespad=0.)
                    fig.savefig(pathOut + os.path.sep + "Dir" + str(Directions[i]) + "_WL" + str(WatLev[k]) + "_" + str(OpenClose[l])   +".png" , dpi=200)   
                    plt.close(fig);
                                        


