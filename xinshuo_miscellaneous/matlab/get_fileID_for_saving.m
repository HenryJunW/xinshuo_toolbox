% Author: Xinshuo Weng
% email: xinshuo.weng@gmail.com

% this function gets a file id while saving txt given a path
function fileID = get_fileID_for_saving(save_path)
	assert(ischar(save_path), 'The save path should be a char while getting fileID.');
	mkdir_if_missing(fileparts(save_path));
	fileID = fopen(save_path, 'w');
end