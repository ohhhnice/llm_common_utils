```sh
vllm serve FunAudioLLM/Fun-CosyVoice3-0.5B-2512 \
    --omni \
    --host 127.0.0.1 \
    --port 8091 \
    --trust-remote-code
```