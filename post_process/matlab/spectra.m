% Plot Froude and energy vertical spectra from outxx.h5 files

% To be run after read_full_h5.m
[NX,NY,NZ]=size(U);

% Kdim=floor(2*[NX NY NZ]/3);

CU=fftn(U/(NX*NY*NZ));
CV=fftn(V/(NX*NY*NZ));
CW=fftn(W/(NX*NY*NZ));
CTH=fftn(TH/(NX*NY*NZ));

RI=1;

% MATLAB fft indexed (0,1,...,NX/2,-NX/2,...,-2,-1)

CShear=CU.*conj(CU)+CW.*conj(CW);
NK=floor(250/3);
KY=0:NK;
figure(1); %hold on
CS1=CShear(1:NK+1,1:NK+1,1:NK+1);
CS2=zeros(size(CS1));
CS2(2:end,2:end,2:end)=flip(flip(flip(CShear(2*(NK+1):end,2*(NK+1):end,2*(NK+1):end),1),2),3);
Froude = KY.^2.*sum(sum(CS1+CS2,3),1)/RI;
% Froude = KY.^2.*sum(sum(CShear(2:NK+1,2:NK+1,2:NK+1)+CShear(2*(NK+1):end,2*(NK+1):end,2*(NK+1):end),3),1);
loglog(KY/20,Froude*20)
xlabel('$|m| \ [m^{-1}]$')
ylabel('$\Phi_{Fr} \ [m]$')
figure(2); %hold on
CE=0.5*(CU.*conj(CU)+CV.*conj(CV)+CW.*conj(CW)+CTH.*conj(CTH));
CS1=CE(1:NK+1,1:NK+1,1:NK+1);
CS2=zeros(size(CS1));
CS2(2:end,2:end,2:end)=flip(flip(flip(CE(2*(NK+1):end,2*(NK+1):end,2*(NK+1):end),1),2),3);
E=sum(sum(CS1+CS2,3),1);
loglog(KY/20,E*20*0.1^2)
xlabel('$|m| \ [m^{-1}]$')
ylabel('$E(m) \ [m^3 s^{-2}]$')