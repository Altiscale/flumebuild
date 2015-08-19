#!/bin/sh -ex

# We are installing untrusted code just to build flume for now.
# WE SHOULD REMOVE THIS ASAP.
wget http://maven.twttr.com/ua_parser/ua-parser/1.3.0/ua-parser-1.3.0.jar

# Install these untrusted artifacts in our local maven cache so that we can build flume.
mvn install:install-file -Dfile=ua-parser-1.3.0.jar -DgroupId=ua_parser -DartifactId=ua-parser -Dpackaging=jar -Dversion=1.3.0

# Build flume
mvn -Phadoop-2 clean install -DskipTests

# Discover the path of the local maven cache
MAVEN_LOCAL_REPO=`mvn help:evaluate -Dexpression=settings.localRepository | egrep -v '[INFO]|Download'`

# Remove the untrusted artifacts from this node's local maven repo soon as we have built flume
find $MAVEN_LOCAL_REPO -name 'ua_parser*' -type d | xargs rm -rf
