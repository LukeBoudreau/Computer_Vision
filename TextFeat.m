% Image Retrieval using Texture Features
%% A)
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


%% B & C)

% Select 3 images from each texture class
% For each of the 3 images: calculate CHI on every image in the map
% sort & pick top 4
indexes = keys(map)';
indexes = char(indexes);

prefix = ['T01';'T05'; 'T12'; 'T13'; 'T18'; 'T25'];
fileprefix = containers.Map('KeyType', 'double','ValueType','any');
fileprefix(1) = 'T01_bark1';
fileprefix(2) = 'T05_wood2';
fileprefix(3) = 'T12_pebbles';
fileprefix(4) = 'T13_wall';
fileprefix(5) = 'T18_carpet1';
fileprefix(6) = 'T25_plaid';

for i = 1:6
    %Pick 3 different images from each class
    tableData = zeros([3 5]);
    tableData(:,1) = randi([1 40],[3 1]);
    %Ensure we picked 3 different images
    len = length(unique(tableData(:,1)));
    while len ~= 3
        tableData(:,1) = randi([1 40],[3 1]);
        len = length(unique(tableData(:,1)));
    end
    
    %This matrix will hold temporary values
    % The first column correpsond to the 'prefix' values via.
    % floor((row-1)/40)+1
    all_distances = zeros([240 2]);
    
    %For each selected image
    for j = 1:3
        model_key = sprintf('%s_%02d',prefix(i,:),tableData(j,1));
        display(sprintf('Finding matches for image %s',model_key));
        %Find matches
        for k = 1:length(indexes)
            chi_value = calcCHI(map(model_key),map(indexes(k,:)));
            all_distances(k,:) = [k chi_value];
        end
        %Sort
        sorted_distances = sortrows(all_distances,2);
        
        %Write to file
        subplot(141);
        set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 10 6]);
        set(gcf, 'Position', [488 342 1324 420]);
        
        p = floor((sorted_distances(2,1)-1)/40)+1;
        name_prefix = prefix(p,:);
        name_num = sorted_distances(2,1) - (p-1)*40;
        image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
        imshow(image);
        title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(2,2)));
        
        subplot(142);
        p = floor((sorted_distances(3,1)-1)/40)+1;
        name_prefix = prefix(p,:);
        name_num = sorted_distances(3,1) - (p-1)*40;
        image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
        imshow(image);
        title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(3,2)));
        
        subplot(143);
        p = floor((sorted_distances(4,1)-1)/40)+1;
        name_prefix = prefix(p,:);
        name_num = sorted_distances(4,1) - (p-1)*40;
        image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
        imshow(image);
        title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(4,2)));    
        
        subplot(144);
        p = floor((sorted_distances(5,1)-1)/40)+1;
        name_prefix = prefix(p,:);
        name_num = sorted_distances(5,1) - (p-1)*40;
        image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
        imshow(image);
        title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(5,2))); 
        
        print(sprintf('%s_texture_matches',model_key),'-dpng','-r300');
    end
end

%% D)
% This part resizes an image twice (smaller and Larger).
% six images will be resized (one from each class).

for i = 1:6
    %Pick 1 different images from each class
    image_index = randi([1 40]);
    
    % Default size ======================================================
    
    % This matrix will hold temporary values
    % The first column correpsond to the 'prefix' values via.
    % floor((row-1)/40)+1
    all_distances = zeros([240 2]);
    model_key = sprintf('%s_%02d',prefix(i,:),image_index);
    display(sprintf('Finding matches for image %s',model_key));
    %Find matches
    for k = 1:length(indexes)
        chi_value = calcCHI(map(model_key),map(indexes(k,:)));
        all_distances(k,:) = [k chi_value];
    end
    %Sort
    sorted_distances = sortrows(all_distances,2);

    %Write to file
    subplot(141);
    set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 10 6]);
    set(gcf, 'Position', [488 342 1324 420]);

    p = floor((sorted_distances(2,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(2,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(2,2)));

    subplot(142);
    p = floor((sorted_distances(3,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(3,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(3,2)));

    subplot(143);
    p = floor((sorted_distances(4,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(4,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(4,2)));    

    subplot(144);
    p = floor((sorted_distances(5,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(5,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(5,2))); 

    print(sprintf('%s_resize_default',model_key),'-dpng','-r300');
    
% Smaller size ======================================================
    
    % This matrix will hold temporary values
    % The first column correpsond to the 'prefix' values via.
    % floor((row-1)/40)+1
    all_distances = zeros([240 2]);
    model_key = sprintf('%s_%02d',prefix(i,:),image_index);
    display(sprintf('Finding matches for image %s (50%% smaller)',model_key));
    image = imread(sprintf('Texture_Images\\%s\\%s.jpg',fileprefix(i),model_key));
    image = imresize(image,0.5);
    new_feature_vector = calcText(image);
    
    %Find matches
    for k = 1:length(indexes)
        chi_value = calcCHI(new_feature_vector,map(indexes(k,:)));
        all_distances(k,:) = [k chi_value];
    end
    %Sort
    sorted_distances = sortrows(all_distances,2);

    %Write to file
    subplot(141);
    set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 10 6]);
    set(gcf, 'Position', [488 342 1324 420]);

    p = floor((sorted_distances(2,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(2,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(2,2)));

    subplot(142);
    p = floor((sorted_distances(3,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(3,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(3,2)));

    subplot(143);
    p = floor((sorted_distances(4,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(4,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(4,2)));    

    subplot(144);
    p = floor((sorted_distances(5,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(5,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(5,2))); 

    print(sprintf('%s_resize_smaller',model_key),'-dpng','-r300');
    
    % Larger size ======================================================
    
    % This matrix will hold temporary values
    % The first column correpsond to the 'prefix' values via.
    % floor((row-1)/40)+1
    all_distances = zeros([240 2]);
    model_key = sprintf('%s_%02d',prefix(i,:),image_index);
    display(sprintf('Finding matches for image %s (50%% larger)',model_key));
    image = imread(sprintf('Texture_Images\\%s\\%s.jpg',fileprefix(i),model_key));
    image = imresize(image,1.5);
    new_feature_vector = calcText(image);
    
    %Find matches
    for k = 1:length(indexes)
        chi_value = calcCHI(new_feature_vector,map(indexes(k,:)));
        all_distances(k,:) = [k chi_value];
    end
    %Sort
    sorted_distances = sortrows(all_distances,2);

    %Write to file
    subplot(141);
    set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 10 6]);
    set(gcf, 'Position', [488 342 1324 420]);

    p = floor((sorted_distances(2,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(2,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(2,2)));

    subplot(142);
    p = floor((sorted_distances(3,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(3,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(3,2)));

    subplot(143);
    p = floor((sorted_distances(4,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(4,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(4,2)));    

    subplot(144);
    p = floor((sorted_distances(5,1)-1)/40)+1;
    name_prefix = prefix(p,:);
    name_num = sorted_distances(5,1) - (p-1)*40;
    image = imread(sprintf('Texture_Images\\%s\\%s_%02d.jpg',fileprefix(p),name_prefix,name_num));
    imshow(image);
    title(sprintf('%s %02d: %f',name_prefix,name_num,sorted_distances(5,2))); 

    print(sprintf('%s_resize_larger',model_key),'-dpng','-r300');
end
