BUILD_DIR     := _build

STATIC_TARGS  := $(patsubst static/%,$(BUILD_DIR)/%,$(shell find static/ -type f -not -path '*/\.*'))
PAGE_TARGS    := $(patsubst pages/%,$(BUILD_DIR)/%,$(wildcard pages/*))
ARTICLE_TARGS := $(patsubst articles/%.md,$(BUILD_DIR)/articles/%.html,$(wildcard articles/*))
ALL_TARGS     := $(STATIC_TARGS) $(PAGE_TARGS) $(ARTICLE_TARGS) $(BUILD_DIR)/articles.html


.PHONY: all
all: $(ALL_TARGS)

.PHONY: clean
clean:
	-rm -r $(BUILD_DIR)


dir_guard = @mkdir -p $(@D)

$(STATIC_TARGS): $(BUILD_DIR)/%: static/%
	$(dir_guard)
	cp $< $@

$(BUILD_DIR)/%: pages/% templates/content.html interpolate.py
	$(dir_guard)
	python3 interpolate.py $(BUILD_DIR) $@ page $<

$(BUILD_DIR)/articles.html: templates/content.html templates/articles.html interpolate.py articles.py
	$(dir_guard)
	python3 interpolate.py $(BUILD_DIR) $@ articles

$(BUILD_DIR)/articles/%.html: articles/%.md templates/content.html templates/article.html interpolate.py articles.py
	$(dir_guard)
	pandoc --read=markdown --write=html --mathjax articles/$*.md | python3 interpolate.py $(BUILD_DIR) $@ article $*


.PHONY: resume
resume:
	cp ../resume/nick-spinale-resume.pdf $(BUILD_DIR)/resume.pdf
