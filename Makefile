PREFIX=$(HOME)/.local
CONFIG_DIR=$(HOME)/.config/lcfetch

TP_DIR=$(CURDIR)/third-party
BIN_DIR=$(CURDIR)/bin
LIB_DIR=$(CURDIR)/lib
INC_DIR=$(CURDIR)/include
LUA_INC_DIR=/usr/include/lua

CC=clang
CCF=clang-format
CFLAGS=-I$(LUA_INC_DIR) -O2 -Wall -Wextra -llua -lX11

LOG_INFO=$(shell date +"%H:%M:%S") \e[1;32mINFO\e[0m

.PHONY: clean fmt build run
.SILENT: clean run
.DEFAULT_GOAL := all

all: build


build: clean lcfetch.c $(LIB_DIR)/lua_api.c $(LIB_DIR)/memory.c $(INC_DIR)/lcfetch.h
	@echo -e "$(LOG_INFO) Building lcfetch.c ..."
	$(CC) $(CFLAGS) -o $(BIN_DIR)/lcfetch lcfetch.c $(LIB_DIR)/*.c $(TP_DIR)/log.c/src/log.c -DLOG_USE_COLOR
	strip $(BIN_DIR)/lcfetch


install: build
	@echo -e "$(LOG_INFO) Installing lcfetch under $(PREFIX)/bin directory ..."
	mkdir -p $(PREFIX)/bin $(CONFIG_DIR)
	install $(BIN_DIR)/lcfetch $(PREFIX)/bin/lcfetch
	cp $(CURDIR)/config/sample.lua $(CONFIG_DIR)/config.lua


clean:
ifneq (,$(wildcard $(BIN_DIR)/lcfetch))
	rm $(BIN_DIR)/lcfetch
endif


fmt:
	@echo -e "$(LOG_INFO) Formatting source code ..."
	$(CCF) -style=file --sort-includes -i $(INC_DIR)/*.h $(LIB_DIR)/*.c


run: build
	echo -e "$(LOG_INFO) Running lcfetch ..."
	$(BIN_DIR)/lcfetch
