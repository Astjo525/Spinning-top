F = 1;
m = 0.5;
r = 0.02;
h = 0.04;
g = 9.82;
delta_t = 1;
I3 = (3*m*r*r)/10;
l = 3*h/4;
I1 = m * ((3/20)*r*r + (3/80)*h*h);

psi_dot = F*r*delta_t/I3;
phi_dot = m*g*l/(psi_dot*I1);

H=0.001; % step's size
N=1000; % number of steps
psi(1) = 0;
phi(1) = 0;

for n=1:N
    psi(n+1) = Euler( psi(n), psi_dot, H);
    phi(n+1) = Euler(phi(n), phi_dot, H);
end

t = 1:H:H*N+1;
plot(t,mod(psi,2*pi),'r')
figure;
plot(t,mod(phi,2*pi),'r')