#!/usr/bin/env bash

##################################################
## Shell
##################################################

BUILD_FOLDER="./website/"

aws s3 sync ${BUILD_FOLDER} s3://$(terraform output bucket_id)/
