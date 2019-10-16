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
INCLUDE := 
LIBRARY := 
LINK := sfml-graphics \
		sfml-window \
		sfml-system \
		sfml-audio
# ==== DEFAULT PROJECT FOLDERS =================================================
NAME := snake
PATH_SRC := src/
PATH_RESOURCE := resource/
PREF_LINK := -l
SRC := main
ADD := 

# ==== WINDOWS SETUP ===========================================================
ifeq ($(OS_NAME), Windows)
    GNU := wincompiler/bin/g++.exe
	INCLUDE := wingfx/include/
	LIBRARY := wingfx/lib/
	LINK := $(addsuffix .a, $(LINK))
	PREF_LINK := $(LIBRARY)lib
	ADD += icon
endif

# ==== APPLY SETUP =============================================================
SRC := $(addsuffix .cc, $(SRC))
SRC := $(addprefix $(PATH_SRC), $(SRC))
ADD := $(addsuffix .o, $(ADD))
ADD := $(addprefix $(PATH_RESOURCE), $(ADD))
INCLUDE := $(addprefix -I , $(INCLUDE))
LIBRARY := $(addprefix -L , $(LIBRARIE))
LINK := $(addprefix $(PREF_LINK), $(LINK))
LIBFLAG := $(LINK) $(LIBRARY) $(INCLUDE)

# ==== PROCESS =================================================================
process: builder

# ==== SUB-PROCESS =============================================================
builder: 
	$(GNU) $(LFLAG) -o $(NAME) $(SRC) $(ADD) $(LIBFLAG) $(RFLAG)
