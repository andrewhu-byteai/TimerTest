
set(GFLAGS_DIR ${PROJECT_BINARY_DIR}/gflags)

include(ExternalProject)
ExternalProject_Add(gflags
	PREFIX ${PRO_DIR}
	GIT_REPOSITORY https://github.com/gflags/gflags.git
	GIT_TAG v2.2.2
	UPDATE_DISCONNECTED 1
	BUILD_IN_SOURCE 1
	CONFIGURE_COMMAND cmake -DCMAKE_INSTALL_PREFIX=${GFLAGS_DIR} -DCMAKE_CXX_FLAGS="-fPIC"
)

set(GFLAGS_INCLUDE_DIR ${GFLAGS_DIR}/include)
set(GFLAGS_LIBRARY ${GFLAGS_DIR}/lib/libgflags.a)

include_directories(${GFLAGS_INCLUDE_DIR})

