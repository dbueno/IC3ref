CC=clang
CXX=clang++
CFLAGS=-Wall -D __STDC_LIMIT_MACROS -D __STDC_FORMAT_MACROS -O3 -g -fPIC
MINISAT=../minisat
AIGER=../aiger

INCLUDE=-I$(MINISAT) -I$(MINISAT)/minisat/core -I$(MINISAT)/minisat/mtl -I$(MINISAT)/minisat/simp -I$(AIGER)

all:	ic3

ic3:	$(MINISAT)/libminisat.dylib $(AIGER)/aiger.o Model.o IC3.o main.o
	$(CXX) $(CFLAGS) $(INCLUDE) -o IC3 \
		$(AIGER)/aiger.o Model.o IC3.o main.o \
		$(MINISAT)/build/release/lib/libminisat.a

.c.o:
	$(CC) -g -O3 $(INCLUDE) $< -c

.cpp.o:	
	$(CXX) $(CFLAGS) $(INCLUDE) $< -c

clean:
	rm -f *.o ic3

dist:
	cd ..; tar cf ic3ref/IC3ref.tar ic3ref/*.h ic3ref/*.cpp ic3ref/Makefile ic3ref/LICENSE ic3ref/README; gzip ic3ref/IC3ref.tar
