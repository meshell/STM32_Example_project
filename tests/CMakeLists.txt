cmake_minimum_required(VERSION 3.15...3.20)

project(
  stm32_unittests
  VERSION 0.0.1
  LANGUAGES C CXX
)

add_executable(unittests ${CMAKE_CURRENT_LIST_DIR}/RunAllTests.cpp)
add_executable(stm32::unittests ALIAS unittests)

target_sources(
  unittests
  PRIVATE ${CMAKE_CURRENT_LIST_DIR}/led_driver_test.cpp
)


target_link_libraries(unittests PRIVATE
    CppUTest
    CppUTestExt
    stm32_example::library
)

target_compile_features(unittests INTERFACE c++_std_17)

add_custom_target(
    run_unittests ALL
    COMMAND $<TARGET_FILE:stm32::unittests>
    COMMENT "Run unittests")