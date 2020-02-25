F = 1;
m = 0.013;
r = 0.02;
h = 0.07;
g = 9.82;
delta_t = 1;
l = 3*h/4;
my = 0.48;
Friction = -1 * my * m * g; % Frictionskraften, negativ normalkraft g�nger friktionkoefficient
r_contact = 0.001;  % Radien p� kontaktpunkten?

I1 = m * ((3/20)*r*r + (3/80)*h*h);
I3 = (3*m*r*r)/10;

psi_dot_dot = Friction * l / I3;
psi_dot(1) = F*r*delta_t/I3;
phi_dot(1) = m*g*l/(psi_dot(1)*I1);

psi_dot_limit = 4*I1*m*g*cos(pi/12) / (I3*I3);

H=0.001; % step's size
N=1000; % number of steps
psi(1) = 0;
phi(1) = 0;

for n=1:N
    psi_dot(n+1) = Euler(psi_dot(n), psi_dot_dot, H);
    phi_dot(n+1) = m*g*l/(psi_dot(n+1)*I1);
        
    if psi_dot(n+1) * psi_dot(n+1) < psi_dot_limit
       psi_dot(n+1) = 0;
       phi_dot(n+1) = 0;
    end
    
    psi(n+1) = Euler(psi(n), psi_dot(n), H);
    phi(n+1) = Euler(phi(n), phi_dot(n), H);
end

% Detta resultat st�mmer verkligen inte, men kanske �r lite p� v�g i alla
% fall. Graferna blir i alla fall lite sp�nnande!
t = 1:H:H*N+1;
plot(t,mod(psi, 2*pi),'r');
figure;
plot(t,mod(phi,2*pi),'r');
figure;
plot(t,psi_dot,'r');
figure;
plot(t,phi_dot,'r');

% M�rkte n�r jag k�rde denna nedan att mittensnurren �ndrar riktning efter en
% stund och b�rjar g� �t andra h�llet. Vet ej vad det beror p�. Den andra
% r�r sig j�ttesakta, k�nns inte heller s� bra.

% for n =1:N
%     plot(r*cos(psi(n)), r*sin(psi(n)), 'x');
%     axis([-1 1 -1 1]);
%     hold on;
%     plot(cos(phi(n)), sin(phi(n)), '*');
%     drawnow();
% end