
# MCU specific options
# -mthumb               Generat thumb instructions.
# -mcpu                 name of the target ARM processor
# -mfpu                 Floating-point hardware
# -mfloat-abi           Floating-point ABI to use

set(MCU_FLAGS 
    -mcpu=cortex-m4 
    -mthumb 
    -mfpu=fpv4-sp-d16 
    -mfloat-abi=hard
)



# Standard build options
# -ffunction-sections   Place each function item into its own section in the output file.
# -fdata-sections       Place each data item into its own section in the output file.

set(OBJECT_GEN_FLAGS  
    -fdata-sections 
    -ffunction-sections
    -Og
)

add_compile_options(${MCU_FLAGS} ${OBJECT_GEN_FLAGS})

message(STATUS "CMAKE_SOURCE_DIR: ${CMAKE_SOURCE_DIR}")

set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/STM32L476RGTx_FLASH.ld)

set(LINK_FLAGS 
${MCU_FLAGS}
-specs=nano.specs 
-T${LINKER_SCRIPT} 
-lc 
-lm 
-lnosys 
-Wl,--gc-sections 
)

add_link_options(${LINK_FLAGS})

set(STARTUP_SOURCE_FILE ${CMAKE_SOURCE_DIR}/startup_stm32l476xx.s)
