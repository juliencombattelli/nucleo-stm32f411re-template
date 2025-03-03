cmake_minimum_required(VERSION 3.20)
project(nucleo-stm32f411re)
enable_language(C CXX ASM)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

add_subdirectory(external)
add_subdirectory(gpio_toggle)
