FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt install -y autoconf \
	build-essential \
	curl \
	git \
	libsdl2-dev \
	libsdl2-mixer-dev \
	libsdl2-net-dev \
	unzip \
	vim
RUN git clone https://github.com/chocolate-doom/chocolate-doom.git
WORKDIR /chocolate-doom
RUN autoreconf -fiv
RUN ./configure
RUN make -j$(nproc)
RUN curl -LO https://github.com/freedoom/freedoom/releases/download/v0.12.1/freedoom-0.12.1.zip
RUN unzip freedoom-0.12.1.zip
CMD ["./src/chocolate-doom", "-iwad", "freedoom-0.12.1/freedoom1.wad"]
