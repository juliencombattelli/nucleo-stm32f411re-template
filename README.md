# nucleo-stm32f411re-template

This repository contains templates for C and C++ projects for the Nucleo-F411RE
board. The template projects can be built using GNU Make or CMake and with a
GNU Toolchain for ARM.

Note that GNU Makefiles here do not support out-of-source builds, so after a
build the source tree will be cluttered with .o files or other build artifacts.
However for CMake build systems, it is recommanded to use a dedicated build
directory, leaving the source tree clean.

The following sample projects are available:
- gpio_toggle

## Building on Linux (Ubuntu)

### CMake build

- Install the needed software:
```bash
sudo apt install build-essential gcc-arm-none-eabi cmake openocd
```

- Build the project:
```bash
cmake -S . -B build --toolchain cmake/gnu-arm-toolchain.cmake -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j8
```

- Flash the target:
```bash
cmake --build build --target gpio-toggle-flash
```

### GNU Make build

- Install the needed software:
```bash
sudo apt install build-essential gcc-arm-none-eabi openocd
```

- Build the project:
```bash
cd gpio_toggle
make -j8
```

- Flash the target:
```bash
make flash
```

## Building on Windows with WSL

## Building on Windows
