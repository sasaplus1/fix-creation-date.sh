#!/bin/bash

# (The MIT LICENSE)
#
# Copyright (c) 2018 sasa+1 <sasaplus1@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

set -euo pipefail

trap 'printf -- "%s\n" "ERROR: line no = $LINENO, exit status = $?" >&2; exit 1' ERR

__main() {
  local file="$1"

  if [ ! -f "$file" ]
  then
    return 1
  fi

  local filename

  filename=$(basename "$file")

  local YYYY=${filename:0:4} # YYYY
  local MM=${filename:4:2}   # MM
  local DD=${filename:6:2}   # DD
  local hh=${filename:8:2}   # hh
  local mm=${filename:10:2}  # mm
  local ss=${filename:12:2}  # ss

  # NOTE: %Y-%m-%dT%H:%M:%S
  local format='%FT%T'
  local new_date="${YYYY}-${MM}-${DD}T${hh}:${mm}:${ss}"

  local time=

  # NOTE: to UTC from JST
  if date --utc 1>/dev/null 2>&1 && :
  then
    # NOTE: for GNU
    time=$(date --utc --date "${new_date}Z+09:00" +"${format}")
  else
    # NOTE: for BSD
    time=$(date -j -v-9H -f "${format}" "${new_date}" +"${format}")
  fi

  printf -- '%s\n' "processing to ${filename}..."
  printf -- '%s\n' "from: ${new_date}"
  printf -- '%s\n' "to:   ${time}"

  local file_without_extension="${file%.*}"
  local extension="${file##*.}"
  local new_file="${file_without_extension}_new.${extension}"

  # NOTE: update creation_time
  ffmpeg -i "${file}" -metadata creation_time="${time}" -vcodec copy -acodec copy "${new_file}" < /dev/null

  unset -f __main
}
__main "$1"
