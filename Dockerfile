FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

# Install build tools
RUN apt-get update && apt-get install -y gcc build-essential

# First install numpy and cython so pkuseg can build
RUN pip install --no-cache-dir numpy Cython

# Then install the rest
RUN pip install --no-cache-dir -r requirements.txt

COPY main.py .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]