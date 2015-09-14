" this is a file sourced when creating a new Makefile
" in order to prefill it with a desired default Makefile
:insert
# Bradford Smith
# Makefile for
# Date:
################################################################################

PRG=
AUTHOR=Bradford Smith
PROJECT=
SRC=
# C++: OBJ=$(SRC:.cpp=.o)
# C: OBJ=$(SRC:.c=.o)
# C++: CXX=g++
# C: CC=gcc
RM=rm -f
INCLPATH=
# implicit compiling rules:
# C++ compiled with: `$(CXX) -c $(CPPFLAGS) $(CXXFLAGS)`
# C complied with: `$(CC) -c $(CPPFLAGS) $(CFLAGS)`
CFLAGS+=
CPPFLAGS+= -pedantic-errors -Wall
CXXFLAGS+=
DBFLGS= -g -DDEBUG

all: $(OBJ)
	#$(CXX) -o $(PRG) $(OBJ)
	#$(CC) -o $(PRG) $(OBJ)

debug: fclean
debug: CPPFLAGS+= $(DBFLGS)
debug: all

clean:
	$(RM) *.o

fclean: clean
	$(RM) $(PRG)

re: fclean all

tar: fclean
	tar -cvzf $(AUTHOR)_$(PROJECT).tar.gz ./*

.
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/g
:execute "normal! ggj$"

