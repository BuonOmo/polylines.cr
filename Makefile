.PHONY: test
test:
	crystal spec
	crystal tool format --check

bin/benchmark: perf/benchmark.cr
	mkdir -p bin
	crystal build --release -o $@ $<

.PHONY: benchmark
benchmark: bin/benchmark
	./$<

.PHONY: clean
clean:
	rm -rf bin
