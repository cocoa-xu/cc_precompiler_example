PRIV_DIR = $(MIX_APP_PATH)/priv
NIF_SO = $(PRIV_DIR)/nif.so
SRC_ROOT = $(shell pwd)
C_SRC = $(SRC_ROOT)/c_src

CFLAGS += -shared -std=c11 -O3 -fPIC -I"$(ERTS_INCLUDE_DIR)"
UNAME_S := $(shell uname -s)
ifndef TARGET_ABI
ifeq ($(UNAME_S),Darwin)
	TARGET_ABI = darwin
endif
endif

ifeq ($(TARGET_ABI),darwin)
	CFLAGS += -undefined dynamic_lookup -flat_namespace -undefined suppress
endif

.DEFAULT_GLOBAL := build

build: $(NIF_SO)
	@ echo > /dev/null

$(NIF_SO):
	@ mkdir -p "$(PRIV_DIR)"
	$(CC) $(CFLAGS) "$(C_SRC)/cc_precompiler_example.c" -o "$(NIF_SO)"
	
	@ mkdir -p "$(PRIV_DIR)/include_this/lib"
	@ echo hello > "$(PRIV_DIR)/include_this/hello.txt"
	@ echo world > "$(PRIV_DIR)/include_this/lib/world.txt"
	@ cd "$(PRIV_DIR)/include_this" && \
		ln -s hello.txt hello.symlink.txt && \
		ln -s lib symlink_to_lib && \
		cd "$(SRC_ROOT)"
	@ mkdir -p "$(PRIV_DIR)/exclude_this"
	@ echo hey > "$(PRIV_DIR)/exclude_this/hey.txt"
	@ echo "$(CC_PRECOMPILER_CURRENT_TARGET)" > "$(PRIV_DIR)/include_this/build.txt"


mycleanup:
	@ echo "executing mycleanup..."
	@ rm -f "$(PRIV_DIR)/include_this/build.txt"
