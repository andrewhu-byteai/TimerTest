cmake_minimum_required(VERSION 3.14)
set(NAME TimerTest)
project(${NAME})
set(CMAKE_VERBOSE_MAKEFILE ON)

option(test "Build all tests." ON)
enable_testing()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS  OFF)
if(NOT APPLE AND NOT MSVC)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
endif()

set(CMAKE_BUILD_TYPE "Release")
get_filename_component(CAOS_PROJECT_DIR ./ ABSOLUTE)

find_package(OpenSSL REQUIRED)
set(ADDITIONAL_LINK_LIBRARIES "")
link_libraries(OpenSSL::Crypto OpenSSL::SSL ${ADDITIONAL_LINK_LIBRARIES})

add_compile_definitions(GLOG_USE_GLOG_EXPORT)

include(cmake/Boost.cmake)
include(cmake/Utils.cmake)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -DNDEBUG -g0 -O2")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mavx2 -mavx -msse3 -mf16c -mavx512f -fPIC -DNDEBUG -g0 -O2")

include_directories(
	${CAOS_PROJECT_DIR}
	${PROJECT_BINARY_DIR}
)

add_subdirectory(core)
