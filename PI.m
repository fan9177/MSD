close all;
s=tf('s');
kp=2500;
kd=5;
ourpi=kp*(1+kd/s);
margin(ourpi*xF12/(1+ourpi*xF12))
stepinfo(ourpi*xF12/(1+ourpi*xF12))