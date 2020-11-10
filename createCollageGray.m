function [collage] = createCollageGray(targetImg, imgDir, pixelSize)

Files = dir(append(imgDir, '*.*'));

imageList = cell(1, length(Files));
palleteColors = zeros(1, length(Files));

% read files
% resize images and add them to a "list"
% take the median pixel value of each image and add it to an array
for i = 3 : length(Files)
    currImg = im2double(rgb2gray(imread(append(imgDir, Files(i).name))));
    imageList{i - 2} = imresize(currImg, [pixelSize pixelSize]);
    palleteColors(i - 2) = mean(imageList{i - 2}, 'all');
    
    fprintf(append(['reading files:', num2str(i), '/', num2str(length(Files)), '\n']))
end
palleteColors = palleteColors(1:end-2);
fprintf('Initializing pallete\n')

% cache variables and initialize collage for speed
targetX = size(targetImg, 1);
targetY = size(targetImg, 2);
collage = zeros(targetX * pixelSize - 1, targetY * pixelSize - 1);
targetImg = im2double(rgb2gray(targetImg));
% for each pixel of target image
%   find closest color in pallete
%   add corresponding image to collage
for i = 1 : targetX
    for j = 1 : targetY
        fprintf(append(['Appending image: ', num2str((i - 1) * targetX + j), '/', num2str(targetX * targetY), '\n']))
        
        pixelVal = targetImg(i, j);
        closestMatchIndex = findClosestValueIndex(palleteColors, pixelVal);
        currImg = imageList{closestMatchIndex};
        collage((i - 1) * pixelSize + 1 : i * pixelSize, (j - 1) * pixelSize + 1 : j * pixelSize) = currImg;
    end
end