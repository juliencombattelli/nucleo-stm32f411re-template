# nucleo-stm32f411re-template

This repository contains templates for C and C++ projects for the Nucleo-F411RE
board. The template projects can be built using GNU Make or CMake and with a
GNU Toolchain for ARM.

The following sample projects are available:
- gpio_toggle

## Difference between GNU Make and CMake

The makefiles here do not support out-of-source builds, so after a build the
source tree will be cluttered with .o files or other build artifacts.
However for CMake build systems, it is recommanded to use a dedicated build
directory, leaving the source tree clean.

Also, the makefiles only supports a release build configuration optimized for
binary size. CMake provides more flexibility with the following build types:
Debug, Release, RelWithDebInfo and MinSizeRel
(see https://cmake.org/cmake/help/latest/variable/CMAKE_BUILD_TYPE.html).

## Building on Linux (Ubuntu)

### CMake build

- Install the needed software:
```bash
sudo apt install build-essential gcc-arm-none-eabi cmake openocd gdb-multiarch
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

- Start a debugging session with GDB
```bash
cmake --build build --target gpio-toggle-debug
```

### GNU Make build

- Install the needed software:
```bash
sudo apt install build-essential gcc-arm-none-eabi openocd gdb-multiarch
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

- Start a debugging session with GDB
```bash
make debug
```

## Building on Windows with WSL2

The steps are the same as on Linux except for the OpenOCD installation.
Since WSL2 does not provide easy access to USB devices (as of Feb 2025), OpenOCD
must be installed on Windows and not in the Linux distro inside WSL.

Download the lastest OpenOCD Windows binary package on
[GitHub](https://github.com/openocd-org/openocd/releases/latest) and install it
where you want (eg. C:\Users\<username>\AppData\Local\Programs\OpenOCD).

Then build the project like on Linux.

And flash the target using the following commands:

- GNU Make:
```bash
# if defining tools location for each make invocation
make OPENOCD=<path/to/openocd/in/Windows>/bin/openocd.exe flash
make OPENOCD=<path/to/openocd/in/Windows>/bin/openocd.exe debug

# or if using environment variables
export OPENOCD=<path/to/openocd/in/Windows>/bin/openocd.exe
make flash
make debug
```

- CMake:
```bash
export PATH="$PATH:<path/to/openocd/in/Windows>/bin"
# eg. export PATH="$PATH:/mnt/c/Users/<username>/AppData/Local/Programs/OpenOCD/bin"
# Can be done from .bashrc or similar
cmake --build build --target gpio-toggle-flash
cmake --build build --target gpio-toggle-debug
```

## Building on Windows
