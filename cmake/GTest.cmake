
set(GTEST_DIR ${PROJECT_BINARY_DIR}/gtest)

include(ExternalProject)
ExternalProject_Add(gtest
	PREFIX ${PRO_DIR}
	GIT_REPOSITORY https://github.com/google/googletest.git
	GIT_TAG release-1.12.0
	UPDATE_DISCONNECTED 1
	BUILD_IN_SOURCE 1
	CONFIGURE_COMMAND cmake -DCMAKE_INSTALL_PREFIX=${GTEST_DIR} -DCMAKE_CXX_FLAGS="-std=c++17"
)

set(GTEST_INCLUDE_DIR ${GTEST_DIR}/include)
set(GTEST_LIBRARY ${GTEST_DIR}/lib/libgtest.a  ${GTEST_DIR}/lib/libgtest_main.a)

include_directories(${GTEST_INCLUDE_DIR})
