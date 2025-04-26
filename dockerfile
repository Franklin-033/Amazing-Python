From python:3.11-slim
WORKDIR /App
COPY . .
CMD ["python", "App/main.py"]
