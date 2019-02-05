FROM alpine:3.8

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

ARG username
ARG password

RUN git clone https://${username}:${password}@github.com/username/repository.git

