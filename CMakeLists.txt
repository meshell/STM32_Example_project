cmake_minimum_required(VERSION 3.15...3.20)

project(
  stm32_led
  VERSION 0.0.1
  DESCRIPTION "STM32 example project"
  LANGUAGES C ASM)

  list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
  
  if (CMAKE_CROSSCOMPILING)
    include(cmake/stm32l476.cmake)
  endif()

include(cmake/StandardCProjectSettings.cmake)
include(cmake/PreventInSourceBuilds.cmake)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)

add_library(stm32::compile_options ALIAS project_options)
target_compile_features(project_options INTERFACE c_std_99)

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)
add_library(stm32::compile_warnings ALIAS project_warnings)

# standard compiler warnings
include(cmake/CCompilerWarnings.cmake)
set_project_warnings(project_warnings)

add_library(stm32_bsp STATIC)
add_library(stm32::bsp ALIAS stm32_bsp)

#MX Generated files
target_sources(stm32_bsp
PRIVATE
    ${CMAKE_SOURCE_DIR}/src/gpio.c
    ${CMAKE_SOURCE_DIR}/src/usart.c
    ${CMAKE_SOURCE_DIR}/src/stm32l4xx_it.c
    ${CMAKE_SOURCE_DIR}/src/stm32l4xx_hal_msp.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_tim.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_tim_ex.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_uart.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_uart_ex.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_i2c.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_i2c_ex.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_rcc.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_rcc_ex.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_flash.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_flash_ex.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_flash_ramfunc.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_gpio.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_dma.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_dma_ex.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_pwr.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_pwr_ex.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_cortex.c
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Src/stm32l4xx_hal_exti.c
    ${CMAKE_SOURCE_DIR}/src/system_stm32l4xx.c  
)

target_link_libraries(stm32_bsp
    PRIVATE
    stm32::compile_options
    stm32::compile_warnings
)

target_include_directories(stm32_bsp
PUBLIC
    ${CMAKE_SOURCE_DIR}/inc 
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Inc
    ${CMAKE_SOURCE_DIR}/drivers/STM32L4xx_HAL_Driver/Inc/Legacy
    ${CMAKE_SOURCE_DIR}/drivers/CMSIS/Device/ST/STM32L4xx/Include
    ${CMAKE_SOURCE_DIR}/drivers/CMSIS/Include
)

target_compile_definitions(stm32_bsp
    PUBLIC
        -DUSE_HAL_DRIVER
        -DSTM32L476xx
)

set_target_properties(stm32_bsp PROPERTIES C_EXTENSIONS OFF)

add_executable(stm_exe
    ${CMAKE_SOURCE_DIR}/src/main.c
    ${STARTUP_SOURCE_FILE}
)

target_link_libraries(stm_exe
    PRIVATE
    stm32::bsp
    stm32::compile_options
    stm32::compile_warnings
)


include(cmake/binutils-arm-none-eabi-gcc.cmake)
create_hex_output(stm_exe)
create_bin_output(stm_exe)
print_section_sizes(stm_exe)

target_link_options(stm_exe 
PRIVATE
-Wl,-Map=stm_exe.map,--cref)

set_target_properties(stm_exe PROPERTIES C_EXTENSIONS OFF
            ADDITIONAL_CLEAN_FILES "stm_exe.hex;stm_exe.bin;stm_exe.map")

