#!/bin/sh -ex
# deal with the flume artifacts to create a tarball ARTIFACT_VERSION is supplied by the ruby wrapper
ALTISCALE_RELEASE=${ALTISCALE_RELEASE:-0.1.0}
FLUME_VERSION=${ARTIFACT_VERSION:-1.5.2}
RPM_DESCRIPTION="Apache Flume ${FLUME_VERSION}\n\n${DESCRIPTION}"

#convert each tarball into an RPM
export DEST_ROOT=${INSTALL_DIR}/opt
mkdir --mode=0755 -p ${DEST_ROOT}
cd ${DEST_ROOT}
tar -xvzpf ${WORKSPACE}/flume/flume-ng-dist/target/apache-flume-${ARTIFACT_VERSION}-bin.tar.gz

export RPM_NAME=`echo alti-flume-${FLUME_VERSION}`
echo "Building Flume Version RPM ${RPM_NAME} with RPM version ${ALTISCALE_RELEASE}-${DATE_STRING}"

cd ${RPM_DIR}
fpm --verbose \
--maintainer support@altiscale.com \
--vendor Altiscale \
--provides ${RPM_NAME} \
--description "${RPM_DESCRIPTION}" \
--license "Apache License v2" \
--url ${GITREPO} \
-s dir \
-t rpm \
-n ${RPM_NAME} \
-v ${ALTISCALE_RELEASE} \
--iteration ${DATE_STRING} \
--rpm-user root \
--rpm-group root \
-C ${INSTALL_DIR} \
opt
