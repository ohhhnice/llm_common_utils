# 说明
这里包含了 llm 需要的基础工具，可以快速复用加调用。

# 调用方法

# 补充
## git submodule
### 1. 有子仓库提交
```bash
git submodule add -b 主分支名 远程仓库地址 内层文件夹名
git submodule add -b main git@github.com:ohhhnice/llm_common_utils.git common_utils
```

### 2. clone 主仓库后 + 初始化子仓库
```bash
git submodule update --init --recursive
```