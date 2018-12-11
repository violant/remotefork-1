RemoteFork

Установка
docker run --privileged -d -e PUID=0 -e PGID=0 --net=host -e TZ=Europe/Helsinki tarmets/remotefork bash -c "/usr/bin/start.sh your_server_ip 1000"

чтобы зайти в настройки RemoteFork наберите your_server_ip:8027

your_server_ip - адрес машины на которую ставится этот контейнер
1000 - Время очистки кеша acestream в секундах
TZ='timezone'
