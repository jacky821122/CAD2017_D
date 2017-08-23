EXE := main
CXX := g++
CXXFLAGS := -O3 -static
CPPS := $(wildcard src/*.cpp)
OBJS := $(addprefix obj/,$(notdir $(CPPS:.cpp=.o)))

.PHONY: all clean

all: obj $(EXE)

obj: 
	mkdir $@

$(EXE): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

obj/%.o: src/%.cpp
		$(CXX) $(CXXFLAGS) -o $@ -c $<

run1:
	./main ProblemD0426/tb1/fsm.v cadb160.v 1

run1m:
	./main ProblemD0426/tb1/fsm.v cadb160_multiCounter.v 3

run2:
	./main ProblemD0426/tb2/fsm.v cadb160.v 1

run2m:
	./main ProblemD0426/tb2/fsm.v cadb160_multiCounter.v 3

run3:
	./main ProblemD0426/tb3/fsm.v cadb160.v 1

run3m:
	./main ProblemD0426/tb3/fsm.v cadb160.multiCounter.v 3

clean:
	rm $(EXE) $(OBJS)
