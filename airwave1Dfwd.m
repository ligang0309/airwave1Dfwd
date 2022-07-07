%% PROGRAM FOR COMPUTING THE AIRWAVE
%  FOR 1D THREE-LAYERED ISOTROPIC CONDUCTIVITY MODEL
%   Program for computing the radial electric component of 
%   the airwave for three-layer model with the 
%   air half-space, seawater and seafloor half-space 
%   for a horizontal electric dipole (HED) source.
% 
%  This code follows "Nordskag, J.I., Amundsen, L., 2007. 
%   Asymptotic airwave modeling for marine controlled-source 
%   electromagnetic surveying. Geophysics 72, F249–F255. 
%   doi:10.1190/1.2786025."
%
%  For possible questions, please contact:
%   Gang Li
%   Zhejiang University
%   ligang0309@gmail.com
%   Original codes written in 9 Jul.,2021 

%% Input parameters
% Source dipole 
clc; clear;
nsrc = 1;        

fid = fopen('input_sources.txt', 'r');
nsrc = fscanf(fid, '%i', 1);   % number of transmitters, 1 FOR READING A INTEGER
[temp, count] = fscanf(fid, '%g %g %g %g %g %g', [5 nsrc]);
fclose(fid);
temp = temp';

Psrc = temp(:,1);       % moment
PHIsrc = temp(:,2);     % azimuth (in degree)
xsrc = temp(:,3);
ysrc = temp(:,4);
zsrc = temp(:,5);

% Transmitting frequency
fid = fopen('input_frequencies.txt', 'r');
nfreq = fscanf(fid, '%i', 1);   % number of transmitters, 1 FOR READING A INTEGER
[temp, count] = fscanf(fid, '%g', [1 nfreq]);
fclose(fid);
temp = temp';

freq = temp(:,1);    % transmitting frequency

% Receivers
fid = fopen('input_receivers.txt', 'r');
nsite = fscanf(fid, '%i', 1);   % number of transmitters, 1 FOR READING A INTEGER
[temp, count] = fscanf(fid, '%g %g %g %g %g %g', [6 nsite]);
fclose(fid);
temp = temp';

xsite = temp(:,1);
ysite = temp(:,2);
zsite = temp(:,3);
alphasite = temp(:,4);
betasite = temp(:,5);
gammasite = temp(:,6);

% Conductivity model (ONLY 3-LAYERED MODEL IS SUPPORTED)
fid = fopen('input_model.txt', 'r');
nlayer = fscanf(fid, '%i', 1);   % number of transmitters, 1 FOR READING A INTEGER
[temp, count] = fscanf(fid, '%g %g', [2 nlayer]);
fclose(fid);
temp = temp';

depth_top = temp(:,1);
sigma = temp(:,2);

z_sea = depth_top(3);            % seawater bottom boundary depth (m), 
                                 % note that the upper boundary is of 0 m
sigma_sea = 1./sigma(2);         % conductivity of seawater half-space  
sigma_seafloor = 1./sigma(3);    % conductivity of seafloor half-space 

%% Calculating the airwave fields
mu0 = 4*pi*10.^(-7);          % free-space magnetic permeability
epsilon0 = 8.854187817*10.^(-12);   % free-space electric permittivity
Eair = zeros(nfreq,nsrc,nsite);

for ifreq = 1:nfreq
    omega = 2*pi*freq;
    k = sqrt(1i*omega*mu0*sigma_sea);
    k0 = omega * sqrt(mu0*epsilon0);
    R = (sqrt(sigma_sea) - sqrt(sigma_seafloor)) ...
        ./ (sqrt(sigma_sea) + sqrt(sigma_seafloor));
    
    for isrc = 1:nsrc
        for isite = 1:nsite
            r_offset = (xsrc(isrc) - xsite(isite)).^2 ...
                + (ysrc(isrc) - ysite(isite)).^2;
            r_offset = sqrt(r_offset);
            
            Eair(ifreq,isrc,isite) = Psrc(isrc)*cosd(PHIsrc(isrc))*...
                exp(1i*k*(zsite(isite)+zsrc(isrc)))*exp(1i*k0*r_offset)...
                ./ (2*pi*sigma_sea*r_offset.^3);
								
            reflect1 = (1 + R*exp(2*1i*k*(z_sea-zsrc(isrc)))) ...
                ./ (1 - R*exp(2*1i*k*z_sea));
            
            reflect2 = (1 + R*exp(2*1i*k*(z_sea-zsite(isite)))) ...
                ./ (1 - R*exp(2*1i*k*z_sea));
            
            Eair(ifreq,isrc,isite) = Eair(ifreq,isrc,isite)...
                *reflect1*reflect2;
		end             
    end
end

%% Saving the results
fid=fopen('results.txt','wt');
for ifreq = 1:nfreq
    for isrc = 1:nsrc
        for isite = 1:nsite
            fprintf(fid,'%g\t%g\n',real(Eair(ifreq,isrc,isite)),...
                imag(Eair(ifreq,isrc,isite)));
		end             
    end
end
fclose(fid);
