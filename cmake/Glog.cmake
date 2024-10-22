
set(GLOG_DIR ${PROJECT_BINARY_DIR}/glog)

include(ExternalProject)
ExternalProject_Add(glog
	PREFIX ${PRO_DIR}
	GIT_REPOSITORY https://github.com/google/glog.git
	GIT_TAG v0.7.1
	UPDATE_DISCONNECTED 1
	BUILD_IN_SOURCE 1
	CONFIGURE_COMMAND cmake -DCMAKE_INSTALL_PREFIX=${GLOG_DIR} -DBUILD_SHARED_LIBS=OFF -DCMAKE_CXX_FLAGS="-std=c++17"
)

set(GLOG_INCLUDE_DIR ${GLOG_DIR}/include)
set(GLOG_LIBRARY ${GLOG_DIR}/lib/libglog.a)

include_directories(${GLOG_INCLUDE_DIR})

