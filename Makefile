TARGET := iphone:clang:latest:7.0
ARCHS = arm64e
THEOS_DEVICE_IP=127.0.0.1
THEOS_DEVICE_PORT=2222
include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libheaderdumper

${LIBRARY_NAME}_FILES = headerdumper.m RTBClass.m RTBMethod.m RTBProtocol.m RTBRuntime.m RTBRuntimeHeader.m RTBTypeDecoder.m RTBTypeDecoder2.m
${LIBRARY_NAME}_CFLAGS = -fobjc-arc 
${LIBRARY_NAME}_INSTALL_PATH = /usr/local/lib

include $(THEOS_MAKE_PATH)/library.mk
