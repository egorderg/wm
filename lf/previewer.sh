#!/bin/sh

draw() {
  ~/.config/lf/draw_img.sh "$@"
  exit 1
}

hash() {
  printf '/tmp/lf/%s' "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
  if [ -f "$1" ]; then
    draw "$@"
  fi
}

file="$1"
shift

case "$(file -Lb --mime-type -- "$file")" in
  text/*)
    bat --color=always "$file"
    exit 0
    ;;
  image/*)
    if [ -n "$FIFO_UEBERZUG" ]; then
      orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
      if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
        cache="$(hash "$file").jpg"
        cache "$cache" "$@"
        convert -- "$file" -auto-orient "$cache"
        draw "$cache" "$@"
      else
        draw "$file" "$@"
      fi
    fi
    ;;
  video/*)
    if [ -n "$FIFO_UEBERZUG" ]; then
      cache="$(hash "$file").jpg"
      cache "$cache" "$@"
      ffmpegthumbnailer -i "$file" -o "$cache" -s 0
      draw "$cache" "$@"
    fi
    ;;
  *)
    cat "$file"
    ;;
esac

file -Lb -- "$1" | fold -s -w "$width"
exit 0
