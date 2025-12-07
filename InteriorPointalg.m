function [xstar,ystar,zstar,kstar] = InteriorPointalg(Q,c,A,b,delta,epsMin,epsMax)
m = size(A, 1);
n = size(A, 2);

%Initialize F and all other vectors/ variables
F = ones(m+n+m, 1);

k = 0;
x = ones(n, 1);
y = ones(m, 1);
z = ones(n, 1);


%Iterates through until we get a norm for F close to 0, basically until
%root found
while norm(F) > .000001
    if mod(k,2) == 0
        eps = epsMax;
    else
        eps = epsMin;
    end

    beta = (dot(x,z)) / n;
    tau = eps * beta;
    %calculates F
    F = [-Q*x - c + A' * y + z; A*x - b; x.*z - tau];
    gradientF = [-Q A' eye(n); A zeros(m) zeros(m,n); diag(z) zeros(n,m) diag(x)];
    %solves for delta x, y, z
    change = gradientF \ -F;
    
    %check for u leaving N, tries to get alpha as close to 1 as possible
    valid = true;
    count = -1;
    num = .00001;
    alpha = 0;

    if any(z .* x < delta * beta) || any(x <= 0) || any(z <= 0) || (alpha >= 1)
            valid = false;
    end

    while valid

        nextx = x + alpha * change(1:n);
        nexty = y + alpha * change(n+1:n+m);
        nextz = z + alpha * change(n+m+1:2*n+m);
        alpha = alpha + num;
        if any(nextz .* nextx < delta * beta) || any(nextx <= 0)|| any(nextz <= 0)|| alpha >= 1
            valid = false;
        end

    end
    %updates for next iteration
    x = nextx;
    y = nexty;
    z = nextz;
    F = [-Q*x - c + A' * y + z; A*x - b; x.*z];
    k = k+1;

end
xstar = x
ystar = y
zstar = z
kstar = k


end