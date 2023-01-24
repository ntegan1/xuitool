## xtream api bash

Tool for downloading/playing available content, fetching more information on the content, searching/sorting through content, and subtitle searching

Usage information / examples posted in pull request body for each feature when developed and merged, [e.g.](https://github.com/ntegan1/xuitool/pull/2).

### Dependencies / Environment
Meant for linux machines.

Tested on archlinux and uses the following packages:  
* mpv
* subdl
* ffmpeg
* jq

### Other resources
* https://github.com/grimelinse/xtream-codes-decoded
* https://github.com/chazlarson/py-xtream-codes
* https://github.com/linuxmint/hypnotix/blob/master/usr/lib/hypnotix/xtream.py

### TODO
`xuiseriesdownload <series_id> season <season> episode <episode> | `xuimpvplay`  
xuimpvplay just plays the file in mpv but does "--title=$(cat <video_file>.title"
if it exists.
also maybe auto enable mpv watch later and save in var

also var/media separet series vod live dir

