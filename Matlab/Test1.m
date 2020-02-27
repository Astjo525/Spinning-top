% Definiera alla konstanter
F = 1;              % Kraften som appliceras
mass = 0.013;       % Snurrans massa
r = 0.02;           % Snurrans radie (l�ngst upp)
h = 0.07;           % Snurrans h�jd
g = 9.82;           % Gravitationskonstanten
delta_t = 0.01;     % Tiden under vilken en kraft appliceras
com = 3*h/4;        % Avst�ndet till masscentrum
Fric_coeff = 0.48;  % Friktionskoefficient f�r ek mot ek
Friction = -1 * Fric_coeff * mass * g; % Frictionskraften, negativ normalkraft g�nger friktionkoefficient
r_contact = 0.001;  % Radien p� kontaktpunkten?

I1 = mass * ((3/20)*r*r + (3/80)*h*h);  % Tr�ghetsmoment vid lutning
I3 = (3*mass*r*r)/10;                   % Tr�ghetsmoment n�r rak

% Ber�kna psi_dot och gr�nsen f�r psi_dot
psi_dot = F*r*delta_t/I3;
psi_dot_limit = 4*I1*mass*g*cos(theta(1)) / (I3*I3);

% Ber�kna phi_dot
phi_dot(1) = mass*g*com/(psi_dot*I1);

% Ber�kna theta och theta_dot
theta_dot(1) = Friction * com / (I3*psi_dot); 
theta(1) = 0;

H=0.01; % step's size
N=1000; % number of steps

% Startv�rden f�r psi och phi
psi(1) = 0;
phi(1) = 0;

% For-loop f�r att ber�kna allt m�jligt med hj�lp av Euler (eller tidigare
% vinklar)
for n=1:N
    theta(n+1) = Euler(theta(n), theta_dot(n), H);
    phi_dot(n+1) = mass * g * com / (psi_dot*I1);
    
    theta_dot(n+1) = Friction * com / (I3*psi_dot);
        
%     psi_dot_limit = 4*I1*mass*g*cos(theta(n+1)) / (I3*I3);
%     
%     if (psi_dot + phi_dot(n+1)*cos(theta(n+1)))^2 < psi_dot_limit
%        psi_dot = 0;
%        phi_dot(n+1) = 0;
%        theta_dot(n+1) = 0;
%     end
    
    psi(n+1) = Euler(psi(n), psi_dot, H);
    phi(n+1) = Euler(phi(n), phi_dot(n), H);
end

% Plotta resultaten fr�n loopen ovan.
t = 1:H:H*N+1;
plot(t,mod(psi,2*pi),'r');
figure;
plot(t,mod(phi,2*pi),'r');
figure;
plot(t,theta,'r');
figure;
plot(t,phi_dot,'r');
figure;
plot(t,theta_dot,'r');

% M�rkte n�r jag k�rde denna nedan att mittensnurren �ndrar riktning efter en
% stund och b�rjar g� �t andra h�llet. Vet ej vad det beror p�. Den andra
% r�r sig j�ttesakta, k�nns inte heller s� bra.
% 
% for n =1:N
%     plot(r*cos(psi(n)), r*sin(psi(n)), '*');
%     axis([-1 1 -1 1]);
%     hold on;
%     plot(cos(phi(n)), sin(phi(n)), '*');
%     drawnow();
% end