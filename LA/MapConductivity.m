function cMap = MapConductivity(ngeo, Max, nx, ny, Back_cond, Incl_cond)
%global im fig fc cMap

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% CREATE CONDUCTIVITY MAP %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pgeo = rand(ngeo, 2);
pgeo(:, 1) = pgeo(:, 1) * nx;
pgeo(:, 2) = pgeo(:, 2) * ny;
rgeo = rand(ngeo, 1 ) * Max;
rcircs2 = rgeo.^2;  %RANDOM CIRCULAR INCLUSIONS

cMap = zeros(nx,ny);

for i = 1:nx
    for j = 1:ny
        cMap(i,j) = Back_cond;
        for p = 1:ngeo
            dx = (pgeo(p, 1) - i);
            dy = (pgeo(p, 2) - j);
            if dx * dx + dy * dy < rcircs2(p)
                cMap(i, j) = Incl_cond;
            end
        end
    end
end