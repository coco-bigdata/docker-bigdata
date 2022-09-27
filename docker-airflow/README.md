```shell
sudo docker run --rm "debian:bullseye-slim" bash -c 'numfmt --to iec $(echo $(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE))))'

curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.4.0/docker-compose.yaml'
```
