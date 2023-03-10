clear;
clc;

set(0, 'DefaultFigureWindowStyle','docked')
set(0, 'DefaultAxesFontSize', 20)
set(0, 'DefaultAxesFontName', 'Times New Roman')
set(0, 'DefaultLineLineWidth', 2)

nx = 50;
ny = 50;

V = zeros(nx, ny);
G = sparse(nx*ny, nx*ny);

%Inclusion = 0;

for i = 1:nx
    for j = 1:nx

        n = j + (i - 1)*ny;

        if i == 1
            G(n,:) = 0;
            G(n,n) = 1;

        elseif j == ny
            G(n,:) = 0;
            G(n,n) = 1;

        elseif j == 1
            G(n,:) = 0;
            G(n,n) = 1;

        elseif i == nx
            G(n,:) = 0;
            G(n,n) = 1;

        else
            if ((i > 10 && i < 20) && ((j > 10) && (j < 20)))
            
                G(n,n) = -2;
            
            else

                G(n,n) = -4;
            end
            

            nxm = j + (i-2)*ny;
            nxp = j + (i)*ny;
            nym = j-1 + (i-1)*ny;
            nyp = j+1 + (i-1)*ny;

            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
    end
end

figure('name', 'Matrix')
spy(G)

nmodes = 20;
[E,D] = eigs(G, nmodes, 'SM');

figure('name', 'EigenValues')
plot(diag(D), '*');

np = ceil(sqrt(nmodes))
figure('name', 'Modes')

for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n = i + (j-1)*nx;
            V(i,j) = M(n);
        end
        subplot(np, np, k), surf(V, 'LineStyle', 'none')
        title(['EV = ' num2str(D(k,k))])
    end
end