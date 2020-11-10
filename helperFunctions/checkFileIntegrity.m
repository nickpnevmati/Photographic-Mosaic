try
	projectdir = 'C:\Users\Nick\Documents\MEGAsync Downloads\images\';

	messages = string(1:100);
	files = dir(projectdir);
	j = 1;
	for i = 3 : length(files)
		try
			fprintf('%d/%d\n', i, length(files))
			I = imread(append(projectdir, files(i).name));
		catch ME
			messages(j) = append(ME.message, files(i).name);
			j = j + 1;
		end
	end
catch ME
	messages(end + 1) = ME.message;
end

save('errorLog.mat', 'messages');
