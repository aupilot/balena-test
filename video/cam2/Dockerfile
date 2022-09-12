FROM balenalib/raspberrypi4-64-ubuntu-python

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata \
    && apt-get upgrade -y \
    && apt-get update -y \
    && apt-get install v4l-utils wget -y \
    && apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio libglib2.0 -y \
    && apt-get install avahi-daemon libnss-mdns -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src/

RUN wget https://dl.google.com/go/go1.18.2.linux-arm64.tar.gz \
    && tar -C /usr/local -xzf ./go1.18.2.linux-arm64.tar.gz

ENV PATH=${PATH}:/usr/local/go/bin
ENV GOPATH=${HOME}/go

RUN apt-get update -y  && apt-get install -y htop

WORKDIR /app/
COPY main ./
COPY services.sh ./
RUN chmod +x /app/main

EXPOSE 50051 8100

RUN usermod -aG video root

ENTRYPOINT ["bash", "./services.sh"]

#CMD bash
CMD v4l2-ctl --device /dev/video6 --set-fmt-video=width=640,height=480 ; sleep 5 ; ./main --addr "snake-base.local:50051" -session "ion" -streamtype "sub" -streamid "kir2" -video-src "v4l2src device=/dev/video6 ! video/x-h264, width=640, height=480, framerate=30/1 ! queue ! avdec_h264 max-thread=8 skip-frame=1 ! queue"
