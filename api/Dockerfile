FROM python:3.9.10

WORKDIR /filtering

ENV PORT 8080
ENV HOST 0.0.0.0

COPY requirements.txt .

RUN pip install --trusted-host pypi.python.org -r requirements.txt

COPY . .

ENTRYPOINT ["python", "filtering.py"]

CMD exec gunicorn --bind 0.0.0.0:8080 --workers 1 --threads 8 app:app