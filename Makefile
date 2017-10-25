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
	./main -i ProblemD0426/tb1/fsm.v -o outputs/input_sequence

run2:
	./main -i ProblemD0426/tb2/fsm.v -o outputs/input_sequence

run3:
	./main -i ProblemD0426/tb3/fsm.v -o outputs/input_sequence

clean:
	rm $(EXE) $(OBJS)
