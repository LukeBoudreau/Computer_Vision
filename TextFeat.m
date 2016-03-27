%Image Retrieval using Texture Features
%
L5 = [1 4 6 4 1];
E5 = [-1 -2 0 2 1];
S5 = [-1 0 2 0 -1];
R5 = [1 -4 6 -4 1];


map = containers.Map('KeyType', 'char','ValueType','any');
%Read in all texture 
for i = 1:40
    if i < 10
        s = sprintf('T01_0%d',i);
    else
        s = sprintf('T01_%d',i);
    end
    image = imread(sprintf('Texture_Images\\T01_bark1\\%s.jpg',s));
    feature_vector = calcText(image);
    map(s) = feature_vector;
end
    
for i = 1:40
    if i < 10
        s = sprintf('T05_0%d',i);
    else
        s = sprintf('T05_%d',i);
    end
    image = imread(sprintf('Texture_Images\\T05_wood2\\%s.jpg',s));
    feature_vector = calcText(image);
    map(s) = feature_vector;
end

for i = 1:40
    if i < 10
        s = sprintf('T12_0%d',i);
    else
        s = sprintf('T12_%d',i);
    end
    image = imread(sprintf('Texture_Images\\T12_pebbles\\%s.jpg',s));
    feature_vector = calcText(image);
    map(s) = feature_vector;
end

for i = 1:40
    if i < 10
        s = sprintf('T13_0%d',i);
    else
        s = sprintf('T13_%d',i);
    end
    image = imread(sprintf('Texture_Images\\T13_wall\\%s.jpg',s));
    feature_vector = calcText(image);
    map(s) = feature_vector;
end

for i = 1:40
    if i < 10
        s = sprintf('T18_0%d',i);
    else
        s = sprintf('T18_%d',i);
    end
    image = imread(sprintf('Texture_Images\\T18_carpet1\\%s.jpg',s));
    feature_vector = calcText(image);
    map(s) = feature_vector;
end

for i = 1:40
    if i < 10
        s = sprintf('T25_0%d',i);
    else
        s = sprintf('T25_%d',i);
    end
    image = imread(sprintf('Texture_Images\\T25_plaid\\%s.jpg',s));
    feature_vector = calcText(image);
    map(s) = feature_vector;
end