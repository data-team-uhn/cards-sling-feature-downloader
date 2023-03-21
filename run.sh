#!/bin/bash

export CARDS_DIRECTORY=$1

INPUT_DOCKER_IMAGE=$2
OUTPUT_DOCKER_IMAGE=$3

export DEPLOYMENT_M2_DIRECTORY=$(realpath $(mktemp -d -p .))

CARDS_VERSION=$(cat ${CARDS_DIRECTORY}/pom.xml | grep --max-count=1 '<version>' | cut '-d>' -f2 | cut '-d<' -f1)

IFS=$'\n'
for pkg in $(cat cards_feature_list.txt | PROJECT_VERSION=$CARDS_VERSION envsubst)
do
	echo "Getting $pkg"
	./get_with_docker.sh "$pkg" "tar" || { echo "FAILED!"; exit 1; }
	./get_with_docker.sh "$pkg" "mongo" || { echo "FAILED!"; exit 1; }
done

./add_jars_to_docker_image.sh $INPUT_DOCKER_IMAGE $OUTPUT_DOCKER_IMAGE $DEPLOYMENT_M2_DIRECTORY || { echo "FAILED!"; exit 1; }
rm -rf $DEPLOYMENT_M2_DIRECTORY || { echo "FAILED!"; exit 1; }
