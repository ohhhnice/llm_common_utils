
# vllm
## 1.安装镜像
```bash
docker pull vllm/vllm-openai:latest
docker image ls # 查看有哪些docker
docker run vllm/vllm-openai

# 语音docker
docker pull qwenllm/qwen3-asr:latest
```

## 2. 运行 vllm
## 2.1 进入 docker 后运行
### 2.1.1 进入docker
```bash
# 进入 docker
docker run -it --rm --gpus all \
    -v F:/LLM/model/Qwen/Qwen3-ASR-1.7B:/root/.cache/huggingface \
    -p 8000:8000 \
    --ipc=host \
    --entrypoint //bin/bash \
    --shm-size=10g \
    vllm/vllm-openai
```

### 2.1.2 运行模型
```bash
# 运行模型1 - vllm cli
export VLLM_WSL2_ENABLE_PIN_MEMORY=1
vllm serve /root/.cache/huggingface \
    --host 0.0.0.0 \
    --port 8000 \
    --trust-remote-code \
    --gpu-memory-utilization 0.85 \
    --max-model-len 8192 \
    --served-model-name self_model \
    --quantization fp8

# 如果是语音模型
pip install vllm[audio]
```

```bash
# 运行模型2 - python3
export VLLM_WSL2_ENABLE_PIN_MEMORY=1
python3 -m vllm.entrypoints.openai.api_server \
    --model /root/.cache/huggingface \
    --host 0.0.0.0 \
    --port 8000 \
    --trust-remote-code \
    --gpu-memory-utilization 0.4 \
    --max-model-len 2048
```

### 2.1.3 退出 docker
```bash
exit
```


## 2.2 直接运行
```bash
MSYS_NO_PATHCONV=1 VLLM_WSL2_ENABLE_PIN_MEMORY=1 docker run -it --rm --gpus all \
    -v F:/LLM/model/Qwen/Qwen2.5-VL-3B-Instruct:/root/.cache/huggingface \
    -p 8000:8000 \
    --ipc=host \
    --shm-size=10g \
    vllm/vllm-openai:v0.6.0 \
    python -m vllm.entrypoints.openai.api_server \
    --model /root/.cache/huggingface \
    --host 0.0.0.0 \
    --port 8000 \
    --trust-remote-code \
    --gpu-memory-utilization 0.4 \
    --max-model-len 2048
```