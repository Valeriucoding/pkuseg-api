FROM --platform=linux/arm64 python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# If pip install pkuseg fails in Docker, add compilation steps
# RUN apt-get update && apt-get install -y build-essential git \
#     && git clone https://github.com/lancopku/pkuseg-python.git \
#     && cd pkuseg-python \
#     && python setup.py build_ext -i \
#     && python setup.py install \
#     && cd .. && rm -rf pkuseg-python

COPY main.py .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
