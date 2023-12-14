#!/usr/bin/env bash
set -eou pipefail

USAGE_STRING="Usage: $(basename $0) [-h] [-b branch] [-u url] [-s subdir]"

SUBDIR=
BRANCH=master

while getopts 'b:u:s:h' opt; do
  case "$opt" in
    b)
      BRANCH="$OPTARG"
      ;;

    u)
      URL="$OPTARG"
      ;;
 
    s)
      SUBDIR="$OPTARG"
      ;;
 
    h)
      echo "${USAGE_STRING}"
      exit 0
      ;;

    :)
      echo -e "option requires an argument.\n${USAGE_STRING}"
      exit 1
      ;;

    ?)
      echo -e "Invalid command option.\n${USAGE_STRING}"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

REPO=$(basename $URL .git)

mkdir /tmp/${REPO}-install
cd /tmp/${REPO}-install
git clone --depth 1 --branch ${BRANCH} ${URL}
cd ${REPO}/${SUBDIR}
cmake -S . -B _bb -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE
cmake --build _bb
cmake --build _bb --target install
cd /
rm -rf /tmp/${REPO}-install
