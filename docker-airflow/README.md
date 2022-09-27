```shell
sudo docker run --rm "debian:bullseye-slim" bash -c 'numfmt --to iec $(echo $(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE))))'

https://docs.docker.com/compose/install/
sudo yum install docker-compose-plugin

docker compose version

https://airflow.apache.org/docs/apache-airflow/2.4.0/docker-compose.yaml
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.4.0/docker-compose.yaml'

mkdir -p ./dags ./logs ./plugins
echo -e "AIRFLOW_UID=$(id -u)" > .env

sudo docker-compose up airflow-init
```
