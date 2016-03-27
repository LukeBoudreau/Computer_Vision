%part 2 Image retrieval using color histogram features
%% A)
%bar(h_concatenated);
% Create data structure to store all histograms
% Key = Integer, Value = histogram values
map = containers.Map('KeyType', 'double','ValueType','any');

% Read in all images
for i = 200:999
    %Skip over 400s
    if i>=400 && i<=499
        continue;
    end
    if mod(i,100) == 0
        display(sprintf('Adding %d''s',i));
    end
    file_url = sprintf('Color_Images\\Color_Images\\%d.jpg',i);
    
    rgb = imread(file_url);
    r = rgb(:,:,1);
    g = rgb(:,:,2);
    b = rgb(:,:,3);

    % Make 96 Bin quantized histogram (32 Bins each, 8 values per bin).

    r_h = histogram(r(:)','BinWidth',8);
    r_2 = r_h.Values;
    requiredPadding = 32 - length(r_2);
    r_2(end+requiredPadding)=0;
    
    g_h = histogram(g(:)','BinWidth',8);
    g_2 = g_h.Values;
    requiredPadding = 32 - length(g_2);
    g_2(end+requiredPadding)=0;
    
    b_h = histogram(b(:)','BinWidth',8);
    b_2 = b_h.Values;
    requiredPadding = 32 - length(b_2);
    b_2(end+requiredPadding)=0;

    h_concatenated = [r_2 g_2 b_2];
    %Add values to map
    map(i) = h_concatenated;
end

%% B & C

for i = 2:9
    %Skip 400 images
    if( i == 4)
        continue;
    end

    %Pick 3 different images for each class
    tableData = zeros([3 5]);
    tableData(:,1) = randi([i*100 (i+1)*100-1],[3 1]);
    %Ensure we picked 3 different images
    len = length(unique(tableData(:,1)));
    while len ~= 3
        tableData(:,1) = randi([i*100 (i+1)*100-1],[3 1]);
        len = length(unique(tableData(:,1)));
    end

    for j = 1:3
        model_key = tableData(j,1);
        display(sprintf('Finding matches for image %d',model_key));
        model_histogram = map(model_key);
        %This matrix will hold all the key value pairs
        all_intersections = zeros([600 2]);
        %Check very image's histogram to find top 4 matches
        index = 1;
        for h=200:999
            if(h>=400 && h<=499)
                continue;
            end
            intersection = calcIntersection(model_histogram,map(h));
            all_intersections(index,1) = h;
            all_intersections(index,2) = intersection;
            index = index + 1;
        end
        %sort 
        sorted_intersections = sortrows(all_intersections,-2);
        %Write to file
        subplot(141);
        set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 10 6]);
        set(gcf, 'Position', [488 342 1324 420]);
        
        name = sorted_intersections(2,1);
        image = imread(sprintf('Color_Images\\Color_Images\\%d.jpg',name));
        imshow(image);
        title(sprintf('%d: %f',name,sorted_intersections(2,2)));
        tableData(j,2) = floor(name/100)*100;
        
        subplot(142);
        name = sorted_intersections(3,1);
        image = imread(sprintf('Color_Images\\Color_Images\\%d.jpg',name));
        imshow(image);
        title(sprintf('%d: %f',name,sorted_intersections(3,2)));
        tableData(j,3) = floor(name/100)*100;
        
        subplot(143);
        name = sorted_intersections(4,1);
        image = imread(sprintf('Color_Images\\Color_Images\\%d.jpg',name));
        imshow(image);
        title(sprintf('%d: %f',name,sorted_intersections(4,2)));
        tableData(j,4) = floor(name/100)*100;        
        
        subplot(144);
        name = sorted_intersections(5,1);
        image = imread(sprintf('Color_Images\\Color_Images\\%d.jpg',name));
        imshow(image);
        title(sprintf('%d: %f',name,sorted_intersections(5,2)));
        tableData(j,5) = floor(name/100)*100;
        
        print(sprintf('%d_color_matches',model_key),'-dpng','-r300');
    end
    %Generate Table
    Image1 = tableData(:,2);
    Image2 = tableData(:,3);
    Image3 = tableData(:,4);
    Image4 = tableData(:,5);
    models = {sprintf('%d',tableData(1,1));sprintf('%d',tableData(2,1));sprintf('%d',tableData(3,1))};
    T = table(Image1,Image2,Image3,Image4,'RowNames',models)
end
