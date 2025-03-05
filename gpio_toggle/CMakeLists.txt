add_executable(gpio-toggle
    src/main.c
    src/stm32f4xx_it.c
    src/system_stm32f4xx.c
    src/init.c # TODO add it to startup assembly file
    startup/startup_stm32f411retx.s
)
target_include_directories(gpio-toggle PRIVATE
    src
)
target_link_libraries(gpio-toggle PRIVATE
    cmsis-core
    cmsis-device-f4
    stm32f4xx-hal-driver
    stm32f4xx-nucleo-bsp
)
target_compile_definitions(gpio-toggle PRIVATE
    STM32F411xE
    USE_HAL_DRIVER
)
get_filename_component(LINKER_SCRIPT linker/STM32F411RETX_FLASH.ld ABSOLUTE)
target_link_options(gpio-toggle PRIVATE
    -T ${LINKER_SCRIPT} -Xlinker -Map=gpio-toggle.map
)

add_custom_command(
    TARGET gpio-toggle
    POST_BUILD
    COMMAND ${ARM_OBJDUMP_EXECUTABLE} -S $<TARGET_FILE:gpio-toggle> > gpio-toggle.lss
    COMMAND ${ARM_OBJCOPY_EXECUTABLE} -O ihex $<TARGET_FILE:gpio-toggle> gpio-toggle.hex
    COMMAND ${ARM_OBJCOPY_EXECUTABLE} -O binary $<TARGET_FILE:gpio-toggle> gpio-toggle.bin
)

add_custom_target(gpio-toggle-size ALL
    DEPENDS gpio-toggle
    COMMAND ${ARM_SIZE_EXECUTABLE} -B $<TARGET_FILE:gpio-toggle>
    COMMENT "Size of sections for $<TARGET_NAME:gpio-toggle>"
)

find_package(OpenOCD)

if (OpenOCD_FOUND)
    add_custom_target(gpio-toggle-flash
        DEPENDS gpio-toggle
        COMMAND ${OpenOCD_EXECUTABLE} -f board/st_nucleo_f4.cfg -c "program gpio-toggle.bin verify reset exit 0x08000000"
    )

    find_package(GDB)

    if (GDB_FOUND)
        add_custom_target(gpio-toggle-debug
            DEPENDS gpio-toggle
            COMMAND ${GDB_EXECUTABLE} -ex "target extended-remote | ${OpenOCD_EXECUTABLE} -f board/st_nucleo_f4.cfg -c \"gdb_port pipe; log_output openocd.log\"" -ex "b main" $<TARGET_FILE:gpio-toggle>
            VERBATIM USES_TERMINAL
        )
    else()
        message(WARNING "GDB not found, not generating debug target.")
    endif()
else()
    message(WARNING "OpenOCD not found, not generating flash and debug targets.")
endif()
