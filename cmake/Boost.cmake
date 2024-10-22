include(ExternalProject)
ExternalProject_Add(boost
  URL    https://boostorg.jfrog.io/artifactory/main/release/1.86.0/source/boost_1_86_0.tar.gz
  SOURCE_DIR        "${CMAKE_BINARY_DIR}/boost"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
)
set(BOOST_INCLUDE_DIR "${CMAKE_BINARY_DIR}/boost")
include_directories(${BOOST_INCLUDE_DIR})

