BUILD_DIR     := _build

STATIC_TARGS  := $(patsubst static/%,$(BUILD_DIR)/%,$(shell find static/ -type f -not -path '*/\.*'))
PAGE_TARGS    := $(patsubst pages/%,$(BUILD_DIR)/%,$(wildcard pages/*))
MD_TARGS      := $(patsubst md/%.md,$(BUILD_DIR)/%.html,$(wildcard md/*))
ARTICLE_TARGS := $(patsubst articles/%.md,$(BUILD_DIR)/articles/%.html,$(wildcard articles/*))
ALL_TARGS     := $(STATIC_TARGS) $(PAGE_TARGS) $(MD_TARGS) $(ARTICLE_TARGS) $(BUILD_DIR)/articles.html

TEMPLATES     := $(wildcard templates/*)


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

$(BUILD_DIR)/%.html: pages/%.html $(TEMPLATES) interpolate.py
	$(dir_guard)
	$(interpolate) page $<

$(BUILD_DIR)/%.html: md/%.md $(TEMPLATES) interpolate.py
	$(dir_guard)
	$(interpolate) md $<

$(BUILD_DIR)/articles/%.html: articles/%.md $(TEMPLATES) interpolate.py
	$(dir_guard)
	$(interpolate) article $<

$(BUILD_DIR)/articles.html: $(ARTICLE_TARGS) $(TEMPLATES) interpolate.py
	$(dir_guard)
	$(interpolate) articles


.PHONY: resume
resume:
	cp ../resume/nick-spinale-resume.pdf static/resume.pdf
	cp static/resume.pdf $(BUILD_DIR)
