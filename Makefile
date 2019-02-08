.PHONY: clean
targets = docs/index.html
$(targets): resume.json Makefile
	hackmyresume build resume.json to $(targets) --no-escape
clean:
	-rm $(targets)
