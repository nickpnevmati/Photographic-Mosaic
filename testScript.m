imdir = 'C:\Users\Nick\Documents\MEGAsync Downloads\images\';
target = imresize(imread('target2.jpg'), 1/6);
componentImageSize = 64;

I = create_collae_gray_V2(target, imdir, componentImageSize);
imwrite(I, 'output.png', 'jpg');
