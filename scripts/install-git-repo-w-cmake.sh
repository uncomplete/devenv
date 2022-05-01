#!/usr/bin/env bash
set -eou pipefail

USAGE_STRING="Usage: $(basename $0) [-h] [-b branch] [-u url]"

BRANCH=master

while getopts 'b:u:h' opt; do
  case "$opt" in
    b)
      BRANCH="$OPTARG"
      ;;

    u)
      URL="$OPTARG"
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
cd ${REPO}
cmake -S . -B _bb
cmake -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE --build _bb
cmake --build _bb --target install
cd /
rm -rf /tmp/${REPO}-install
