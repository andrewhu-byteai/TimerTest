
set(PROMETHEUS_DIR ${PROJECT_BINARY_DIR}/prometheus-cpp)

include(ExternalProject)
ExternalProject_Add(prometheus-cpp
	PREFIX ${PRO_DIR}
	GIT_REPOSITORY https://github.com/jupp0r/prometheus-cpp.git
	GIT_TAG v1.2.4
	UPDATE_DISCONNECTED 1
	BUILD_IN_SOURCE 1
	CONFIGURE_COMMAND cmake -DCMAKE_INSTALL_PREFIX=${PROMETHEUS_DIR} -DENABLE_PUSH=OFF -DENABLE_COMPRESSION=OFF
)

set(PROMETHEUS_INCLUDE_DIR ${PROMETHEUS_DIR}/include)
set(PROMETHEUS_LIBRARY 
	${PROMETHEUS_DIR}/lib/libprometheus-cpp-pull.a
	${PROMETHEUS_DIR}/lib/libprometheus-cpp-core.a
)

include_directories(${PROMETHEUS_INCLUDE_DIR})
