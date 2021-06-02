cmake_minimum_required(VERSION 3.15...3.20)

project(
  stm32_example_project
  VERSION 0.0.1
  DESCRIPTION "stm32 example project"
  LANGUAGES C CXX ASM)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

option(ENABLE_TESTING "Enable Test Builds" ON)

include(StandardCProjectSettings)
include(PreventInSourceBuilds)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)
add_library(stm32::compile_options ALIAS project_options)

target_compile_features(project_options INTERFACE c_std_99)

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)
add_library(stm32::compile_warnings ALIAS project_warnings)

# standard compiler warnings
include(CCompilerWarnings)
set_project_warnings(project_warnings)



if (CMAKE_CROSSCOMPILING)
    include(stm32l476)
    add_subdirectory(bsp)
endif()

add_subdirectory(lib)

if(ENABLE_TESTING AND NOT CMAKE_CROSSCOMPILING)
  enable_testing()
  include(FetchCppUTest)
  add_subdirectory(tests)
endif()