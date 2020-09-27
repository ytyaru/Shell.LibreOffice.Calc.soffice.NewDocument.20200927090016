#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# LibreOfficeCalcのファイルを新規作成するsofficeコマンド。
# $1があればその名前で出力する。対応拡張子はods,fods,tsv。$1がなければ%Y%m%d%H%M%S.odsを出力する。出力先はカレントディレクトリ。
# CreatedAt: 2020-09-27
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	[ 0 -lt $# ] && { NAME=${1%.*}; EXT=${1#*.}; } || { NAME=$(date +%Y%m%d%H%M%S); EXT=ods; }
	PATH_IN="/tmp/$NAME.csv"
	touch "$PATH_IN"
	FILTER='calc8'
	[ 'fods' = "${EXT,,}" ] && FILTER='OpenDocument Spreadsheet Flat XML'
	[ 'tsv' = "${EXT,,}" ] && FILTER='Text - txt - csv (StarCalc)'
	soffice --convert-to "$EXT:$FILTER" --outdir "$(pwd)" "$PATH_IN"
	rm "$PATH_IN"
}
Run "$@"
