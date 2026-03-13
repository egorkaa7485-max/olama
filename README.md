# Ollama on Railway (CPU/RAM)

Это сервис **Ollama API** для Railway. Он поднимет HTTP сервер Ollama на порту Railway (`$PORT`).

## Важно про ресурсы (8 GB RAM / 8 vCPU)

- `llama3.1:8b` на CPU обычно **работает**, но может быть медленным.
- `llama3.2-vision` (7.8 GB) на CPU и 8 GB RAM часто будет **очень тяжёлым**. Рекомендую вынести vision на более мощный инстанс или использовать меньшую vision‑модель.

## Deploy (самый простой вариант)

1. В Railway создайте **New Project → Deploy from GitHub** (или загрузите проект как repo).
2. В сервисе задайте переменную:
   - `RAILWAY_DOCKERFILE_PATH=ollama_railway/Dockerfile`
3. Добавьте **Volume** и смонтируйте в `/ollama`
   - Тогда модели сохранятся между деплоями в `/ollama/models`.
4. (Опционально) Автоподтягивание модели при старте:
   - `PULL_MODEL_ON_START=1`
   - `OLLAMA_MODEL_TO_PULL=llama3.1:8b`

После деплоя Railway выдаст публичный URL. Ollama API будет доступен по:
- `https://<ваш-домен>/api/...` (зависит от настроек прокси Railway)
- либо напрямую по `https://<ваш-домен>/` на endpoint Ollama.

### Проверка (локально)

Если вы запускаете контейнер локально:

```bash
docker build -t ollama-railway -f ollama_railway/Dockerfile .
docker run --rm -e PORT=11434 -p 11434:11434 ollama-railway
```

И проверить:

```bash
curl http://localhost:11434/api/tags
```

# olama
