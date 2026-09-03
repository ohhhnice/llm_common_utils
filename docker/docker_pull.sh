docker pull vllm/vllm-openai:latest
docker image ls # 查看有哪些docker
docker run vllm/vllm-openai


docker run -it --rm --gpus all \
    -v F:/LLM/model/Qwen/Qwen2.5-VL-3B-Instruct:/root/.cache/huggingface \
    -p 8000:8000 \
    --ipc=host \
    --entrypoint /bin/bash \
    vllm/vllm-openai:cu118