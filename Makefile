PYTHON3 = python3

PAGE_TARGS    := $(patsubst pages/%,site/%,$(wildcard pages/*))
ARTICLE_TARGS := $(patsubst articles/%.md,site/articles/%.html,$(wildcard articles/*))
ALL_TARGS     := site/articles.html $(PAGE_TARGS) $(ARTICLE_TARGS)

.PHONY: all
all: $(ALL_TARGS)

.PHONY: clean
clean:
	-rm $(ALL_TARGS)
	-rmdir site/articles

site/articles.html: templates/content.html templates/articles.html builder.py articles.py
	$(PYTHON3) builder.py articles > $@

$(PAGE_TARGS): site/%: pages/% templates/content.html builder.py
	$(PYTHON3) builder.py page $< > $@

$(ARTICLE_TARGS): site/articles/%.html: articles/%.md templates/content.html templates/article.html builder.py articles.py
	mkdir -p site/articles
	pandoc --read=markdown --write=html --mathjax articles/$*.md | $(PYTHON3) builder.py article $* > $@
