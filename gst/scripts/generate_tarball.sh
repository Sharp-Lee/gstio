#! /bin/bash

NAME=$1
GST_PREFIX=${PREFIX}/${SUBPREFIX}
mkdir -p ${PREFIX}/bin/
#mkdir -p ${PREFIX}/lib/cmake/${PROJECT}
mkdir -p ${GST_PREFIX}/bin
mkdir -p ${GST_PREFIX}/licenses/gstio
#mkdir -p ${GST_PREFIX}/include
#mkdir -p ${GST_PREFIX}/lib/cmake/${PROJECT}
#mkdir -p ${GST_PREFIX}/cmake
#mkdir -p ${GST_PREFIX}/scripts

# install binaries 
cp -R ${BUILD_DIR}/bin/* ${GST_PREFIX}/bin  || exit 1

# install licenses
cp -R ${BUILD_DIR}/licenses/gstio/* ${GST_PREFIX}/licenses || exit 1

# install libraries
#cp -R ${BUILD_DIR}/lib/* ${GST_PREFIX}/lib

# install cmake modules
#sed "s/_PREFIX_/\/${SPREFIX}/g" ${BUILD_DIR}/modules/GstioTesterPackage.cmake &> ${GST_PREFIX}/lib/cmake/${PROJECT}/GstioTester.cmake
#sed "s/_PREFIX_/\/${SPREFIX}\/${SSUBPREFIX}/g" ${BUILD_DIR}/modules/${PROJECT}-config.cmake.package &> ${GST_PREFIX}/lib/cmake/${PROJECT}/${PROJECT}-config.cmake

# install includes
#cp -R ${BUILD_DIR}/include/* ${GST_PREFIX}/include

# make symlinks
#pushd ${PREFIX}/lib/cmake/${PROJECT} &> /dev/null
#ln -sf ../../../${SUBPREFIX}/lib/cmake/${PROJECT}/${PROJECT}-config.cmake ${PROJECT}-config.cmake
#ln -sf ../../../${SUBPREFIX}/lib/cmake/${PROJECT}/GstioTester.cmake GstioTester.cmake
#popd &> /dev/null

for f in $(ls "${BUILD_DIR}/bin/"); do
   bn=$(basename $f)
   ln -sf ../${SUBPREFIX}/bin/$bn ${PREFIX}/bin/$bn || exit 1
done
echo "Generating Tarball $NAME.tar.gz..."
tar -cvzf $NAME.tar.gz ./${PREFIX}/* || exit 1
rm -r ${PREFIX} || exit 1
