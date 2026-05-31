# Dockerfile
FROM python:3.11-slim
 
# Установка локалей для поддержки кириллицы
ENV DEBIAN_FRONTEND=noninteractive
 
WORKDIR /app
 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
 
COPY app.py .
 
# Проверка работоспособности контейнера
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1
 
EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

