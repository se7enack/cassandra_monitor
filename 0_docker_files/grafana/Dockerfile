FROM ubuntu:latest

WORKDIR /opt/grafana

ENV VERSION=5.1.4

RUN apt-get update && apt-get install -y wget vim adduser libfontconfig

RUN wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_${VERSION}_amd64.deb && dpkg -i grafana_${VERSION}_amd64.deb

COPY startup.sh .

ENTRYPOINT ["/bin/bash"]

CMD ["/opt/grafana/startup.sh"]




