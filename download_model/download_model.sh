# 通过 modelscope 下载模型
# pip install modelscope -i https://pypi.tuna.tsinghua.edu.cn/simple
# pip install modelscope -i https://mirrors.aliyun.com/pypi/simple/

# pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple   # 永久配置镜像

export model_id=Qwen/Qwen2.5-VL-3B-Instruct
export model_download_dir=F:/LLM/model/$model_id
modelscope download --model $model_id --local_dir $model_download_dir  # 下载模型