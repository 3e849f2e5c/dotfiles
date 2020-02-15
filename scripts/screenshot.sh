#!/bin/bash

FS_TMP_DIR="/tmp/screenshot.png"

flameshot gui -r > "${FS_TMP_DIR}"

# Upload the file to the target
fs_upload_file() {
  CURL_UPLOAD=$(curl -X POST -H "$SCREENSHOT_AUTH_BASIC" -F "files[]=@${FS_TMP_DIR}" "$1")
  echo "${CURL_UPLOAD}"
  unset CURL_UPLOAD
  return 0
}

# Parse pomf.cat output
pomf_parse_output() {
  POMF_JQ_PARSE=$(echo "$1" | jq -r '.files[0].url' | tr -d '\n')
  echo "${POMF_JQ_PARSE}"
  unset POMF_JQ_PARSE
  return 0
}

# Check if flameshot was aborted
if [ "$(cat /tmp/screenshot.png)" != "screenshot aborted" ]; then
  CURL_UPLOAD=$(fs_upload_file "$SCREENSHOT_UPLOAD_URL")
  pomf_parse_output "$CURL_UPLOAD" | xclip -sel clip
  unset CURL_UPLOAD
  rm /tmp/screenshot.png
fi

unset FS_TMP_DIR