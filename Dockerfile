FROM bashell/alpine-bash

LABEL authors="https://www.oda-alexandre.com/"

ENV DEBIAN_FRONTEND noninteractive

RUN echo -e '\033[36;1m ******* INSTALL PREREQUISITES ******** \033[0m' && \
apk add curl

RUN echo -e '\033[36;1m ******* ADD SCRIPT ******** \033[0m'
COPY ./auto_merge_requests.sh  /root/auto_merge_requests.sh

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'
CMD bash auto_merge_requests.sh --help