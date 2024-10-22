add_library(event_loop STATIC event_loop.cc)
add_dependencies(event_loop boost)

add_executable(event_loop_main event_loop_main.cc)
target_link_libraries(event_loop_main event_loop)
