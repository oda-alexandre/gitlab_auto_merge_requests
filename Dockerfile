FROM alpine

LABEL authors="https://www.oda-alexandre.com/"

RUN echo -e '\033[36;1m ******* INSTALL PREREQUISITES ******** \033[0m'; \
  apk add curl bash

RUN echo -e '\033[36;1m ******* ADD SCRIPT ******** \033[0m'
COPY ./auto_merge_requests.sh  /root/auto_merge_requests.sh

RUN echo -e '\033[36;1m ******* SELECT WORKING SPACE ******** \033[0m'
WORKDIR /root/

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'
CMD bash auto_merge_requests.sh --help