function [collage] = createCollageGrayDisk(targetImg, imgDir, pixelSize)

targetImg = rgb2gray(targetImg);

addpath('helperFunctions');

if(~isfile('index.mat'))
    fprintf('File not found, creating new image pallete...\n');
    imagePallete = create_image_pallete(imgDir);
    save('index.mat', 'imagePallete');
else
    fprintf('File found, loading...\n');
    load('index.mat', 'imagePallete');
end

% for each pixel of target image
%   find closest color in pallete
%   add corresponding image to collage
targetImg = im2double(targetImg);
targetX = size(targetImg, 1);
targetY = size(targetImg, 2);
collage = zeros(targetX * pixelSize - 1, targetY * pixelSize - 1);
imageValArray = table2array(imagePallete(:, 2));

counter = 1;
for i = 1 : targetX
    for j = 1 : targetY
        fprintf(append(['Appending image: ', num2str(counter), '/', num2str(targetX * targetY), '\n']));
        counter = counter + 1;
        pixelVal = targetImg(i, j);
        
        palletIndex = findClosestValueIndex(imageValArray, pixelVal);
        
        fileName = imagePallete.name{palletIndex, 1};
        
        aproximation = imresize(rgb2gray(imread(fileName)), [pixelSize pixelSize]); 
        
        collage((i - 1) * pixelSize + 1 : i * pixelSize, (j - 1) * pixelSize + 1 : j * pixelSize) = im2double(aproximation);
    end
end