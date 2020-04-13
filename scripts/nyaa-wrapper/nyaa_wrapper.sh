#!/bin/bash

NYAA_MAGNET_URI="${1}"

# Where to save your anime, adjust according to your system
ANIME_SAVE_PATH="/run/media/aneko/AnimeShit Mk3/アニメ"

# qBittorrent category
QBITTORRENT_CATEGORY="Anime"

# Decode the magnet url using Python
urldecode() {
	echo "${1}" | python3 -c \
	"import sys; \
	from urllib.parse import unquote; \
	print(unquote(sys.stdin.read()));"
}

# Convert the filename into an anime title
parsetitle() {
	# Decode the URI
	MAGNET_DECODED=$(urldecode "${1}")

	# Parse the filename from the magnet URI
	MAGNET_FILENAME=$(echo "${MAGNET_DECODED}" | \
		perl -n -e '/magnet\:\?.+?\&dn\=(.+?)\&/ && print $1')
	unset MAGNET_DECODED

	# Check if our regex could find the filename
	if [ "${MAGNET_FILENAME}" != "" ]; then
		# Use Anitomy to conver the filename into an anime title
		MAGNET_ANIME_INFO=$(anitomy-cli --name "${MAGNET_FILENAME}")
		unset MAGNET_FILENAME

		# Use jq to parse the output of Anitomy
		MAGNET_ANIME_TITLE=$(echo "${MAGNET_ANIME_INFO}" | jq -r '.animeTitle')
		unset MAGNET_ANIME_INFO

		# Check if the output could be parsed
		if [ "${MAGNET_ANIME_TITLE}" != "null" ]; then
			echo "${MAGNET_ANIME_TITLE}"
			unset MAGNET_ANIME_TITLE
			return 0
		else
			unset MAGNET_ANIME_TITLE
			return 1
		fi
	else
		unset MAGNET_FILENAME
		return 1
	fi
}

NYAA_ANIME_TITLE=$(parsetitle "${NYAA_MAGNET_URI}")

# Check if the parsetitle function succeeded
if [ $? -eq 0 ]; then
	QBITTORRENT_SAVE_PATH="${ANIME_SAVE_PATH}/${NYAA_ANIME_TITLE}/"

	# Try to make the save path if it doesn't exists
	mkdir -p "${QBITTORRENT_SAVE_PATH}"

	# Send a notification
	notify-send "Download started" "${NYAA_ANIME_TITLE}"

	qbittorrent \
		--save-path="${QBITTORRENT_SAVE_PATH}" \
		--skip-dialog=true \
		--category="${QBITTORRENT_CATEGORY}" \
		"${NYAA_MAGNET_URI}"

	unset QBITTORRENT_SAVE_PATH
else
	qbittorrent "${NYAA_MAGNET_URI}"
fi

unset ANIME_SAVE_PATH
unset NYAA_ANIME_TITLE
unset NYAA_MAGNET_URI
