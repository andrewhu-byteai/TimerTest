
set(NATS_DIR ${PROJECT_BINARY_DIR}/nats)

include(ExternalProject)
ExternalProject_Add(nats
	PREFIX ${PRO_DIR}
	GIT_REPOSITORY https://github.com/nats-io/nats.c.git
	GIT_TAG v3.8.2
	UPDATE_DISCONNECTED 1
	BUILD_IN_SOURCE 1
	CONFIGURE_COMMAND cmake -DCMAKE_INSTALL_PREFIX=${NATS_DIR} -DNATS_BUILD_STREAMING=OFF
)

set(NATS_INCLUDE_DIR ${NATS_DIR}/include)
set(NATS_LIBRARY ${NATS_DIR}/lib/libnats_static.a)

include_directories(${NATS_INCLUDE_DIR})

