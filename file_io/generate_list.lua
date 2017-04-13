-- Author: Xinshuo Weng
-- email: xinshuo.weng@gmail.com

-- this file contains generate list given a folder

-- argument list:
--		data_source:	a folder contains the data (e.g. image folder)
--		save_path:		a path to save the list file.txt
-- 		filter:			extension which we want to fetch (e.g. png)

local io = require 'io'
require 'string'
require 'lfs'
-- require 'checks'


-- parse input argument
data_dir = arg[1]	-- source dir
save_path = arg[2]	
filter = arg[3]

if data_dir == nil then
	assert(false, 'No input data folder provided')
end
if save_path == nil then
	save_path = './'
end
if filter == nil then
	filter = 'png'
end

-- generate data list
io.output(io.open(save_path, 'w'))
for file in lfs.dir(data_dir) do
    -- find subfolder containing the image
    if lfs.attributes(data_dir .. file, 'mode') == 'directory' and file ~= "." and file ~= ".." then
    	print('please use other script to consider files in ' .. data_dir .. '/' .. file)
    end

    if lfs.attributes(data_dir .. file, 'mode') == 'file' and string.find(file, filter) then
    	io.write(data_dir .. file .. '\n')
    end

end
io.close()