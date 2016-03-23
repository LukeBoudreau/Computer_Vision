%part 2 Image retrieval using color histogram features
%% A)
%bar(h_concatenated);
% Create data structure to store all histograms
% Key = Integer, Value = histogram values
map = containers.Map('KeyType', 'double','ValueType','any');

% Read in all images
bin = zeros([1 32]);
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
    r_2 = bin;
    r_2(:) = r_h.Values;
    g_h = histogram(g(:)','BinWidth',8);
    g_2 = bin;
    g_2(:) = g_h.Values;
    b_h = histogram(b(:)','BinWidth',8);
    b_2 = bin;
    b_2(:) = b_h.Values;

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
    %repeat 3 times
    for j = 1:3
        model_key = randi([i*100 (i+1)*100-1]);
        model_histogram = map(model_key);
        %This map contains the top 4 histogram matches
        top_matches = containers.Map('KeyType', 'double','ValueType','any');
        %Check very image's histogram to find top 4 matches
        for h=200:900
            if(i>=400 && i<=499)
                continue;
            end
            intersection = calcIntersection(model_histogram,map(h));
            
        end
        
    end
end
