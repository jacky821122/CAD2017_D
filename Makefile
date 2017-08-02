all:
	g++ -static -o main src/main.cpp src/readlog.cpp src/readlog.h src/parser.h src/parser.cpp src/triggergenerator.cpp src/triggergenerator.h src/countergenerator.cpp src/countergenerator.h src/detectorgenerator.cpp src/detectorgenerator.h
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
	rm -f main
