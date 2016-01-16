include_directories(${COMMON_INCLUDES})

add_executable(pad main.cpp)
target_link_libraries(pad libpad)
