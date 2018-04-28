% Visualizing Volume Reverberation effect on Low, Moderatea and High Particle Densities % 

clc;
clear all;
close all;
f=logspace(1,7,100)
Sp=[-50 -70 -90];
[x, y] = meshgrid(Sp, f)
V = x +7.*log10(y)
semilogx(f,V,'LineWidth',2)
hold on