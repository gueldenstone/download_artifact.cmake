cmake_minimum_required(VERSION 3.10)

# Include the directory where your custom functions are defined
set(TEST_SOURCE_DIR "${PROJECT_SOURCE_DIR}/tests")

# Add a custom test
message(STATUS "Adding test for IsArchive")
message(STATUS "CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")
add_test(NAME TestIsArchive COMMAND ${CMAKE_COMMAND} -DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH} -P ${TEST_SOURCE_DIR}/test_IsArchive.cmake)
