FROM ubuntu:18.10

# set ports
EXPOSE 8621 62062 6878

RUN \
apt-get update && apt-get upgrade -y && \
apt-get install -y \
git \
python3 \
python-pip \
python3.7-gevent \
python3-psutil \
mc \
tar \
unzip \
htop \
wget \
nano && \
apt-get autoremove -y && \

# install acestream
wget -o - https://www.dropbox.com/s/kz4ov7f0om260jp/acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz && \
mv acestream.engine/ /opt/

# install remotefork
wget -o - https://www.dropbox.com/s/5kf9pzzqm2c21vw/linux-x64.zip && \
unzip linux-x64.zip -d /opt/ && \

# cleanup
rm -rf acestream_3.1.35_ubuntu_18.04_x86_64.tar.gz linux-x64.zip

ADD start.sh /bash/start.sh
RUN chmod +x /bash/start.sh

CMD ["/bash/start.sh"]
