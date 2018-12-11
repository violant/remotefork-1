RemoteFork

Установка

docker run 
--privileged 
-d 
-e PUID=0 
-e PGID=0 
--net=host 
--name=ace86 
-e TZ=Europe/Helsinki
sybdata/remotefork bash -c "/usr/bin/start.sh your_server_ip 1000"

где:
your_server_ip - адрес машины на которую ставится этот контейнер
1000 - Время очистки кеша acestream в секундах
TZ='timezone'
