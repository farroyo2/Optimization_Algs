function [outputArg1,outputArg2] = maxMatching(IncidenceMatrix)
IncidenceMatrix = IncidenceMatrix';
[numVertex,numEdges] = size(IncidenceMatrix);

% sets up upper bound, lower bound, ofv, and the number for intcon
LB = zeros(numEdges,1);
UB = ones(numEdges,1);
intcon = [1:numEdges];
c = -(ones(numEdges,1));

A = IncidenceMatrix;
b = ones(numVertex,1);
[xopt,fopt]=intlinprog(c,intcon,A,b,[],[],LB,UB)

end