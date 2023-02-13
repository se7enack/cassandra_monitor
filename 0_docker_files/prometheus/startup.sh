
cp /data/prometheus.yaml /etc/prometheus/. &>/dev/null


/etc/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yaml --storage.tsdb.retention=30d
