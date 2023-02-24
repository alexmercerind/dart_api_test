# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(dart_api_test_library VERSION 0.0.1 LANGUAGES C)

add_library(dart_api_test SHARED
  "dart_api_test.c"
)

set_target_properties(dart_api_test PROPERTIES
  PUBLIC_HEADER dart_api_test.h
  OUTPUT_NAME "dart_api_test"
)

target_compile_definitions(dart_api_test PUBLIC DART_SHARED_LIB)
