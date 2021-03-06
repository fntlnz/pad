include_directories(${COMMON_INCLUDES} ${CMAKE_CURRENT_BINARY_DIR})
set(SOURCE_FILES
        example.cpp
        ast/node.cpp
        ast/const_declaration_node.cpp
        ast/const_element_node.cpp
        ast/namespace_node.cpp
        ast/statement_list_node.cpp
        ast/use_element_node.cpp
        ast/use_node.cpp
        ast/group_use_node.cpp
        ast/variable_node.cpp)

find_package(BISON)
find_package(FLEX)


BISON_TARGET(php_parser ${PROJECT_SOURCE_DIR}/src/parser/php.y ${PROJECT_SOURCE_DIR}/src/parser/parser.cpp
        COMPILE_FLAGS --defines=${PROJECT_SOURCE_DIR}/include/parser/parser.hpp)
FLEX_TARGET(php_scanner ${PROJECT_SOURCE_DIR}/src/parser/php.l ${PROJECT_SOURCE_DIR}/src/parser/lexer.cpp)

ADD_FLEX_BISON_DEPENDENCY(php_scanner php_parser)

add_library(libpad STATIC ${SOURCE_FILES} ${BISON_php_parser_OUTPUTS} ${FLEX_php_scanner_OUTPUTS})
