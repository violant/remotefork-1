FROM ubuntu:18.10

# set ports
EXPOSE 8027 6878 8621 62062

# update
RUN apt-get update && apt-get upgrade -y

# install apt
RUN apt-get install -y \
python3 \
python-pkg-resources \
python-setuptools \
python3-setuptools \
python-libxslt1 \
python-m2crypto \
python-minimal \
python3-venv \
python-wheel \
python3-dev \
python-apsw  \
python-lxml \
python3-pip \
build-essential \
libpython2.7 \
libssl1.0.0 \
sudo \
nano \
tar \
unzip \
wget \
mc

RUN pip3 install --upgrade psutil && \
pip3 install --upgrade gevent

# install acestream
RUN wget -o - https://www.dropbox.com/s/6yh7tf1tr2t8is6/acestream_3.1.49_ubuntu_18.04_x86_64.zip && \
unzip acestream_3.1.49_ubuntu_18.04_x86_64.zip -d /opt/

# install remotefork
RUN wget -o - https://www.dropbox.com/s/5kf9pzzqm2c21vw/linux-x64.zip && \
unzip linux-x64.zip -d /opt/

# cleanup
RUN rm -rf acestream_3.1.49_ubuntu_18.04_x86_64.zip linux-x64.zip && \
apt autoremove -y

# add files
ADD start.sh /bin/start.sh
RUN chmod +x /bin/start.sh
CMD ["/bin/start.sh"]
