.PHONY: main all clean fresh_html jrs_html

sources_pdf = \
basic.json \
info-label.json \
disposition.json \
employment-2012.json \
projects.json \
skills.json \
education.json \
social-0.json \
languages.json \
samples.json \
testimonials.json \
extracurricular.json \
affiliation.json

sources_html = \
basic.json \
info-label.json \
disposition.json \
employment-2012.json \
projects.json \
skills.json \
education.json \
social-0.json \
social-1.json \
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
social-0.json \
social-1.json \
social-2.json \
writing.json \
languages.json \
samples.json \
testimonials.json \
interests.json \
extracurricular.json \
affiliation.json

main_targets = docs/index.html docs/bartekfilip-resume-en.pdf

main: $(main_targets)
all: $(main_targets) fresh_html jrs_html

resume-html.json: $(addprefix src/,$(sources_html))
	./jsonmerge-cli.py $+ > $@

docs/index.html: resume-html.json
	hackmyresume build $+ to $@ --no-escape -t fresh-themes/themes/positive

resume-pdf.json: $(addprefix src/,$(sources_pdf))
	./jsonmerge-cli.py $+ > $@

docs/bartekfilip-resume-en.pdf: resume-pdf.json
	hackmyresume build $+ to $@ --no-escape -t fresh-themes/themes/compact

fresh_html_themes = modern positive compact basis
fresh_html_targets = $(addprefix fresh/,$(addsuffix .html,$(fresh_html_themes)))
fresh_html: $(fresh_html_targets)
fresh/%.html: resume-html.json
	hackmyresume build $+ to $@ --no-escape -t $(basename $(@F))

jrs/html/resume.json: resume-html.json
	mkdir -p $(@D)
	hackmyresume convert $+ to $@

jrs_themes = modern crisp flat
jrs_html_targets = $(addprefix jrs/html/,$(addsuffix .html,$(jrs_themes)))
jrs_html: $(jrs_html_targets)
jrs/html/%.html: jrs/html/resume.json
	cd $(@D) && resume export $(@F) --theme $(basename $(@F))

clean:
	-rm $(main_targets) resume-pdf.json resume-html.json $(fresh_html_targets) jrs/html/resume.json $(jrs_html_targets)
