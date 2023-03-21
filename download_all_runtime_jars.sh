#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# This is really hackish, but it will work for now...
python3 -m http.server --bind 127.0.0.1 --directory /host_m2/repository &
PYTHON_SERVER_PID=$!

java -jar org.apache.sling.feature.launcher-1.1.6.jar \
  -u "file:///cards/.mvnrepo,http://localhost:8000" \
  -p /deps -c /deps/cache \
  -f /cards/distribution/target/cards-0.9-SNAPSHOT-core_${STORAGE_TYPE}_far.far \
  -f $MAVEN_FEATURE_NAME \
  -cacheOnly

JAVA_EXIT_STATUS=$?

kill $PYTHON_SERVER_PID

mkdir /m2/repository
cp -r /deps/cache/* /m2/repository
cp -r /cards/.mvnrepo/io/ /m2/repository

rm -rf /deps/cache/
rm -rf /deps/resources/

echo "Done"
exit $JAVA_EXIT_STATUS
