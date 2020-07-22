SOURCES := $(shell find src -name '*.cr')
OPERATING_SYSTEM := $(shell uname)

ifeq ($(OPERATING_SYSTEM),Darwin)
	OPEN ?= open
else
	OPEN ?= xdg-open
endif

.PHONY: test
test:
	crystal spec
	crystal tool format --check

bin/benchmark: perf/benchmark.cr $(SOURCES)
	mkdir -p bin
	crystal build --release -o $@ $<

.PHONY: benchmark
benchmark: bin/benchmark
	./$<

.PHONY: doc
doc:
	crystal docs
	$(OPEN) http://127.0.0.1:8000/
	python3 -m http.server --directory docs 8000

.PHONY: play
play:
	$(OPEN) http://127.0.0.1:8080/workbook/playground/polylines
	crystal play

.PHONY: clean
clean:
	rm -rf bin
