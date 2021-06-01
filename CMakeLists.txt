cmake_minimum_required(VERSION 3.15...3.20)

project(
  stm32_example_project
  VERSION 0.0.1
  DESCRIPTION "stm32 example project"
  LANGUAGES C CXX ASM)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

option(ENABLE_TESTING "Enable Test Builds" ON)

include(cmake/StandardCProjectSettings.cmake)
include(cmake/PreventInSourceBuilds.cmake)

if (CMAKE_CROSSCOMPILING)
    add_subdirectory(bsp)
endif()

if(ENABLE_TESTING AND NOT CMAKE_CROSSCOMPILING)
  enable_testing()
  include(FetchCppUTest)
  add_subdirectory(tests)
endif()