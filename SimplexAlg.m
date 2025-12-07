function [oofv,optimalX] = SimplexAlg(c,A, b, basis)
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
%while loop until all the values are positive for Cn
iteration_count = 0;
while any(top_cn > 10^(-10))
    %chooses which column to replace for basis
    [dummy, largest_cn] = max(tableu(1,2:end-1));
    b = tableu(2:end, end);
    largestCol = tableu(2:end, largest_cn + 1);
    %chooses which row to replace for basis
    pos_r = largestCol >= 10^(-10);
    r = b ./ largestCol;
    if all(pos_r == 0)
        error('unbounded')
  
    end

    [~, minOfValid] = min(r(pos_r));
    actual_indOfValid = find(pos_r);
    smallest_row = actual_indOfValid(minOfValid);
    
    %updates basis
    basis(smallest_row) = largest_cn;
    tableu(smallest_row+1, :) = tableu(smallest_row+1, :) ./ tableu(smallest_row+1, largest_cn+1);
    
    %row reduce

    for i = 1:size(tableu, 1)
        if (i ~= smallest_row+1) 
            divideNum = tableu(i, largest_cn+1);
            tableu(i, :) = tableu(i, :) - divideNum * tableu(smallest_row+1, :);

        end
    end
    
    %updates values
    notInBasis = setdiff(2:totalColumns, basis+1);
    notInBasis(:, end) = [];
    notInBasis = notInBasis;
    top_cn = tableu(1, notInBasis);
    top_cb = tableu(1, basis+1);
    tableu
    iteration_count = iteration_count + 1;



end
oofv = tableu(1, end)
iteration_count;
%creates bfs corresponding to oofv
optimalX = zeros(length(top_cb)+length(top_cn), 1);
for i = 1:length(basis)
    index = basis(i);
    optimalX(index) = tableu(i+1, end);


end
optimalX
end