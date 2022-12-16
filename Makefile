# | JSON for LuaRT - Json parser/serializer module
# | Luart.org, Copyright (c) Tine Samir 2022.
# | See Copyright Notice in LICENSE.TXT
# |--------------------------------------------------------------
# | Makefile
# |--------------------------------------------------------------
# | You can prefix all the following tasks with PLATFORM=x64|x86  
# |--------------------------------------------------------------
# | Usage (default release build)		 : make
# | Usage (debug build) 		  			 : make debug
# | Usage (clean all)	 				 	     : make clean
# |-------------------------------------------------------------
# | Or you can use default release build for any platform 
# | Usage (default x64 release build)		 : make x64
# | Usage (default x86 release build)		 : make x86
# |-------------------------------------------------------------

#---- Platform selection
#---- x86 for 32bits Json.dll
#---- x64 for 64bits Json.dll

PLATFORM ?= x64

#---- LuaRT installation path (set it manually if autodetection fails)
LUART_PATH= D:\Github\LuaRT

ifeq ($(LUART_PATH),)
$(error LuaRT is not installed on this computer. Please set the LuaRT installation path manually in the Makefile or download and install LuaRT)
endif

LUART_INCLUDE = -I$(LUART_PATH)\include
LUART_LIB = -L$(LUART_PATH)\lib

ifeq ($(filter $(CLEAN),$(MAKECMDGOALS)),)
ifeq ($(PLATFORM), x86)
$(info --------------------------------- Building for Windows x86 Platform)
 ARCH = -m32 -march=pentium4 -msse -msse2 -mmmx -fno-unwind-tables -fno-asynchronous-unwind-tables
 TARGET = pe-i386
endif
ifeq ($(PLATFORM), x64)
ifneq ($(MAKECMDGOALS),x86)
$(info --------------------------------- Building for Windows x64 Platform)
endif
 ARCH = -m64 -mavx2 -mfma -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -Wno-int-conversion
 TARGET = pe-x86-64
endif
endif

BUILD := release

cflags.release = $(ARCH) -s -Os -mfpmath=sse -mieee-fp -DLUART_TYPE=__decl(dllimport) -D__MINGW64__ -D_WIN32_WINNT=0x0600 $(LUART_INCLUDE) -fno-exceptions -fdata-sections -ffunction-sections -fipa-pta -ffreestanding -fno-stack-check -fno-ident -fomit-frame-pointer -Wl,--gc-sections -Wl,--build-id=none -Wl,-O1 -Wl,--as-needed -Wl,--no-insert-timestamp -Wl,--no-seh -Wno-maybe-uninitialized -Wno-unused-parameter -Wno-unused-function -Wno-unused-but-set-parameter -Wno-implicit-fallthrough
ldflags.release= -s -static-libgcc -lm -Wl,--no-insert-timestamp -Wl,--no-seh $(LUART_LIB) 
cflags.debug = $(ARCH) -g -O0 -mfpmath=sse -mieee-fp -mmmx -msse -msse2 -DDEBUG -D__MINGW64__ -D_WIN32_WINNT=0x0700 -DLUA_COMPAT_5_3 $(LUART_INCLUDE)
ldflags.debug= -g -lm $(LUART_LIB)

CC= gcc
CFLAGS := ${cflags.${BUILD}}
LDFLAGS := ${ldflags.${BUILD}}
LIBS= -llua54
RM= del /Q

default: all

all:
	@set CPLUS_INCLUDE_PATH=./src
	@echo src/json.c
	@$(CC) -shared $(LDFLAGS) $(LUART_INCLUDE) $(CFLAGS) -w src/json.c -o Json.dll $(LIBS)
	@echo --------------------------------- Successfully built JSON for LuaRT $(PLATFORM)
	@copy /Y Json.dll $(LUART_PATH)\modules

debug:
	@$(MAKE) "BUILD=debug"

x64: clean
	@$(MAKE) "PLATFORM=x64"

x86: clean
	@$(MAKE) "PLATFORM=x86"

clean:
	@$(RM) src\*.o >nul 2>&1
	@$(RM) json.dll >nul 2>&1

.PHONY: clean all
