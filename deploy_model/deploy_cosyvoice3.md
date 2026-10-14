# 背景资源
音频：https://ondoku3.com/zh-hans/post/how-to-download-mp3-for-study-english/
MP3转wav网站：https://convertio.co/zh/download/31b794797f46216f033a7932e07197d7fa0da6/

# 一、部署
## 1.1 预准备
在 pretrained_models/Fun-CosyVoice3-0.5B/ 中添加 config.json。
参考：https://docs.vllm.com.cn/projects/vllm-omni/en/latest/user_guide/examples/offline_inference/cosyvoice3/#setup
```bash
export model_dir=/root/.cache/huggingface
cat > $model_dir/config.json <<'EOF'
{
  "model_type": "cosyvoice3",
  "architectures": ["CosyVoice3Model"]
}
EOF
```

## 1.2 下载依赖
```sh
pip install "vllm-omni==0.28.0rc1"
pip install s3tokenizer

pip install -i https://mirrors.aliyun.com/pypi/simple vllm-omni==0.28.0rc1 s3tokenizer
```

## 1.3 软连接
```sh
mkdir -p ~/.cache/s3tokenizer
ln -sf \
  $model_dir/speech_tokenizer_v3.onnx \
  ~/.cache/s3tokenizer/speech_tokenizer_v3_25hz.onnx
```

## 1.4 正式部署
```sh
export model_dir=/root/.cache/huggingface
export VLLM_WSL2_ENABLE_PIN_MEMORY=1
vllm serve $model_dir \
  --omni \
  --trust-remote-code \
  --host 0.0.0.0 \
  --port 8091 \
  --served-model-name self_model \
  --gpu-memory-utilization 0.85 \
  --max-model-len 8192 \
  --allowed-local-media-path /vllm-workspace/data/
```

# 二、调用
```sh
curl -X POST http://127.0.0.1:8091/v1/audio/speech \
  -H "Content-Type: application/json" \
  -d '{
    "model": "self_model",
    "input": "还没打完么？[breath]我都输了，呜呜呜。。。",
    "response_format": "wav",
    "ref_audio": "file:///vllm-workspace/data/就这么两句应该就够了吧.wav",
    "ref_text": "就这么两句应该就够了吧",
    "speed": 1,
    "instructions": "请用悲伤且委屈的语气表达，特别难受那种"
  }' \
  --output /vllm-workspace/data/gen_wav/out_2.wav
```

```python
import base64
import requests

url = "http://127.0.0.1:8091/v1/audio/speech"

with open(r"F:/LLM/play_ground/reference.wav", "rb") as f:
    ref_audio = base64.b64encode(f.read()).decode()

payload = {
    "model": "FunAudioLLM/Fun-CosyVoice3-0.5B-2512",
    "input": "你好，这是一个 CosyVoice3 的测试。",
    "voice": "default",
    "ref_audio": ref_audio,
    "ref_text": "希望你以后能够做的比我还好呦。",
    "response_format": "wav"
}

response = requests.post(
    url,
    json=payload,
    timeout=300
)

print(response.status_code)
print(response.headers.get("content-type"))

response.raise_for_status()

with open("output.wav", "wb") as f:
    f.write(response.content)

print("saved to output.wav")
```


# 三、训练
pass