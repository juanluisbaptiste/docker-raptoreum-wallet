FROM juanluisbaptiste/xpra-base:latest
MAINTAINER Juan Luis Baptiste <juan.baptiste@gmail.com>
ENV RTM_VERSION "1.2.15.3"
ENV RTM_GUI_DOWNLOAD_URL https://github.com/Raptor3um/raptoreum/releases/download/${RTM_VERSION}/raptoreum_${RTM_VERSION}_ubuntu20_64.tar.gz
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

WORKDIR /root
RUN  id
RUN mkdir rtm-gui && \
    curl -L ${RTM_GUI_DOWNLOAD_URL} -O && \
    tar -zxf raptoreum_${RTM_VERSION}_ubuntu20_64.tar.gz -C rtm-gui && \
    ls -th && \
    rm raptoreum_${RTM_VERSION}_ubuntu20_64.tar.gz

CMD ["/local-entrypoint.sh"]
EXPOSE 10000
