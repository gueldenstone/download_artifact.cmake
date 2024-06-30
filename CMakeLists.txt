cmake_minimum_required(VERSION 3.27)

option(RUN_TESTS "Run tests" OFF)
project(DownloadArtifact)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(DownloadArtifact)

if(RUN_TESTS)
  # Enable testing
  enable_testing()
  add_subdirectory(tests)
endif()
