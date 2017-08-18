FROM ubuntu:14.04
MAINTAINER Peter Belmann

# ENV http_proxy http://rzproxy.helmholtz-hzi.de:3128
# ENV https_proxy http://rzproxy.helmholtz-hzi.de:3128

ARG DIALIGN_DESTINATION=/dialign
RUN apt-get update
RUN apt-get install -y wget build-essential
RUN wget http://bibiserv.techfak.uni-bielefeld.de/applications/dialign/resources/downloads/dialign-2.2.1-src.tar.gz

RUN tar xzvf dialign-2.2.1-src.tar.gz --owner root --group root --no-same-owner 
ENV DIALIGN_PATH /dialign_package
RUN make -C ${DIALIGN_PATH}/src
ENV DIALIGN2_DIR ${DIALIGN_PATH}/dialign2_dir
RUN mkdir -p $(dirname $DIALIGN_DESTINATION) && mv ${DIALIGN_PATH}/src/dialign2-2 ${DIALIGN_DESTINATION}

ENTRYPOINT [$DIALIGN_DESTINATION]
