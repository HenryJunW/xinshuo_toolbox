% Author: Xinshuo Weng
% email: xinshuo.weng@gmail.com

function num_images = resize_images(src_path, save_dir, resize_size, ext_filter, debug_mode)
	if ~exist('ext_filter', 'var')
		ext_filter = 'jpg';
	end

	if ~exist('debug_mode', 'var')
		debug_mode = true;
	end

	if debug_mode
		assert(ischar(src_path), 'source path is not correct');
		assert((isvector(resize_size) && numel(resize_size) == 2) || isscalar(resize_size), 'resize size is not correct');
		assert(ischar(save_dir), 'save path is not correct');
	end
	mkdir_if_missing(save_dir);
	ext_filter = check_extension(ext_filter, debug_mode);

	% load imagelist
	fprintf('load image data from %s\n', src_path);
	[image_list, num_images] = load_list_from_folder(src_path, ext_filter, debug_mode);
	fprintf('number of images to process is %d\n\n', num_images);

	% resize all images
    time = tic;
	for i = 1:num_images
		image_path_temp = image_list{i};
		[~, filename, ~] = fileparts(image_path_temp);

		% counting time
		elapsed = toc(time);
        remaining_str = string(py.timer.format_time(elapsed / i * (num_images - i)));
        elapsed_str = string(py.timer.format_time(toc(time)));
        fprintf('resizing images %d/%d, filename: %s, elapsed time: %s, remaining time: %s\n', i, num_images, filename, elapsed_str, remaining_str);

        % process
        save_path = fullfile(save_dir, strcat(filename, ext_filter));
        if exist(save_path, 'file')
        	continue;
        end
		image_temp = imread(image_path_temp);
		resized = imresize(image_temp, resize_size);
		imwrite(resized, save_path);
	end
end