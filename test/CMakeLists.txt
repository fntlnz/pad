find_package(Threads REQUIRED)
#use googletest library
include(DownloadGoogleTest)
include(DownloadGoogleMock)

add_executable(libpadtest main.cpp example_test.cpp ast/node_test.cpp)

include_directories(${COMMON_INCLUDES})

target_link_libraries(libpadtest libpad libgtest libgmock)
