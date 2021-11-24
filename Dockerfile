FROM python:3.7-slim
RUN apt-get update -qqy && \
	apt-get -qqy install g++ && \
    apt-get -qqy install wget && \
	rm -rf /var/lib/apt/lists/*

# show python logs as they occur
ENV PYTHONUNBUFFERED=0

# download the grpc health probe(can use this tool for our services monitoring)
RUN GRPC_HEALTH_PROBE_VERSION=v0.4.6 && \
    wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /bin/grpc_health_probe

WORKDIR /app

#RUN apt-get install gcc python3-dev


COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
#RUN pip-compile --output-file=requirements.txt requirements.in
COPY . .

CMD [ "python3", "/app/locustfile.py"]
