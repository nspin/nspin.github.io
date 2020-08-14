BUILD_DIR     := _build

EXTRA_TARGS   := $(BUILD_DIR)/articles.html $(BUILD_DIR)/resume.pdf

STATIC_TARGS  := $(patsubst static/%,$(BUILD_DIR)/%,$(shell find static -type f -not -path '*/\.*'))
REDIR_TARGS   := $(patsubst redirects/%,$(BUILD_DIR)/%,$(shell find redirects -type f -not -path '*/\.*'))

HTML_TARGS    := $(patsubst dynamic/%.html,$(BUILD_DIR)/%.html,$(shell find dynamic -name '*.html'))
MD_TARGS      := $(patsubst dynamic/%.md,$(BUILD_DIR)/%.html,$(shell find dynamic -name '*.md'))

ALL_TARGS     := $(STATIC_TARGS) $(REDIR_TARGS) $(HTML_TARGS) $(MD_TARGS) $(EXTRA_TARGS) 

ARTICLE_SRCS  := $(wildcard dynamic/articles/*.html)
TEMPLATES     := $(wildcard templates/*.html)


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

$(BUILD_DIR)/articles.html: $(ARTICLE_SRCS) $(TEMPLATES) main.py
	$(dir_guard)
	$(py) articles

$(BUILD_DIR)/resume.pdf: resume/main.tex resume/resume.cls
	$(dir_guard)
	TEXINPUTS=$(<D):$$TEXINPUTS $(latex) --output-dir=$(<D) $<
	mv $(patsubst %.tex,%.pdf,$<) $@
