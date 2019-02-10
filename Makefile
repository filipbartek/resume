.PHONY: all clean themes

sources_pdf = \
basic.json \
info-label.json \
disposition.json \
employment-2012.json \
skills.json \
education-2008.json \
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
employment.json \
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

employment.json: employment-2012.json employment-2006.json
	./jsonmerge-cli.py employment-2012.json employment-2006.json > employment.json

education.json: education-2015.json education-2008.json
	./jsonmerge-cli.py education-2015.json education-2008.json > education.json

docs/index.html: $(sources_html)
	hackmyresume build $(sources_html) to docs/index.html --no-escape

docs/resume.pdf: $(sources_pdf)
	hackmyresume build $(sources_pdf) to docs/resume.pdf --no-escape -t compact

clean:
	-rm $(targets)
