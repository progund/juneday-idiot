PROJECT_DIR       = /home/juneday/opt/lcd
ARDMK_DIR         = /usr/share/arduino/

ARDUINO_DIR       = /usr/share/arduino
LOCAL_C_SRCS    ?= $(wildcard *.c)
LOCAL_CPP_SRCS  ?= $(wildcard *.cpp)
USER_LIB_PATH    :=  $(PROJECT_DIR)/lib
BOARD_TAG         = uno
MONITOR_BAUDRATE  = 115200
AVR_TOOLS_DIR     = /usr
AVRDUDE          = /usr/bin/avrdude
CFLAGS_STD        = -std=gnu11

CXXFLAGS_STD      = -std=gnu++11
CXXFLAGS         += -pedantic -Wall -Wextra

MONITOR_PORT      = /dev/ttyACM0
CURRENT_DIR       = $(shell basename $(CURDIR))
OBJDIR            = $(PROJECT_DIR)/bin/$(BOARD_TAG)/$(CURRENT_DIR)

### Do not touch - the path to Arduino.mk, inside the ARDMK_DIR
include $(ARDMK_DIR)/Arduino.mk


