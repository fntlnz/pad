include_directories(${COMMON_INCLUDES})

set(SOURCE_FILES example.cpp)

add_library(libpad STATIC ${SOURCE_FILES})
