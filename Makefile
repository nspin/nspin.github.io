BUILD_DIR     := _build

EXTRA_TARGS   := $(BUILD_DIR)/articles.html $(BUILD_DIR)/resume.pdf \
                 $(BUILD_DIR)/robots.txt $(BUILD_DIR)/sitemap.xml

STATIC_TARGS  := $(patsubst static/%,$(BUILD_DIR)/%,$(shell find static -type f -not -path '*/\.*'))
REDIR_TARGS   := $(patsubst redirects/%,$(BUILD_DIR)/%,$(shell find redirects -type f -not -path '*/\.*'))

HTML_TARGS    := $(patsubst dynamic/%.html,$(BUILD_DIR)/%.html,$(shell find dynamic -name '*.html'))
MD_TARGS      := $(patsubst dynamic/%.md,$(BUILD_DIR)/%.html,$(shell find dynamic -name '*.md'))

ALL_TARGS     := $(STATIC_TARGS) $(REDIR_TARGS) $(HTML_TARGS) $(MD_TARGS) $(EXTRA_TARGS) 

ARTICLES      := $(wildcard articles/*.md)
TEMPLATES     := $(wildcard templates/*.html)

ROOT          := $(file <robots/root.txt)


.PHONY: all
all: $(ALL_TARGS)

.PHONY: clean
clean: auxclean
	-rm -rf $(BUILD_DIR)

.PHONY: auxclean
auxclean:
	-rm -f $(addprefix resume/main.,aux log out)


dir_guard = @mkdir -p $(@D)
py = python3 main.py $(BUILD_DIR) $@
latex = lualatex


$(BUILD_DIR)/%: static/%
	$(dir_guard)
	cp $< $@

$(BUILD_DIR)/%: redirects/% $(TEMPLATES) main.py
	$(dir_guard)
	$(py) redirect $(shell cat $<)

$(BUILD_DIR)/%.html: dynamic/%.html $(TEMPLATES) main.py
	$(dir_guard)
	$(py) html $<

$(BUILD_DIR)/%.html: dynamic/%.md $(TEMPLATES) main.py
	$(dir_guard)
	$(py) md $<

$(BUILD_DIR)/articles.html: $(ARTICLES) $(TEMPLATES) main.py
	$(dir_guard)
	$(py) articles

$(BUILD_DIR)/resume.pdf: resume/main.tex resume/resume.cls
	$(dir_guard)
	TEXINPUTS=$(<D):$$TEXINPUTS $(latex) --output-dir=$(<D) $<
	mv $(patsubst %.tex,%.pdf,$<) $@

$(BUILD_DIR)/robots.txt: robots/robots.txt.in robots/root.txt
	$(dir_guard)
	sed "s|@ROOT@|$(ROOT)|g" $< > $@

SITEMAP_YAML := robots/include.yaml robots/exclude.yaml
SITEMAP_PATHS := $(filter-out $(BUILD_DIR)/sitemap.xml,$(ALL_TARGS))

$(BUILD_DIR)/sitemap.xml: $(SITEMAP_YAML) main.py robots/root.txt templates/sitemap.xml $(SITEMAP_PATHS)
	$(dir_guard)
	$(py) sitemap $(ROOT) $(SITEMAP_YAML)
