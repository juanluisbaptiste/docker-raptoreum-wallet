FROM juanluisbaptiste/xpra-base:latest
MAINTAINER Juan Luis Baptiste <juan.baptiste@gmail.com>
ENV RTM_VERSION "1.3.17.02"
ENV RTM_GUI_DOWNLOAD_URL https://github.com/Raptor3um/raptoreum/releases/download/${RTM_VERSION}/raptoreum-ubuntu22-${RTM_VERSION}.tar.gz
ENV DISPLAY=:100
ENV WEB_VIEW_PORT 10000
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y curl bzip2 libfontconfig1 libfreetype6 libegl1-mesa \
                       libgl1-mesa-glx libqt5core5a libqt5qml5 qt5-default \
                       qml-module-qtquick-controls qml-module-qtquick-xmllistmodel \
                       qttools5-dev-tools qml-module-qtquick-dialogs libx11-6 \
                       libxcb1 libxcb-glx0 libx11-xcb1 wget python3-uinput && \
    apt-get clean && \
    useradd -ms /bin/bash -G xpra rtm
COPY local-entrypoint.sh /
RUN  chmod 755 /local-entrypoint.sh

USER rtm
WORKDIR /home/rtm
RUN mkdir rtm-gui && \
    curl -L ${RTM_GUI_DOWNLOAD_URL} -O && \
    tar -zxf raptoreum-ubuntu22-${RTM_VERSION}.tar.gz -C rtm-gui && \
    ls -th && \
    rm raptoreum-ubuntu22-${RTM_VERSION}.tar.gz
    #mkdir -p /home/rtm/.raptoreumcore
#COPY rtm-core.conf /home/rtm/.raptoreumcore/

CMD ["/local-entrypoint.sh"]
EXPOSE 10000
