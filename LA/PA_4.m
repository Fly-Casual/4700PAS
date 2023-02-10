%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% PA 4 - LAPLACE EQUATION SOLVED BY ITERATION %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% SET CONSTANTS %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nx = 100;   %Mesh Sizing
ny = 100;

ni = 1000;  %Number of Iterations

V = zeros(nx,ny);

V(1,:) = 1;  %Left Side
V(nx,:) = 1; %Right Side
V(:,1) = 0;  %Top
V(:,ny) = 0;  %Bottom

for k = 1:ni
    for i = 2:nx-1
        for j = 2:ny-1
                V(i,j) = (V(i+1,j) + V(i-1,j) + V(i,j-1) + V(i,j+1))/4;


            
        end
    
    end

%     V(:,1) = V(:,2);
%     V(:,ny) = V(:,ny-1);

    
    if mod(k,50) == 0
        surf(V')
        pause(0.05)
    end
end

[Ex,Ey] = gradient(V);

figure
quiver(-Ey',-Ex',10)

