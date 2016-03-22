function [ IDX C ] = lmeans( X, k, ITR )
%LMEANS 
% This function is Luke's Custom implementation of K-means Clustering.
% PARAMETERS:
% X is an MxNxd matrix
% C=[] are the initial Centroids locations (Assumed Randomly initialized)
% Each centroid must have d Coordinates (based on X values).
% ITR is the iteration limit.


%Obtain number of points, and dimensionality.
[rows cols depth] = size(X);
if k < 2
    k = 2;
end
% Determine random values (0-255) for each centroid
% Each each row is a centroid, the columns are the coordinates
Centroids = zeros(k,depth);
Centroids(:) = randi(255,[k depth]);
Centroids = double(Centroids);

% Perform Cluster Assignment
X = double(X);

for i = 1:ITR
    display(sprintf('Iteration %d',i));
    distances = zeros(rows,cols,k);
    for c = 1:k
        %Caclulate distance from centroid to each point.
        sqdistance = zeros(rows,cols);
        for d = 1:depth
            %depth is the Euclidean Space (1 to 3)
            sqdistance = sqdistance + (X(:,:,d)-Centroids(c,d)).^2;
        end
        %Square Root to find Euclidean distance
        distance = sqrt(sqdistance);
        %Assign to page in an MxN matrix
        distances(:,:,c) = distance;
    end

    %Find which centroid is the minimum for each row and column.
    % IDX holds the centroid index for each point
    % (index translates to the rows in "Centroids")
    [Y IDX] = min(distances,[],3);

    %Recompute Centroids (Center of each cluster)
    %C = Centroids;
    newCentroids = zeros(k,depth);
    numPoints = zeros(k,1);
    for r = 1:rows
        for c = 1:cols
            for d = 1:depth
                newCentroids(IDX(r,c),d) = newCentroids(IDX(r,c),d) + X(r,c,d);
            end
            numPoints(IDX(r,c),1) = numPoints(IDX(r,c),1) + 1;
        end
    end

    %Divide by total number of elements
    numPoints = repmat(numPoints,1,depth);
    %Do NOT divide by zero
    numPoints(numPoints == 0)=1;
    newCentroids = newCentroids./numPoints;

    %If Centroids do not change (Significantly) then done.
    if uint8(newCentroids) == uint8(Centroids)
        break;
    end
    %Else assign Centroids, and move to next value
    Centroids = newCentroids;
end

%Final centroid value
C = Centroids;
end

