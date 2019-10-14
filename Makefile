# ==== COMPILER FLAGS ==========================================================
GNU := g++
LFLAGS := -g -Ofast -Wall
RFLAGS :=
INCLUDES := d:/sw/SFML/include 
LIBRARIES := d:/sw/SFML/lib
LINKS := sfml-graphics \
		 sfml-audio \
		 sfml-window \
		 sfml-system 
# ==== PROJECT FILES ===========================================================
NAME := snake
PATH_SRC := ./src/
PATH_OBJ := ./obj/
OBJS := main
ADD := 

# ==== APPLY SETUP =============================================================
OBJSO := $(addsuffix .o, $(OBJS))
OBJSF := $(addprefix $(PATH_OBJ), $(OBJSO))
ADDO := $(addsuffix .o, $(ADD))
ADDF := $(addprefix $(PATH_OBJ), $(ADDO))
INCLUDES := $(addprefix -I , $(INCLUDES))
LIBRARIES := $(addprefix -L , $(LIBRARIES))
LINKS := $(addprefix -l, $(LINKS))
LIBFLAGS := $(LINKS) $(LIBRARIES) $(INCLUDES)

# ==== PROCESS =================================================================
process: builder

# ==== SUB-PROCESS =============================================================
builder: $(OBJSF)
	$(GNU) $(LFLAGS) -o $(NAME) $^ $(ADDF) $(LIBFLAGS) $(RFLAGS)

$(PATH_OBJ)%.o: $(PATH_SRC)%.cc
	$(GNU) $(LFLAGS) -o $@ -c $< $(LIBFLAGS) $(RFLAGS)
