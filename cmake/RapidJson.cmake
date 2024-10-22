if(NOT RAPIDJSON_INCLUDE_DIR)
include(ExternalProject)
ExternalProject_Add(rapidjson
  URL    https://github.com/Tencent/rapidjson/archive/refs/tags/v1.1.0.tar.gz
  SOURCE_DIR        "${CMAKE_BINARY_DIR}/rapidjson" CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
)
set(RAPIDJSON_INCLUDE_DIR "${CMAKE_BINARY_DIR}/rapidjson/include")
else()
add_library(rapidjson INTERFACE)
endif()
include_directories(${RAPIDJSON_INCLUDE_DIR})
