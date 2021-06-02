cmake_minimum_required(VERSION 3.15...3.20)

project(
  stm32_example_lib
  VERSION 0.0.1
  LANGUAGES C)

add_library(stm32_example_lib STATIC ${HEADER_LIST})
add_library(stm32_example::library ALIAS stm32_example_lib)

target_include_directories(
    stm32_example_lib PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc>
                 $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)


target_sources(
    stm32_example_lib
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src/led_driver.c
)

target_link_libraries(
    stm32_example_lib
  PRIVATE stm32::compile_warnings
  PRIVATE stm32::compile_options)