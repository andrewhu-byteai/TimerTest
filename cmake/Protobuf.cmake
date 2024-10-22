
function(custom_protobuf_generate_cpp SRCS HDRS)
  if(NOT ARGN)
    message(SEND_ERROR "Error: CUSTOM_PROTOBUF_GENERATE_CPP() called without any proto files")
    return()
  endif()

  # Create an include path for each file specified
  foreach(FIL ${ARGN})
    get_filename_component(ABS_FIL ${FIL} ABSOLUTE)
    get_filename_component(ABS_PATH ${ABS_FIL} PATH)
    list(FIND _protobuf_include_path ${ABS_PATH} _contains_already)
    if(${_contains_already} EQUAL -1)
        list(APPEND _protobuf_include_path -I ${ABS_PATH})
    endif()
  endforeach()

  set(${SRCS})
  set(${HDRS})
  foreach(FIL ${ARGN})
    get_filename_component(ABS_FIL ${FIL} ABSOLUTE)
    get_filename_component(FIL_WE ${FIL} NAME_WE)

    list(APPEND ${SRCS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc")
    list(APPEND ${HDRS} "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h")

    execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR})

    add_custom_command(
      OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc"
             "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h"
      COMMAND  ${PBUF_PROTOC}
      ARGS --cpp_out ${CMAKE_CURRENT_BINARY_DIR} ${_protobuf_include_path} ${ABS_FIL}
      DEPENDS ${ABS_FIL}
			COMMENT "Running C++ protocol buffer compiler on ${FIL} Command: ${PBUF_PROTOC}"
      VERBATIM )
  endforeach()

  set_source_files_properties(${${SRCS}} ${${HDRS}} PROPERTIES GENERATED TRUE)
  set(${SRCS} ${${SRCS}} PARENT_SCOPE)
  set(${HDRS} ${${HDRS}} PARENT_SCOPE)
endfunction()

set(PBUF_DIR ${PROJECT_BINARY_DIR}/protobuf)

include(ExternalProject)
ExternalProject_Add(protobuf
    PREFIX ${PROTOBUF_DIR}
    GIT_REPOSITORY https://github.com/google/protobuf.git
    GIT_TAG v3.4.1
    UPDATE_DISCONNECTED 1
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ./autogen.sh COMMAND ./configure --prefix=${PBUF_DIR}
)

set(PBUF_INCLUDE_DIR ${PBUF_DIR}/include)
set(PBUF_LIBRARY ${PBUF_DIR}/lib/libprotobuf.a)
set(PBUF_PROTOC ${PBUF_DIR}/bin/protoc)

include_directories(
	${PROJECT_BINARY_DIR}
	${PBUF_INCLUDE_DIR}
)
