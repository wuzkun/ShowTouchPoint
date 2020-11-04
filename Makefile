TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ShowTouchPoint

ShowTouchPoint_FILES = Tweak.x FTTouchPointView.m
ShowTouchPoint_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk


