function [xopt,fopt] = minVertexCover(IncidenceMatrix)
%gets num of edges and vertices
[numEdges,numVertex] = size(IncidenceMatrix);

% sets up upper bound, lower bound, ofv, and the number for intcon
LB = zeros(numVertex,1);
UB = ones(numVertex,1);
intcon = [1:numVertex];
c = ones(numVertex,1);

%sets up the constraint matrix and b vector for the function
A = -IncidenceMatrix;
b = -(ones(numEdges,1));
[xopt,fopt]=intlinprog(c,intcon,A,b,[],[],LB,UB)
end

function [outputArg1,outputArg2] = maxMatching(IncidenceMatrix)
%gets hum of edges and vertices
IncidenceMatrix = IncidenceMatrix';
[numVertex,numEdges] = size(IncidenceMatrix);

% sets up upper bound, lower bound, ofv, and the number for intcon
LB = zeros(numEdges,1);
UB = ones(numEdges,1);
intcon = [1:numEdges];
c = -(ones(numEdges,1));

%sets up the constraint matrix and b vector for the function
A = IncidenceMatrix;
b = ones(numVertex,1);
[xopt,fopt]=intlinprog(c,intcon,A,b,[],[],LB,UB)

end