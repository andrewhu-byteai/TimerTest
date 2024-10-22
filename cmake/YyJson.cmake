
set(YYJSON_DIR ${PROJECT_BINARY_DIR}/yyjson)

include(ExternalProject)
ExternalProject_Add(yyjson
	PREFIX ${PRO_DIR}
	GIT_REPOSITORY https://github.com/ibireme/yyjson.git
	GIT_TAG 0.10.0
	UPDATE_DISCONNECTED 1
	BUILD_IN_SOURCE 1
	CONFIGURE_COMMAND cmake -DCMAKE_INSTALL_PREFIX=${YYJSON_DIR}
)

set(YYJSON_INCLUDE_DIR ${YYJSON_DIR}/include)
set(YYJSON_LIBRARY ${YYJSON_DIR}/lib/libyyjson.a)

include_directories(${YYJSON_INCLUDE_DIR})
