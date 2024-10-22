if(NOT HFFIX_INCLUDE_DIR)
include(ExternalProject)
ExternalProject_Add(hffix
  URL    https://github.com/jamesdbrock/hffix/archive/refs/tags/v1.3.0.tar.gz
  SOURCE_DIR        "${CMAKE_BINARY_DIR}/hffix"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
)
set(HFFIX_INCLUDE_DIR "${CMAKE_BINARY_DIR}/hffix/include")
else()
add_library(hffix INTERFACE)
endif()
include_directories(${HFFIX_INCLUDE_DIR})
 
