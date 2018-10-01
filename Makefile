BUILD_DIR     := _build

STATIC_TARGS  := $(patsubst static/%,$(BUILD_DIR)/%,$(shell find static -type f -not -path '*/\.*'))
HTML_TARGS    := $(patsubst dynamic/%.html,$(BUILD_DIR)/%.html,$(shell find dynamic -name '*.html'))
MD_TARGS      := $(patsubst dynamic/%.md,$(BUILD_DIR)/%.html,$(shell find dynamic -name '*.md'))
REDIR_TARGS   := $(patsubst redirects/%,$(BUILD_DIR)/%,$(shell find redirects -type f -not -path '*/\.*'))
ALL_TARGS     := $(STATIC_TARGS) $(HTML_TARGS) $(MD_TARGS) $(REDIR_TARGS) $(BUILD_DIR)/articles.html

ARTICLE_SRCS  := $(wildcard dynamic/articles/*.html)
TEMPLATES     := $(wildcard templates/*.html)


.PHONY: all
all: $(ALL_TARGS)

.PHONY: clean
clean:
	-rm -r $(BUILD_DIR)


dir_guard = @mkdir -p $(@D)
py = python3 main.py $(BUILD_DIR) $@


$(BUILD_DIR)/%: static/%
	$(dir_guard)
	cp $< $@

$(BUILD_DIR)/%.html: dynamic/%.html $(TEMPLATES) main.py
	$(dir_guard)
	$(py) html $<

$(BUILD_DIR)/%.html: dynamic/%.md $(TEMPLATES) main.py
	$(dir_guard)
	$(py) md $<

$(BUILD_DIR)/articles.html: $(ARTICLE_SRCS) $(TEMPLATES) main.py
	$(dir_guard)
	$(py) articles

$(BUILD_DIR)/%: redirects/% $(TEMPLATES) main.py
	$(dir_guard)
	$(py) redirect $(shell cat $<)


.PHONY: resume
resume:
	cp ../resume/nick-spinale-resume.pdf static/resume.pdf
	cp static/resume.pdf $(BUILD_DIR)
