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

sudo docker compose up airflow-init
sudo docker compose up -d
sudo docker compose ps
sudo docker compose run airflow-worker airflow info

curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.4.0/airflow.sh'
chmod +x airflow.sh

./airflow.sh info
./airflow.sh bash
./airflow.sh python

ENDPOINT_URL="http://localhost:8117/"
curl -X GET  \
    --user "airflow:airflow" \
    "${ENDPOINT_URL}/api/v1/pools"

sudo docker compose down --volumes --rmi all

http://49.232.6.131:8117
airflow
airflow
```
