From python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -r requiremen.txt
CMD ["python", "app/main.py"]
