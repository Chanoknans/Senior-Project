FROM python:3.9.10

WORKDIR /filtering

COPY requirements.txt .

RUN pip install --trusted-host pypi.python.org -r requirements.txt

COPY . .

ENTRYPOINT ["python", "filtering.py"]