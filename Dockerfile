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
    
# install remoteforkcp
 wget -o - https://github.com/ShutovPS/RemoteFork/releases/download/v1.40.0.12/linux-x64.zip -O RemoteFork.zip && \
 unzip RemoteFork.zip -d /app && \
 mkdir -p /app/linux-x64/Plugins && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/acestreamtv.0.1.3/RemoteFork.Plugins.AceStream.AceStreamTV.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/godzfilm.0.0.1/RemoteFork.Plugins.GodZfilm.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/hdrezka.0.0.8/RemoteFork.Plugins.HDRezka.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/hdserials.0.0.4/RemoteFork.Plugins.HDSerials.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/kinosha.0.0.2/RemoteFork.Plugins.Kinosha.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/nnmclub.0.1.3/RemoteFork.Plugins.AceStream.NnmClub.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/rutor.0.1.0/RemoteFork.Plugins.AceStream.Rutor.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/rutracker.0.1.3/RemoteFork.Plugins.AceStream.Rutracker.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/seasonvar.0.4.8/RemoteFork.Plugins.Seasonvar.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/sensfilm.0.0.3/RemoteFork.Plugins.SensFilm.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/stereotracker.0.1.0/RemoteFork.Plugins.AceStream.StereoTracker.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/youtube.0.1.1/RemoteFork.Plugins.YouTube.dll && \
 wget -o - https://github.com/ShutovPS/RemoteFork.Plugins/releases/download/moonwalk.0.0.5/RemoteFork.Plugins.Moonwalk.dll && \
 mv *.dll /app/linux-x64/Plugins && \
 
#acestream
mkdir -p /opt/acestream.engine/ && \
wget -o - https://sybdata.de/data/acestream/acestream_3.1.33_x86_webUI.tar.gz && \
tar -zxvf acestream_3.1.33_x86_webUI.tar.gz && \
mv acestream.engine/ /opt/ && \
find /opt/acestream.engine/androidfs/system -type d -exec chmod 755 {} \; && \
find /opt/acestream.engine/androidfs/system -type f -exec chmod 644 {} \; && \
chmod 755 /opt/acestream.engine/androidfs/system/bin/* /opt/acestream.engine/androidfs/acestream.engine/python/bin/python && \
dnf -y remove python3-devel && \
dnf -y group remove "C Development Tools and Libraries" && \
dnf -y autoremove && \
dnf clean packages && \

# cleanup
 rm -rf \
	/tmp/* \
	aceproxy.zip \
	acestream_3.1.33_x86_webUI.tar.gz \ 
    RemoteFork.zip

# add local files
ADD acestream.start /opt/acestream.engine/acestream.start
ADD acestream.stop /opt/acestream.engine/acestream.stop
ADD acestream.conf /opt/acestream.engine/androidfs/acestream.engine/acestream.conf
ADD start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh
RUN chmod +x /opt/acestream.engine/acestream.start
RUN chmod +x /opt/acestream.engine/acestream.stop
RUN chmod +x /app/linux-x64/RemoteForkCP


# ports and volumes
EXPOSE 8000 9955 6878 8621 62062 8027
