# Disable built-in rules and variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
$(foreach x,$(filter-out .% MAKE% SHELL CURDIR,$(.VARIABLES)) MAKEINFO,$(if $(filter default,$(origin $x)),$(eval override undefine $x)))

# External modules rules

CMSIS_CORE_INCDIRS := \
	../external/cmsis-core/CMSIS/Core/Include

CMSIS_DEVICE_F4_INCDIRS := \
	../external/cmsis-device-f4/Include

HAL_SRCS := \
	../external/stm32f4xx-hal-driver/Src/Legacy/stm32f4xx_hal_can.c \
	../external/stm32f4xx-hal-driver/Src/Legacy/stm32f4xx_hal_eth.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_adc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_adc_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_can.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_cec.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_cortex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_crc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_cryp.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_cryp_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_dac.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_dac_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_dcmi.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_dcmi_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_dfsdm.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_dma2d.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_dma.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_dma_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_dsi.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_eth.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_exti.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_flash.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_flash_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_flash_ramfunc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_fmpi2c.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_fmpi2c_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_fmpsmbus.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_fmpsmbus_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_gpio.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_hash.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_hash_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_hcd.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_i2c.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_i2c_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_i2s.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_i2s_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_irda.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_iwdg.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_lptim.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_ltdc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_ltdc_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_mmc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_nand.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_nor.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_pccard.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_pcd.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_pcd_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_pwr.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_pwr_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_qspi.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_rcc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_rcc_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_rng.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_rtc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_rtc_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_sai.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_sai_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_sd.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_sdram.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_smartcard.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_smbus.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_spdifrx.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_spi.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_sram.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_tim.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_tim_ex.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_uart.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_usart.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_hal_wwdg.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_adc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_crc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_dac.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_dma2d.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_dma.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_exti.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_fmc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_fmpi2c.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_fsmc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_gpio.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_i2c.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_lptim.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_pwr.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_rcc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_rng.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_rtc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_sdmmc.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_spi.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_tim.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_usart.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_usb.c \
	../external/stm32f4xx-hal-driver/Src/stm32f4xx_ll_utils.c

HAL_INCDIRS := \
	../external/stm32f4xx-hal-driver/Inc \
	../external/stm32f4xx-hal-driver/Inc/Legacy

NUCLEO_BSP_INCDIRS := \
	../external/stm32f4xx-nucleo-bsp

NUCLEO_BSP_SRCS := \
	../external/stm32f4xx-nucleo-bsp/stm32f4xx_nucleo.c


# Application specific rules

TARGET := gpio_toggle

ASMSRCS := startup/startup_stm32f411retx.s

CSRCS := \
	src/stm32f4xx_it.c \
	src/system_stm32f4xx.c \
	src/gnu/sysmem.c \
	src/gnu/syscalls.c \
	src/main.c \
	$(HAL_SRCS) \
	$(NUCLEO_BSP_SRCS)

CXXSRCS :=

INCDIRS := \
	src \
	$(CMSIS_CORE_INCDIRS) \
	$(CMSIS_DEVICE_F4_INCDIRS) \
	$(HAL_INCDIRS) \
	$(NUCLEO_BSP_INCDIRS)

LDSCRIPT    := linker/STM32F411RETX_FLASH.ld

CROSS       := arm-none-eabi-

CC          ?= $(CROSS)gcc
CXX         ?= $(CROSS)g++
AS          ?= $(CROSS)gcc
LD          ?= $(CROSS)g++
OBJCOPY     ?= $(CROSS)objcopy
SIZE        ?= $(CROSS)size

OPENOCD     ?= openocd
OPENOCD_CFG ?= board/st_nucleo_f4.cfg

GDB         ?= gdb-multiarch

ARCHFLAGS   := -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

CFLAGS      += -Os -g3
CFLAGS      += $(ARCHFLAGS)
CFLAGS      += -fmessage-length=0 -ffunction-sections -fdata-sections
CFLAGS      += -MMD -MP
CFLAGS      += -DSTM32F411xE -DUSE_HAL_DRIVER
CFLAGS      += $(foreach i, $(INCDIRS), -I$(i))

CXXFLAGS    += $(CFLAGS)
CXXFLAGS    += -fno-rtti -fno-exceptions
CXXFLAGS    += -std=c++20

LDFLAGS     += $(ARCHFLAGS)
LDFLAGS     += -Wl,--gc-sections
LDFLAGS     += -T $(LDSCRIPT) --specs=nano.specs --specs=nosys.specs -lm

OBJS := $(ASMSRCS:.s=.o) $(CSRCS:.c=.o) $(CXXSRCS:.cpp=.o)

DEPS := $(CSRCS:.c=.d) $(CXXSRCS:.cpp=.d)

all: $(TARGET).elf bin size

$(TARGET).elf: $(OBJS)
	@echo " LD       $@"
	@mkdir -p $(@D)
	@$(LD) -o $@ $(LDFLAGS) $(OBJS)

%.o: %.c
	@echo " CC       $<"
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.cpp
	@echo " CX       $<"
	@mkdir -p $(@D)
	@$(CXX) $(CXXFLAGS) -o $@ -c $<

%.o: %.s
	@echo " AS       $<"
	@mkdir -p $(@D)
	@$(AS) $(CFLAGS) -o $@ -c $<

-include $(DEPS)

.PHONY: clean all bin

clean:
	@echo " RM       *.o"
	@rm -rf $(OBJS)
	@echo " RM       *.d"
	@rm -rf $(DEPS)
	@echo " RM       $(TARGET)"
	@rm -rf $(TARGET)
	@rm -rf $(TARGET:.elf=hex)
	@rm -rf $(TARGET:.elf=.bin)

bin: $(TARGET).elf
	@echo " OBJCOPY  $(TARGET:.elf=.hex)"
	$(OBJCOPY) -O ihex $(TARGET).elf $(TARGET).hex
	@echo " OBJCOPY  $(TARGET:.elf=.bin)"
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

size: $(TARGET).elf
	@echo " SIZE     $(TARGET)"
	@$(SIZE) --format=berkeley $(TARGET).elf

flash:
	@if ! command -v $(OPENOCD) 2>&1 >/dev/null; then echo "OpenOCD not found at \`$(OPENOCD)\`, exiting."; exit 1; fi
	$(OPENOCD) -f $(OPENOCD_CFG) -c "program $(TARGET).bin verify reset exit 0x08000000"

debug:
	@if ! command -v $(OPENOCD) 2>&1 >/dev/null; then echo "OpenOCD not found at \`$(OPENOCD)\`, exiting."; exit 1; fi
	@if ! command -v $(GDB) 2>&1 >/dev/null; then echo "GDB not found at \`$(GDB)\`, exiting."; exit 1; fi
	$(GDB) -ex "target extended-remote | $(OPENOCD) -f $(OPENOCD_CFG) -c \"gdb_port pipe; log_output openocd.log\"" -ex "b main" $(TARGET).elf
