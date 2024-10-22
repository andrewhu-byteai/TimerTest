
set(SEASTAR_DIR ${PROJECT_BINARY_DIR}/seastar)

include(ExternalProject)
ExternalProject_Add(seastar
	PREFIX ${PRO_DIR}
	GIT_REPOSITORY https://github.com/scylladb/seastar.git
	GIT_TAG seastar-22.11.0
	UPDATE_DISCONNECTED 1
	BUILD_IN_SOURCE 1
	CONFIGURE_COMMAND ./install-dependencies.sh && ./configure.py --mode=release --enable-dpdk && ninja -C build/release 
)

set(SEASTAR_INCLUDE_DIR ${SEASTAR_DIR}/include)
set(SEASTAR_LIBRARY 
	${SEASTAR_DIR}/lib/libseastar.a
)

include_directories(${SEASTAR_INCLUDE_DIR})
