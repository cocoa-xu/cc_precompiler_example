PRIV_DIR = $(MIX_APP_PATH)/priv
NIF_SO = $(PRIV_DIR)/nif.so
C_SRC = $(shell pwd)/c_src

CFLAGS += -shared -std=c11 -O3 -fPIC -I"$(ERTS_INCLUDE_DIR)"
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	CFLAGS += -undefined dynamic_lookup -flat_namespace -undefined suppress
endif

.DEFAULT_GLOBAL := build

build: $(NIF_SO)
	@ echo > /dev/null

$(NIF_SO):
	@ mkdir -p "$(PRIV_DIR)"
	$(CC) $(CFLAGS) "$(C_SRC)/cc_precompiler_example.c" -o "$(NIF_SO)"
	
	@ mkdir -p "$(PRIV_DIR)/include_this"
	@ echo hello > "$(PRIV_DIR)/include_this/hello.txt"
	@ ln -s "$(PRIV_DIR)/include_this/hello.txt" "$(PRIV_DIR)/include_this/hello.symlink.txt"
	@ mkdir -p "$(PRIV_DIR)/exclude_this"
	@ echo world > "$(PRIV_DIR)/exclude_this/world.txt"
