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

FROM alpine:3.17

# Install utilities for patching the JAR file, if such is necessary
RUN apk update
RUN apk add \
  openjdk11-jre \
  python3

COPY sling-org-apache-sling-feature-launcher/target/org.apache.sling.feature.launcher-1.1.6.jar .

COPY download_all_runtime_jars.sh /
RUN chmod +x /download_all_runtime_jars.sh
RUN chmod +r /download_all_runtime_jars.sh

RUN mkdir /deps
RUN chmod 0777 /deps

CMD /bin/sh download_all_runtime_jars.sh
