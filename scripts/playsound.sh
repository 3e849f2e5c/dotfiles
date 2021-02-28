#!/bin/bash

# MIT License
#
# Copyright 2020 Markus "3e849f2e5c" Isberg
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

APPLICATION="${1}"
TITLE="${2}"
SUMMARY="${3}"

#echo "${1} -|- ${APPLICATION} -|- ${SUMMARY} -|- ${4}" >> ~/scripts/log.txt

play_when() {
	paplay ~/scripts/when.ogg
}

play_metoo() {
	paplay ~/scripts/me-too.ogg
}

case "${APPLICATION}" in

  # RuneScape notifications
  "RuneLite" )
    case "${SUMMARY}" in
      *"Feeding interrupted! Damaged"* )
        play_when
      ;;
      *"Feeding interrupted! Brazier"* )
        play_when
      ;;
      *"Fletching interrupted!"* )
        play_when
      ;;
      * )
        play_metoo
	  esac
  ;;

  "Slack" )
  ;;

  # Everything else
  * )
    play_metoo
esac
