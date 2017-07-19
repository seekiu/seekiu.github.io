# 2D flow around a cylinder
## partly rewritten by Qiang Chen with numba to greatly enhance performance.

import numpy as np
from numpy import linalg
import matplotlib.pyplot as plt
from matplotlib import cm
from numba import jit

###### Flow definition #########################################################
maxIter = 200000 # Total number of time iterations.
Re      = 220.0  # Reynolds number.
nx = 520; ny = 180; ly=ny-1.0; q = 9 # Lattice dimensions and populations.
cx = nx/4; cy=ny/2; r=ny/9;          # Coordinates of the cylinder.
uLB     = 0.04                       # Velocity in lattice units.
nulb    = uLB*r/Re; omega = 1.0 / (3.*nulb+0.5); # Relaxation parameter.

###### Lattice Constants #######################################################
c = np.array([(x,y) for x in [0,-1,1] for y in [0,-1,1]]) # Lattice velocities.
t = 1./36. * np.ones(q)                                   # Lattice weights.
t[np.asarray([linalg.norm(ci)<1.1 for ci in c])] = 1./9.; t[0] = 4./9.
noslip = [c.tolist().index((-c[i]).tolist()) for i in range(q)] 
i1 = np.arange(q)[np.asarray([ci[0]<0  for ci in c])] # Unknown on right wall.
i2 = np.arange(q)[np.asarray([ci[0]==0 for ci in c])] # Vertical middle.
i3 = np.arange(q)[np.asarray([ci[0]>0  for ci in c])] # Unknown on left wall.

###### Function Definitions ####################################################
sumpop = lambda fin: np.sum(fin,axis=0) # Helper function for density computation.

# def equilibrium(rho,u):              # Equilibrium distribution function.
#     cu   = 3.0 * np.dot(c,u.transpose(1,0,2))
#     usqr = 3./2.*(u[0]**2+u[1]**2)
#     feq = np.zeros((q,nx,ny))
#     for i in range(q): feq[i,:,:] = rho*t[i]*(1.+cu[i]+0.5*cu[i]**2-usqr)
#     return feq
@jit
def equilibrium(rho, u):
    feq = np.zeros([q,nx,ny])
    for x in range(nx):
        for y in range(ny):
            for i in range(q):
                cu = 3.0 * (c[i,0] * u[0,x,y] + c[i,1] * u[1,x,y])
                usqr = 3./2. * (u[0,x,y]**2 + u[1,x,y]**2)
                feq[i,x,y] = rho[x,y] * \
                        t[i] * \
                        (1+cu+0.5*cu**2-usqr)
    return feq

@jit
def evolution(fin, rho, u):
    fin[i1,-1,:] = fin[i1,-2,:] # Right wall: outflow condition.
    rho[:,:] = sumpop(fin)           # Calculate macroscopic density and velocity.
    u[:,:,:] = np.dot(c.transpose(), fin.transpose((1,0,2)))/rho

    u[:,0,:] =vel[:,0,:] # Left wall: compute density from known populations.
    rho[0,:] = 1./(1.-u[0,0,:]) * (sumpop(fin[i2,0,:])+2.*sumpop(fin[i1,0,:]))

    feq = equilibrium(rho,u) # Left wall: Zou/He boundary condition.
    fin[i3,0,:] = fin[i1,0,:] + feq[i3,0,:] - fin[i1,0,:]
    fout = fin - omega * (fin - feq)  # Collision step.
    for i in range(q): fout[i,obstacle] = fin[noslip[i],obstacle]
    for i in range(q): # Streaming step.
        fin[i,:,:] = np.roll(np.roll(fout[i,:,:],c[i,0],axis=0),c[i,1],axis=1)

###### Setup: cylindrical obstacle and velocity inlet with perturbation ########
obstacle = np.fromfunction(lambda x,y: (x-cx)**2+(y-cy)**2<r**2, (nx,ny))
vel = np.fromfunction(lambda d,x,y: (1-d)*uLB*(1.0+1e-4*np.sin(y/ly*2*np.pi)),(2,nx,ny))
feq = equilibrium(np.ones([nx,ny], dtype='f8'), vel); fin = feq.copy()

###### Main time loop ##########################################################
rho = np.ones([nx, ny], dtype='f8')
u = np.ones([2, nx, ny], dtype='f8')
for time in range(maxIter):
    evolution(fin, rho, u)
 
    if (time%1000==0 and time != 0): # Visualization
        print('Writing fig.')
        plt.clf(); plt.imshow(np.sqrt(u[0]**2+u[1]**2).transpose(),cmap=cm.Reds)
        plt.savefig("vel."+str(time/100).zfill(4)+".png")

