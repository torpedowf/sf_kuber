1) Собирать логи будем с помощью loghouse:
https://github.com/flant/loghouse
Добавляем репозиторий:
```
helm repo add loghouse https://flant.github.io/loghouse/charts/  
```
Устанавливаем loghouse:
```
helm install --namespace loghouse --create-namespace -f --set global.dnsService=coredns --set spec.type=LoadBalancer monitor/loghouse/loghouse-values.yml loghouse loghouse/loghouse
```
Заходим по адресу: {{ ip_cluster }}:8080 создаём дашборд и смотрим логи:
![loghouse](https://github.com/mazespd/DevOps-Sprint-3/assets/131882625/3d5ac9b1-85e7-49e9-87d9-1d09bc7d4996)

2)Для мониторинга кластера и приложения будем использовать Prometheus stack: https://artifacthub.io/packages/helm/prometheus-community/prometheus?modal=install
В каталоге prometheus_stack рядом с файлом docker-compose.yml запускаем:
```
docker compose up -d 
```
Потом смотрим контейнеры:
![docker](https://github.com/mazespd/DevOps-Sprint-3/assets/131882625/8af4091f-868e-4516-9d2c-6d869584b52c)

Из готовых дашбордов ставим нужные нам: https://grafana.com/grafana/dashboards/
![dashboards](https://github.com/mazespd/DevOps-Sprint-3/assets/131882625/5cf1e3aa-492c-4b41-9bf1-c1791b914ff7)
![d1](https://github.com/mazespd/DevOps-Sprint-3/assets/131882625/3c4120e8-4420-4d31-b49d-3e77cad9620e)
![d2](https://github.com/mazespd/DevOps-Sprint-3/assets/131882625/20db26e3-e5b7-4489-b963-52c54823bf22)

3)В файле docker-compose.yml подставляем данные для подключения к нашему telegram боту.
Получаем уведомление:
![tg](https://github.com/mazespd/DevOps-Sprint-3/assets/131882625/43195bf4-1945-4705-868c-692484994e4d)

