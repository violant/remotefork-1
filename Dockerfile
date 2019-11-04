FROM ubuntu:18.10

# time zone data
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# set ports
EXPOSE 8027 6878 8621 62062

# update
RUN apt-get update && apt-get upgrade -y

# install apt
RUN apt-get install -y \
python-setuptools \
python-m2crypto \
python-libxslt1 \
python-apsw \
build-essential \
libpython2.7 \
libssl1.0.0 \
cron \
sudo \
nano \
tar \
unzip \
wget \
mc

# install acestream
RUN wget --no-check-certificate https://github.com/tarmets/httpaceproxy2/blob/master/add/acestream_3.1.49_ubuntu_18.04_x86_64.zip?raw=true && \
unzip acestream_3.1.49_ubuntu_18.04_x86_64.zip?raw=true -d /opt/

# install remotefork
RUN wget -o - https://www.dropbox.com/s/5kf9pzzqm2c21vw/linux-x64.zip && \
unzip linux-x64.zip -d /opt/

# cron-comand
RUN (crontab -l ; echo "00 0-23/12 * * * apt-get update && apt-get upgrade -y && apt autoremove -y") | crontab

# cleanup
RUN rm -rf acestream_3.1.49_ubuntu_18.04_x86_64.zip?raw=true linux-x64.zip && \
apt autoremove -y

# add files
ADD add/acestream.conf /opt/acestream.engine/acestream.conf
ADD add/start.sh /bin/start.sh
RUN chmod +x /bin/start.sh
CMD ["/bin/start.sh"]
