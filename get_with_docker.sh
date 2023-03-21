#!/bin/bash

MAVEN_FEATURE_NAME=$1
STORAGE_TYPE=$2

docker run \
	--rm \
	--user $UID:$(id -g) \
	-v ~/.m2:/host_m2:ro \
	-v $CARDS_DIRECTORY:/cards:ro \
	-v $DEPLOYMENT_M2_DIRECTORY:/m2 \
	-e MAVEN_FEATURE_NAME="$MAVEN_FEATURE_NAME" \
	-e STORAGE_TYPE="$STORAGE_TYPE" \
	-it cards/sling-feature-downloader
