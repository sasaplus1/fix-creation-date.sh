# fix-creation-date.sh

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/sasaplus1/fix-creation-date.sh.svg)](https://hub.docker.com/r/sasaplus1/fix-creation-date.sh)
[![renovate](https://badges.renovateapi.com/github/sasaplus1/fix-creation-date.sh)](https://renovatebot.com)

fix `creation_date` metadata within mp4 from filename(for the Nintendo Switch)

## Requires

- [ffmpeg](https://www.ffmpeg.org/)

## How to use

```console
$ ls -1 *.mp4
2018072819214100-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.mp4
2018072819382800-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.mp4
2018072820022400-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.mp4
2018072820063400-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.mp4
2018072820110700-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.mp4
2018072820154100-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.mp4
2018072820174700-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.mp4
2018072820212500-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.mp4
2018072820303200-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.mp4
$ ls -1 *.mp4 | xargs -n 1 ./fix-creation-date.sh
```

## License

The MIT license.
