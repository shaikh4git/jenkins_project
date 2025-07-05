#!/bin/bash

# Names of your volumes
SOURCE_VOLUME="jenkins_react_jenkins_home"
TARGET_VOLUME="jenkins_ubuntu_containers_jenkins_home"

echo "🔁 Copying data from $SOURCE_VOLUME to $TARGET_VOLUME using an Alpine container..."

docker run --rm -it \
  -v ${SOURCE_VOLUME}:/from \
  -v ${TARGET_VOLUME}:/to \
  alpine sh -c "cp -a /from/. /to/ && echo '✅ Data copied successfully.'"

echo "✅ Volume data copied."
