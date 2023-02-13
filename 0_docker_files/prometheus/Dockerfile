FROM ubuntu:latest

WORKDIR /etc/

ENV PROMETHEUS_VERSION=2.3.1

ENV NODE_EXPORTER_VERSION=1.5.0

ENV NAME=prometheus-${PROMETHEUS_VERSION}.linux-amd64

RUN apt-get update && apt-get install -y wget vim curl

RUN wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/${NAME}.tar.gz && tar xvfz ${NAME}.tar.gz&& rm -f ${NAME}.tar.gz

RUN mv ${NAME} prometheus

COPY prometheus.yaml prometheus/.

COPY startup.sh prometheus/.

WORKDIR /

ENTRYPOINT ["/bin/bash"]

CMD ["/etc/prometheus/startup.sh"]

