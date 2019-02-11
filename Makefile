.PHONY: all clean jrs

sources_pdf = \
basic.json \
info-label.json \
disposition.json \
employment-2012.json \
skills.json \
education.json \
social.json \
languages.json

sources_html = \
basic.json \
info-label.json \
disposition.json \
employment-2012.json \
projects.json \
skills.json \
education.json \
social.json \
languages.json \
samples.json \
testimonials.json \
extracurricular.json \
affiliation.json

sources_all = \
basic.json \
info-label.json \
disposition.json \
employment-2012.json \
employment-2006.json \
projects.json \
skills.json \
education.json \
social.json \
writing.json \
languages.json \
samples.json \
testimonials.json \
interests.json \
extracurricular.json \
affiliation.json

targets = docs/index.html docs/resume.pdf

all: $(targets)

resume-html.json: $(sources_html)
	./jsonmerge-cli.py $+ > $@

docs/index.html: resume-html.json
	hackmyresume build $+ to $@ --no-escape

resume-pdf.json: $(sources_pdf)
	./jsonmerge-cli.py $+ > $@

docs/resume.pdf: resume-pdf.json
	hackmyresume build $+ to $@ --no-escape -t compact

jrs: jrs/html/resume.html

jrs/html/resume.json: resume-html.json
	mkdir -p $(@D)
	hackmyresume convert $+ to $@

# Themes: modern, crisp, flat
jrs/html/resume.html: jrs/html/resume.json
	cd $(@D) && resume export $(@F)

clean:
	-rm $(targets) resume-pdf.json resume-html.json jrs/html/resume.json jrs/html/resume.html
