%% create_image_pallete: creates a "list" of the names of images in a directory and their mean pixel values
function [imageIndex] = createImagePallete(directory)

	fprintf('Creating pallete...this might take a while\n')
	files = dir(directory);
	imageIndex = struct;
	j = 1;
	for i = 3 : length(files)
		fprintf('Reading file %d/%d %s\n', i, length(files), files(i).name);
		try
			filename = append(directory, files(i).name);
			I = imread(filename);
			value = mean(rgb2gray(im2double(I)), 'all');
		catch
			delete append(directory, files(i).name);
			continue
		end
		imageIndex(j).name = filename;
		imageIndex(j).value = value;
		j = j + 1;
	end

	imageIndex = sortrows(struct2table(imageIndex), 'value');
