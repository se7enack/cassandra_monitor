>push a copy of the docker images:
docker build . -t grafana:1.0 && docker push grafana:1.0
docker build . -t prometheus:1.0 && docker push prometheus:1.0


>create k8s cluster namespace:
kubectl create ns cassandra-mon


>apply cassandramon yaml:
kubectl apply -f cassandramon


>shell into the prometheus pod and copy the prometheus.yaml to /data:
cp /etc/prometheus/prometheus.yaml /data/.


>edit /data/prometheus.yaml to look at the nodes IPs from your dc and rename 'job_name' to match your DC.

>restart the pod


>copy files up to each node:
scp jmx_prometheus_javaagent-0.13.0.jar jmx_exporter.yaml 10.10.10.1:/tmp/.


>ssh to the node:
sudo su
cp /tmp/jmx_prometheus_javaagent-0.13.0.jar /usr/share/cassandra/lib/. && chmod 644 /usr/share/cassandra/lib/jmx_prometheus_javaagent-0.13.0.jar && cp /tmp/jmx_exporter.yaml /etc/cassandra/conf/. && chmod 775 /etc/cassandra/conf/jmx_exporter.yaml && chown cassandra:cassandra /etc/cassandra/conf/jmx_exporter.yaml && echo good

>edit cassandra-env.sh
vi /etc/cassandra/conf/cassandra-env.sh 

>put the following under the line with 'jamm':
# add jmx exporter
JVM_OPTS="$JVM_OPTS -javaagent:/usr/share/cassandra/lib/jmx_prometheus_javaagent-0.13.0.jar=7070:/etc/cassandra/conf/jmx_exporter.yaml"


>resstart and verify node is up before moving to next node:
systemctl restart cassandra
systemctl status cassandra
tail /var/log/cassandra/cassandra.log -f
nodetool status






