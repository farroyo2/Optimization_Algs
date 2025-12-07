function [oofv,optimalX, OptimalY] = DualSimplexAlg(c,A, b, basis)
c = c';
%creates pre tableu
topRow = [1 -c 0];
B = A(:, basis);
N = A;
N(:, basis) = [];
first_col = zeros(size(b));
bottomPart = [first_col, A, b];
pre_tableu = [topRow; bottomPart]

%turns pre tableu into first tableu
pre_tableu(2:end, basis + 1) = inv(B)*pre_tableu(2:end, basis + 1);

totalColumns = size(pre_tableu - 1, 2);
notInBasis = setdiff(2:totalColumns, basis+1);
pre_tableu(2:end, notInBasis) = inv(B) * pre_tableu(2:end, notInBasis);

notInBasis(:, end) = [];

Cb = c(basis);
Cn = c(notInBasis()-1);
pre_tableu(1,end) = Cb*inv(B)*b;
pre_tableu(1, basis+1) = zeros(size(basis));
pre_tableu(1, notInBasis) = Cb*inv(B)* N - Cn;

tableu = pre_tableu

 % assigns new cn and cb
top_cn = tableu(1, notInBasis);
top_cb = tableu(1, basis +1);
RHS = tableu(2:end, end);

%while loop until all the values are positive for RHS
iteration_count = 0;
while any(RHS < -10^(-10))
    %chooses which row to replace for basis
    [dummy, smallest_RHS] = min(tableu(2:end,end));
    Smallest_Row = tableu(smallest_RHS + 1, notInBasis);
    %chooses which column to replace for basis
    neg_r = Smallest_Row < -10^(-10);
    r =  top_cn ./ Smallest_Row;
    if all(neg_r == 0)
        error('unbounded')
  
    end

    [~, minOfValid] = min(r(neg_r));
    actual_indOfValid = find(neg_r);
    smallest_column = actual_indOfValid(minOfValid);
    smallest_row = smallest_RHS;
    
    %updates basis
    smallest_column = notInBasis(smallest_column) - 1;

    basis(smallest_RHS) = smallest_column;
    tableu(smallest_row+1, :) = tableu(smallest_row+1, :) ./ tableu(smallest_row+1, smallest_column+1);
    
    %row reduce

    for i = 1:size(tableu, 1)
        if (i ~= smallest_row+1) 
            divideNum = tableu(i, smallest_column+1);
            tableu(i, :) = tableu(i, :) - divideNum * tableu(smallest_row+1, :);

        end
    end
    

    %updates values
    notInBasis = setdiff(2:totalColumns, basis+1);
    notInBasis(:, end) = [];
    top_cn = tableu(1, notInBasis);
    top_cb = tableu(1, basis+1);
    RHS = tableu(2:end, end);
    tableu
    iteration_count = iteration_count + 1;



end
oofv = tableu(1, end)
iteration_count
%creates bfs corresponding to oofv
optimalX = zeros(length(top_cb)+length(top_cn), 1);
for i = 1:length(basis)
    index = basis(i);
    optimalX(index) = tableu(i+1, end);


end
OptimalY = c(basis) *inv(A(:, basis));
OptimalY = OptimalY'
optimalX
end