#!/bin/sh

set -e


while [ $# -gt 0 ];
do
    case ${1} in
        "--env")
            ENV=${2}
            shift
        ;;
        *)
            echo "[ERROR] Invalid option '${1}'"
            exit 1
        ;;
    esac
    shift
done

DEBUG=${DEBUG:-false}
if ${DEBUG} ; then
    set -x
fi

PROJECT_ROOT_DIR=$(cd $(dirname $0); pwd)
BUILD_DIST_DIR="${PROJECT_ROOT_DIR}/dist"
DEPLOY_WORK_DIR="${PROJECT_ROOT_DIR}/.deploy"

case ${ENV} in
    "dev")
        SYNC_BUCKET="spasample-ap-southeast-2-jfir4934tt943pfo0"
    ;;
    "stage")
        SYNC_BUCKET="spasample-ap-southeast-1-jfir4934tt943pfo0"
    ;;
    *)
        echo "[ERROR] Invalid value --env: '${ENV}'"
        usage
        exit 1
    ;;
esac


npm run build
aws s3 sync $BUILD_DIST_DIR s3://$SYNC_BUCKET --delete
