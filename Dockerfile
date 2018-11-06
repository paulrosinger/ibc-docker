FROM debian:stable-slim
LABEL maintainer="Paul Rosinger <paul.rosinger@gmail.com>"

RUN apt-get update && apt-get install -y \
      curl \
      inotify-tools \
      unzip \
      xvfb \
      libxtst6 \
      libxrender1 \
      libxi6 \
      socat && apt-get clean && \
      rm -rf /var/lib/apt/lists /var/cache/apt/archives

# RUN curl -o install-ibgateway-972.sh "https://download2.interactivebrokers.com/installers/ibgateway/stable-standalone/ibgateway-stable-standalone-linux-x64.sh"
# RUN curl -L -o ibc.zip "https://github.com/IbcAlpha/IBC/releases/download/3.6.0/IBCLinux-3.6.0.zip"
ADD deps/install-ibgateway-972.sh .
ADD deps/IBCLinux-3.6.0.zip .

RUN echo 'n' | sh install-ibgateway-972.sh
RUN unzip IBCLinux-3.6.0.zip -d /opt/ibc && chmod +x /opt/ibc/*.sh /opt/ibc/scripts/*.sh

ENV IBC_PATH /opt/ibc
ENV TWS_MAJOR_VRSN 972
ENV TWS_PATH /root/Jts
ENV TZ Europe/Zurich

COPY config_template.ini .
COPY start_tws.sh .

EXPOSE 4001

CMD ["./start_tws.sh"]