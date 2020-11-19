#!/bin/bash

shopt -s nullglob

feh_args=(--draw-filename --magick-timeout 10 --image-bg black --scale-down --draw-tinted --info "exifgrep '(Model|DateTimeOriginal|FNumber|ISO|Flash|ExposureTime|FocalLenght)' %F |cut -d . -f 4-")

if [[ ! -f $1 ]]; then
    echo "$0: first argument is not a file" >&2
    exit 1
fi

file=$(basename -- "$1")
dir=$(dirname -- "$1")
arr=()
shift

cd -- "$dir"

frmt="*.jpg *.jpeg *.png *.bmp *.gif *.xcf *.ico *.tif *.tiff *.CR2 "
frmtall=${frmt}${frmt^^}

for i in $frmtall; do
    [[ -f $i ]] || continue
    arr+=("$i")
    [[ $i == $file ]] && c=$((${#arr[@]} - 1))
done

exec feh "${feh_args[@]}" "$@" -- "${arr[@]:c}" "${arr[@]:0:c}" >/dev/null 2>&1
