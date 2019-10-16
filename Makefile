# ==== INITIALIZATION ==========================================================
ifeq ($(OS), Windows_NT)
	OS_NAME := Windows
else
	OS_NAME := $(shell uname)
endif

# ==== COMPILER FLAGS ==========================================================
GNU := g++
LFLAG := -g -Ofast -Wall
RFLAG :=
INCLUDE := wingfx/include/
LIBRARY := wingfx/lib/
LINK := sfml-graphics.a \
		sfml-window.a \
		sfml-system.a \
		sfml-audio.a
# ==== PROJECT FOLDERS =========================================================
NAME := snake
PATH_SRC := src/
PATH_RESOURCE := resource/
SRC := main
ADD := 

# ==== WINDOWS SETUP ===========================================================
ifeq ($(OS_NAME), Windows)
    GNU := wincompiler/bin/g++.exe
	ADD += icon
endif

# ==== APPLY SETUP =============================================================
SRC0 := $(addsuffix .cc, $(SRC))
SRCF := $(addprefix $(PATH_SRC), $(SRC0))
ADD0 := $(addsuffix .o, $(ADD))
ADDF := $(addprefix $(PATH_RESOURCE), $(ADD0))
INCLUDE := $(addprefix -I , $(INCLUDE))
LIBRARY := $(addprefix -L , $(LIBRARIE))
LINK := $(addprefix wingfx/lib/lib, $(LINK))
LIBFLAG := $(LINK) $(LIBRARY) $(INCLUDE)

# ==== PROCESS =================================================================
process: builder

# ==== SUB-PROCESS =============================================================
builder: 
	$(GNU) $(LFLAG) -o $(NAME) $(SRCF) $(ADDF) $(LIBFLAG) $(RFLAG)