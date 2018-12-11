FROM coresystem/remotefork

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

# install base packages
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

RUN apt-get update -y && \
    apt-get install -y apt-utils && \
    apt-get install -y \
    nano \
    tzdata \
    htop \
    mc \
    wget && \
    
# install acestream-engine
   wget -o - https://github.com/ShutovPS/RemoteFork/releases/download/v1.40.0.12/linux-x64.zip && \
   unzip linux-x64.zip && \
   mv linux-x64 app && \
   rm -rf /app/wwwroot && \
   mv app/* /app && \
   wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/hdrezka.0.0.8/RemoteFork.Plugins.HDRezka.dll && \
   wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/kinosha.0.0.2/RemoteFork.Plugins.Kinosha.dll && \
   wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/moonwalk.0.0.5/RemoteFork.Plugins.Moonwalk.dll && \
   mv *.dll /app/Plugins && \
   wget -o - https://www.dropbox.com/s/wde2cc3hma9f94f/acestream_3.1.33_x86_webUI.tar.gz && \
   tar -zxvf acestream_3.1.33_x86_webUI.tar.gz && \
   mv acestream.engine/ /opt/ && \
   find /opt/acestream.engine/androidfs/system -type d -exec chmod 755 {} \; && \
   find /opt/acestream.engine/androidfs/system -type f -exec chmod 644 {} \; && \
   chmod 755 /opt/acestream.engine/androidfs/system/bin/* /opt/acestream.engine/androidfs/acestream.engine/python/bin/python && \
   rm -rf /tmp/* /opt/acestream/* /RunApp.sh
   
# add services
ADD acestream.conf /opt/acestream.engine/androidfs/acestream.engine/acestream.conf
ADD start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

EXPOSE 8621 62062 6878 8027 9955

WORKDIR /
