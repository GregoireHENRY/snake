# ==== INITIALIZATION ==========================================================
ifeq ($(OS), Windows_NT)
	OS_NAME := Windows
else
	OS_NAME := $(shell uname)
endif

# ==== COMPILER FLAGS ==========================================================
GNU := g++
LFLAGS := -g -Ofast -Wall
RFLAGS :=
INCLUDES := 
LIBRARIES := 
LINKS := sfml-graphics \
		 sfml-window \
		 sfml-system \
		 sfml-audio
# ==== PROJECT FILES ===========================================================
NAME := snake
PATH_SRC := ./src/
PATH_RESOURCE := ./resource/
SRC := main
ADD := 

# ==== WINDOWS SETUP ===========================================================
ifeq ($(OS_NAME), Windows)
	INCLUDES += d:/sw/SFML/include/
	LIBRARIES += d:/sw/SFML/lib/
	ADD += icon
endif

# ==== APPLY SETUP =============================================================
SRC0 := $(addsuffix .cc, $(SRC))
SRCF := $(addprefix $(PATH_SRC), $(SRC0))
ADD0 := $(addsuffix .o, $(ADD))
ADDF := $(addprefix $(PATH_RESOURCE), $(ADD0))
INCLUDES := $(addprefix -I , $(INCLUDES))
LIBRARIES := $(addprefix -L , $(LIBRARIES))
LINKS := $(addprefix -l, $(LINKS))
LIBFLAGS := $(LINKS) $(LIBRARIES) $(INCLUDES)

# ==== PROCESS =================================================================
process: builder

# ==== SUB-PROCESS =============================================================
builder: 
	$(GNU) $(LFLAGS) -o $(NAME) $(SRCF) $(ADDF) $(LIBFLAGS) $(RFLAGS)
