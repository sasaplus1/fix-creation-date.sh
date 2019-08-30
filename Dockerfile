FROM alpine:3.10

RUN apk --update add --no-cache bash coreutils ffmpeg

WORKDIR /root

COPY ./fix-creation-date.sh ./fix-creation-date.sh

RUN chmod +x ./fix-creation-date.sh

CMD ["bash", "-c", "find ./share -type f -iname \\*.mp4 | xargs -n 1 ./fix-creation-date.sh"]
