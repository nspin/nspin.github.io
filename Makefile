BUILD_DIR     := _site
SRC_DIR       := src
TMP_DIR       := _tmp

HIGHLIGHT_STYLE := pygments

PANDOC_CSS := $(BUILD_DIR)/css/pandoc/code.$(HIGHLIGHT_STYLE).css
PANDOC_HELPERS := $(PANDOC_CSS) $(BUILD_DIR)/css/pandoc/base.css $(TMP_DIR)/pandoc/math.fragment.html

EXTRA_TARGS   := $(BUILD_DIR)/robots.txt $(BUILD_DIR)/sitemap.xml \
				 $(PANDOC_CSS) \
				 $(BUILD_DIR)/articles.html $(BUILD_DIR)/resume.pdf

STATIC_TARGS  := $(patsubst $(SRC_DIR)/static/%,$(BUILD_DIR)/%,$(shell find $(SRC_DIR)/static -type f -not -path '*/\.*'))
REDIR_TARGS   := $(patsubst $(SRC_DIR)/redirects/%,$(BUILD_DIR)/%,$(shell find $(SRC_DIR)/redirects -type f -not -path '*/\.*'))

HTML_TARGS    := $(patsubst $(SRC_DIR)/dynamic/%.html,$(BUILD_DIR)/%.html,$(shell find $(SRC_DIR)/dynamic -name '*.html'))
MD_TARGS      := $(patsubst $(SRC_DIR)/dynamic/%.md,$(BUILD_DIR)/%.html,$(shell find $(SRC_DIR)/dynamic -name '*.md'))

# TODO assert no repeats
ALL_TARGS     := $(STATIC_TARGS) $(REDIR_TARGS) $(HTML_TARGS) $(MD_TARGS) $(EXTRA_TARGS) 

ARTICLES      := $(wildcard $(SRC_DIR)/previews/*.md)
TEMPLATES     := $(wildcard $(SRC_DIR)/templates/*.html)

ROOT          := $(file <$(SRC_DIR)/robots/root.txt)


ensure_dir = @mkdir -p $(@D)
py = python3 main.py $(BUILD_DIR) $(SRC_DIR) $(http_path)
latex = lualatex


in_tmp = $(patsubst $(SRC_DIR)/%,$(TMP_DIR)/%,$(1))
in_site = $(patsubst $(SRC_DIR)/%,$(BUILD_DIR)/%,$(1))

rel_to_src = $(patsubst $(SRC_DIR)/%,%,$(1))
rel_to_build = $(patsubst $(BUILD_DIR)/%,%,$(1))
http_path = /$(call rel_to_build,$@)


.PHONY: all
all: $(ALL_TARGS)

.PHONY: most
most: $(filter-out $(BUILD_DIR)/sitemap.xml,$(ALL_TARGS))

.PHONY: clean
clean:
	-rm -rf $(BUILD_DIR) $(TMP_DIR)


$(TMP_DIR)/pandoc/math.fragment.html: $(SRC_DIR)/pandoc/math.template $(SRC_DIR)/pandoc/math.md
	$(ensure_dir)
	pandoc --read=markdown --write=html --metadata title=x --template=$^ > $@ --mathjax


$(BUILD_DIR)/%: $(SRC_DIR)/static/%
	$(ensure_dir)
	cp $< $@

$(BUILD_DIR)/%: $(SRC_DIR)/redirects/% $(TEMPLATES) main.py
	$(ensure_dir)
	$(py) redirect $(shell cat $<)

$(BUILD_DIR)/%.html: $(SRC_DIR)/dynamic/%.html $(TEMPLATES) main.py $(PANDOC_HELPERS)
	$(ensure_dir)
	$(py) html $(call rel_to_src,$<)

$(BUILD_DIR)/%.html: $(SRC_DIR)/dynamic/%.md $(TEMPLATES) main.py $(PANDOC_HELPERS)
	$(ensure_dir)
	$(py) md $(call rel_to_src,$<)

$(BUILD_DIR)/articles.html: $(ARTICLES) $(TEMPLATES) main.py $(PANDOC_HELPERS)
	$(ensure_dir)
	$(py) articles

$(BUILD_DIR)/css/pandoc/code.%.css: $(SRC_DIR)/pandoc/code.template $(SRC_DIR)/pandoc/code.md
	$(ensure_dir)
	pandoc --read=markdown --write=html --metadata title=x --template=$^ > $@ --highlight-style $*

$(BUILD_DIR)/resume.pdf: $(SRC_DIR)/resume/main.tex $(SRC_DIR)/resume/resume.cls
	$(ensure_dir)
	mkdir -p $(call in_tmp,$(<D))
	TEXINPUTS=$(<D):$$TEXINPUTS $(latex) --output-dir=$(call in_tmp,$(<D)) $<
	mv $(patsubst %.tex,%.pdf,$(call in_tmp,$<)) $@

$(BUILD_DIR)/robots.txt: $(SRC_DIR)/robots/robots.txt.in $(SRC_DIR)/robots/root.txt
	$(ensure_dir)
	sed "s|@ROOT@|$(ROOT)|g" $< > $@

SITEMAP_YAML := $(SRC_DIR)/robots/include.yaml $(SRC_DIR)/robots/exclude.yaml
SITEMAP_PATHS := $(filter-out $(BUILD_DIR)/sitemap.xml,$(ALL_TARGS))

$(BUILD_DIR)/sitemap.xml: $(SITEMAP_YAML) main.py $(SRC_DIR)/robots/root.txt $(SRC_DIR)/templates/sitemap.xml $(SITEMAP_PATHS)
	$(ensure_dir)
	$(py) sitemap $(ROOT) $(SITEMAP_YAML)
