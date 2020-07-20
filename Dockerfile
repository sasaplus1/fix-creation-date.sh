FROM alpine:3.12

RUN apk --update add --no-cache bash coreutils ffmpeg

WORKDIR /mnt

COPY ./fix-creation-date.sh ./fix-creation-date.sh

RUN chmod +x ./fix-creation-date.sh

ENTRYPOINT ["./fix-creation-date.sh"]
