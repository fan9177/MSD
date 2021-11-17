%% 
%Initializing parameters
%syms m1 m2 k1 k2 c2 c1 f1 f2;

m1=3.72; m2=0.0045; k1=1500; k2=2650; c1=12; c2=0.6;
M=[m1,0;0,m2];
K=[k1+k2,-k2;-k2,k2];
C=[c1+c2,-c2;-c2,c2];
%F=[f1-f2;f2];

%%
%Covnert to  State-Space Model
clc
%A00=zeros(2,2);
%A11=eye(2);
%A=[A00 A11;-inv(M)*K -inv(M)*C];
%[phi,frq]=eig(A); %get the eigenvalue(frq) and eigenfrequency(phi)
%phi

A=[M,zeros(2,2);zeros(2,2),K];
B=[C,K;-K,zeros(2,2)];
sysEqu=-inv(A)*B;
[phi,frq]=eig(sysEqu);
%%
phi1=[1;1];
phi2=[-0.0012;1];
MM1=phi1'*M*phi1; % Modal mass 1
MM2=phi2'*M*phi2; % Modal mass 2
MK1=phi1'*K*phi1; % Modal stiffness 1 
MK2=phi2'*K*phi2; % Modal stiffness 2
MC1=phi1'*C*phi1; % Modal damping 1 
MC2=phi2'*C*phi2; % Modal damping 2
%%
% Transfer functions
% Transfer functions
opts = bodeoptions('cstprefs');opts.FreqUnits = 'Hz';
s=tf('s'); w=logspace(-1,3,1001)*2*pi;
xF11=phi1(1)*phi1(1)/(MM1*s^2+MC1*s+MK1)+phi2(1)*phi2(1)/(MM2*s^2+MC2*s+MK2); % transfer function of xcs/F1=xcs/Fcs
subplot(221),bode(xF11,w,opts); grid on, hold on

XF12=phi1(2)*phi1(1)/(MM1*s^2+MC1*s+MK1)+phi2(2)*phi2(1)/(MM2*s^2+MC2*s+MK2); % transfer function of xcs/F2
xF12=-xF11+XF12; % transfer function of xcs/Ffs
subplot(222),bode(xF12,w,opts); grid on, hold on,subtitle("from 𝐹1 to 𝑥2.")

xF21=phi1(1)*phi1(2)/(MM1*s^2+MC1*s+MK1)+phi2(1)*phi2(2)/(MM2*s^2+MC2*s+MK2); % transfer function of xfs/F1=xfs/Fcs
subplot(223),bode(xF21,w,opts); hold on, grid on

XF22=phi1(2)*phi1(2)/(MM1*s^2+MC1*s+MK1)+phi2(2)*phi2(2)/(MM2*s^2+MC2*s+MK2); % transfer function of xfs/F2
xF22=XF22-xF21; % transfer function of xfs/Ffs
subplot(224),bode(xF22,w,opts); hold on, grid on

