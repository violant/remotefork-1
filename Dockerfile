FROM ubuntu:18.10

# set ports
EXPOSE 62062 6878 8027 8621

# update apt and install
RUN \
apt-get update && apt-get upgrade -y && \
apt-get install -y --no-install-recommends \
python3 \
python-pkg-resources \
python-setuptools \
python3-setuptools \
python-libxslt1 \
python-m2crypto \
python-minimal \
build-essential \
libpython2.7 \
python3-venv \
python-wheel \
python3-dev \
python-apsw  \
python-lxml \
libssl1.0.0 \
python3-pip \
sudo \
nano \
mc \
tar \
unzip \
wget \
gcc && \
apt autoremove -y && \
pip3 install --upgrade psutil && \
pip3 install --upgrade gevent && \

# install acestream
wget -o - https://www.dropbox.com/s/6yh7tf1tr2t8is6/acestream_3.1.49_ubuntu_18.04_x86_64.zip && \
unzip acestream_3.1.49_ubuntu_18.04_x86_64.zip -d /opt/ && \

# install remotefork
wget -o - https://www.dropbox.com/s/5kf9pzzqm2c21vw/linux-x64.zip && \
unzip linux-x64.zip -d /opt/ && \

# cleanup
rm -rf acestream_3.1.49_ubuntu_18.04_x86_64.zip linux-x64.zip

# add local files
ADD start.sh /bash/start.sh
RUN chmod +x /bash/start.sh
CMD ["/bash/start.sh"]
