#FROM balenalib/raspberrypi4-64-ubuntu-python
#FROM balenalib/coral-dev-ubuntu:bionic
#FROM balenalib/coral-dev-ubuntu:focal
FROM balenalib/coral-dev-ubuntu-golang

ENV DEBIAN_FRONTEND=noninteractive

# Add google repositories
RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    printf "deb [arch=arm64] https://packages.cloud.google.com/apt mendel-bsp-enterprise-day main \n deb-src https://packages.cloud.google.com/apt mendel-bsp-enterprise-day main" \
    | tee /etc/apt/sources.list.d/multistrap-bsp.list && \
    printf "deb [arch=arm64] https://packages.cloud.google.com/apt mendel-day main \n deb-src https://packages.cloud.google.com/apt mendel-day main" \
    | tee /etc/apt/sources.list.d/multistrap-main.list

# Install Coral Dev samples and dependencies
RUN apt-get update && apt-get install -y libedgetpu1-std libedgetpu-dev imx-gpu-viv weston-imx

RUN apt-get install -y wget

#RUN \
#    apt-get install -y gstreamer1.0-plugins-base=1.14.4+imx-5 \
#    libgstreamer1.0-0=1.14.4+imx-3 \
#    libgstreamer-plugins-base1.0-0=1.14.4+imx-5 \
#    imx-gst1.0-plugin=4.4.5-5 \
#    gstreamer1.0-plugins-good=1.14.4+imx-5 \
#    gstreamer1.0-plugins-bad=1.14.4+imx-7 \
#    libdrm-vivante=2.4.84+imx-mendel3 \
#    libgstreamer-plugins-bad1.0-0=1.14.4+imx-7 \
#    libgstreamer-gl1.0-0=1.14.4+imx-5 \
#    gstreamer1.0-python3-plugin-loader=1.14.4-1+b1 \
#    python3-gst-1.0=1.14.4-1+b1 \
#    gstreamer1.0-plugins-ugly=1.14.4-1 \
#    gir1.2-gst-plugins-base-1.0=1.14.4-2 \
#    gir1.2-gstreamer-1.0=1.14.4-1 \
#    gstreamer1.0-gl=1.14.4+imx-5 \
#    gstreamer1.0-tools=1.14.4+imx-3 \
#    libdrm-libkms=2.4.84+imx-mendel3 \
#    wayland-protocols=1.17+imx-1 \
#    python3-edgetpuvision


#RUN apt-get install -y tzdata \
#    && apt-get install v4l-utils wget -y \
#    && apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio libglib2.0 -y \
#    && apt-get install avahi-daemon libnss-mdns -y \
#    && rm -rf /var/lib/apt/lists/*

RUN apt-get install wget avahi-daemon libnss-mdns -y

RUN apt-get install -y tzdata

RUN apt-get install -y \
    libgstreamer1.0-dev=1.14.4+imx-3 libgstreamer-plugins-base1.0-dev=1.14.4+imx-5 libgstreamer-plugins-bad1.0-dev=1.14.4+imx-7 \
    libgstreamer1.0-0=1.14.4+imx-3 gstreamer1.0-plugins-base=1.14.4+imx-5  \
    gstreamer1.0-plugins-good=1.14.4+imx-5 gstreamer1.0-plugins-bad=1.14.4+imx-7 gstreamer1.0-plugins-ugly=1.14.4-1+deb10u1 \
    gstreamer1.0-libav=1.15.0.1+git20180723+db823502-2+deb10u1 libgstreamer-plugins-bad1.0-0=1.14.4+imx-7 \
    libgstreamer-plugins-base1.0-0=1.14.4+imx-5 libgstreamer-gl1.0-0=1.14.4+imx-5 \
    gstreamer1.0-tools=1.14.4+imx-3 gstreamer1.0-x=1.14.4+imx-5 libglib2.0

RUN  apt-get install v4l-utils=1.16.3-3 && rm -rf /var/lib/apt/lists/*

WORKDIR /src/

RUN wget https://dl.google.com/go/go1.18.2.linux-arm64.tar.gz \
    && tar -C /usr/local -xzf ./go1.18.2.linux-arm64.tar.gz

ENV PATH=${PATH}:/usr/local/go/bin
ENV GOPATH=${HOME}/go

RUN apt-get update && apt-get install -y htop mc
RUN apt-get autoremove -y

WORKDIR /app/
COPY main ./
COPY services.sh ./
RUN chmod +x /app/main

EXPOSE 50051 8100

RUN usermod -aG video root

ENTRYPOINT ["bash", "./services.sh"]

CMD bash
#CMD v4l2-ctl --device /dev/video2 --set-fmt-video=width=640,height=480 ; sleep 5 ; ./main --addr "snake-base.local:50051" -session "ion" -streamtype "sub" -streamid "kir1" -video-src "v4l2src device=/dev/video2 ! video/x-h264, width=640, height=480, framerate=30/1 ! queue ! avdec_h264 max-thread=8 skip-frame=1 ! queue"
