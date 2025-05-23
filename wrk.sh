#!/bin/bash

c=1
t=1
d="1s"
s=""

while getopts ":c:t:d:s:" opt
    do
    case "$opt" in
        "c")
            c=$OPTARG
        ;;
        "t")
            s=$OPTARG
        ;;
        "d")
            d=$OPTARG
        ;;
        "s")
            s=$OPTARG
        ;;
        "?")
            echo "Unknown option $OPTARG"
        ;;
        ":")
            echo "No argument value for option $OPTARG"
        ;;
        *)
          # Should not occur
            echo "Unknown error while processing options"
        ;;
    esac
done

while read line; do
  echo "wrk -c $c -t $t -d $d -s $s --latency http://$line"
  wrk -c $c -t $t -d $d -s $s --latency http://$line > log/$line.log 2>&1 &
done < hosts.txt
bash-4.2# ls
hosts.txt  log  paths.lua  paths.txt  wrk-scripts  wrk.sh
bash-4.2# cat paths.lua 
-- 使用局部变量提高性能
local counter = 0
local math_random = math.random
local io_open = io.open
local io_lines = io.lines

-- 初始化随机数生成器
math.randomseed(os.time())
-- 丢弃前几个随机数以获得更好的随机性
math_random(); math_random(); math_random()

-- 检查文件是否存在
local function file_exists(file)
    local f = io_open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

-- 优化的shuffle算法
local function shuffle(paths)
    local n = #paths
    -- 使用Fisher-Yates算法
    for i = n, 2, -1 do
        local j = math_random(i)
        paths[i], paths[j] = paths[j], paths[i]
    end
    return paths
end

-- 从文件读取非空行
local function non_empty_lines_from(file)
    if not file_exists(file) then 
        return {} 
    end
    
    local lines = {}
    local count = 0
    for line in io_lines(file) do
        if line ~= '' then
            count = count + 1
            lines[count] = line
        end
    end
    return shuffle(lines)
end

-- 读取路径文件
local paths = non_empty_lines_from("paths.txt")

-- 检查路径是否为空
if #paths <= 0 then
    print("multiplepaths: 未找到路径。请创建paths.txt文件并在每行添加一个路径")
    os.exit(1)
end

print("multiplepaths: 找到 " .. #paths .. " 个路径")

-- wrk请求处理函数
request = function()
    local path = paths[counter + 1]  -- 使用1-based索引
    counter = (counter + 1) % #paths
    return wrk.format(nil, path)
end
bash-4.2# ls
hosts.txt  log  paths.lua  paths.txt  wrk-scripts  wrk.sh
bash-4.2# cat wrk.sh 
#!/bin/bash

c=1
t=1
d="1s"
s=""

while getopts ":c:t:d:s:" opt
    do
    case "$opt" in
        "c")
            c=$OPTARG
        ;;
        "t")
            s=$OPTARG
        ;;
        "d")
            d=$OPTARG
        ;;
        "s")
            s=$OPTARG
        ;;
        "?")
            echo "Unknown option $OPTARG"
        ;;
        ":")
            echo "No argument value for option $OPTARG"
        ;;
        *)
          # Should not occur
            echo "Unknown error while processing options"
        ;;
    esac
done

while read line; do
  echo "wrk -c $c -t $t -d $d -s $s --latency http://$line"
  wrk -c $c -t $t -d $d -s $s --latency http://$line > log/$line.log 2>&1 &
done < hosts.txt
