% Definiera alla konstanter
% S�tter ig�ng snurran
F = 1;             % Kraften som appliceras
delta_t = 0.05;     % Tiden under vilken en kraft appliceras

% Snurrans egenskaper
mass = 0.1;                 % Snurrans massa
r = 0.02;                   % Snurrans radie (l�ngst upp)
height = 0.07;                   % Snurrans h�jd
com = 3 * height / 4;       % Avst�ndet till masscentrum
g = 9.82;                   % Gravitationskonstanten


% Tr�gehtsmoment
I1 = mass * ((3/20)*r*r + (3/80)*height*height);  % Tr�ghetsmoment vid lutning
I3 = (3*mass*r*r)/10; % Tr�ghetsmoment n�r rak (Vertikal om underlaget)
                  
% Ber�kna psi_dot
psi_dot = F*r*delta_t/I3;

% Ber�kna phi_dot
phi_dot = mass*g*com/(psi_dot*I1);

theta = pi / 12;

omega_spin = phi_dot * cos(theta) + psi_dot;
omega_prec(1) = 0;

h= 1 / 60; % step's size
N=1000; % number of steps

% Startv�rden f�r psi och phi
psi(1) = 0;
phi(1) = 0;
prec(1) = 0;
spin(1) = 0;

% For-loop f�r att ber�kna allt m�jligt med hj�lp av Eulers stegmetod
for n=1:N
    omega_prec(n+1) = abs(phi_dot*sin(theta)*sin(psi(n)));
    
    prec(n+1) = Euler(prec(n), omega_prec(n), h);
    spin(n+1) = Euler(spin(n), omega_spin, h);
    psi(n+1) = Euler(psi(n), psi_dot, h);
    phi(n+1) = Euler(phi(n), phi_dot, h);
    
end

% Plotta resultaten fr�n loopen ovan.
t = 0:h:h*N;
plot(t,mod(psi,2*pi),'r');
title('Psi');
figure;
plot(t,mod(phi,2*pi),'r');
title('Phi');
figure;
plot(t,mod(spin,2*pi),'r');
title('Spin');
figure;
plot(t,mod(prec,2*pi),'r');
title('Prec');


% Koden nedan visar snurrans rotation, den inre cirkeln �r rotationen runt
% snurrans egen axel, den yttre cirkeln �r precessionen.
% Denna kod g�r tyv�rr att figurerna f�r psi och phi inte visas, s� man b�r
% inte k�ra detta kodparti samtidigt som kodpartiet f�r figurerna ovan,
% utan k�r dem ett i taget

% figure;
% for n =1:N
%     plot(r*cos(psi(n)), r*sin(psi(n)), '*');
%     axis([-1 1 -1 1]);
%     hold on;
%     plot(cos(phi(n)), sin(phi(n)), '*');
%     drawnow();
% end