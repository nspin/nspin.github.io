BUILD_DIR     := _build

STATIC_TARGS  := $(patsubst static/%,$(BUILD_DIR)/%,$(shell find static -type f -not -path '*/\.*'))
HTML_TARGS    := $(patsubst dynamic/%.html,$(BUILD_DIR)/%.html,$(shell find dynamic -name '*.html'))
MD_TARGS      := $(patsubst dynamic/%.md,$(BUILD_DIR)/%.html,$(shell find dynamic -name '*.md'))
ALL_TARGS     := $(STATIC_TARGS) $(HTML_TARGS) $(MD_TARGS) $(BUILD_DIR)/articles.html

ARTICLE_SRCS  := $(wildcard dynamic/articles/*.html)
TEMPLATES     := $(wildcard templates/*.html)


.PHONY: all
all: $(ALL_TARGS)

.PHONY: clean
clean:
	-rm -r $(BUILD_DIR)


dir_guard = @mkdir -p $(@D)
interpolate = python3 interpolate.py $(BUILD_DIR) $@


$(STATIC_TARGS): $(BUILD_DIR)/%: static/%
	$(dir_guard)
	cp $< $@

$(BUILD_DIR)/%.html: dynamic/%.html $(TEMPLATES) interpolate.py
	$(dir_guard)
	$(interpolate) html $<

$(BUILD_DIR)/%.html: dynamic/%.md $(TEMPLATES) interpolate.py
	$(dir_guard)
	$(interpolate) md $<

$(BUILD_DIR)/articles.html: $(ARTICLE_SRCS) $(TEMPLATES) interpolate.py
	$(dir_guard)
	$(interpolate) articles


.PHONY: resume
resume:
	cp ../resume/nick-spinale-resume.pdf static/resume.pdf
	cp static/resume.pdf $(BUILD_DIR)
