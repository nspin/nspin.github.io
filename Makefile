PAGE_TARGS    := $(patsubst pages/%,site/%,$(wildcard pages/*))
ARTICLE_TARGS := $(patsubst articles/%.md,site/articles/%.html,$(wildcard articles/*))
ALL_TARGS     := site/articles.html $(PAGE_TARGS) $(ARTICLE_TARGS)

.PHONY: all
all: $(ALL_TARGS)

.PHONY: clean
clean:
	-rm $(ALL_TARGS)
	-rmdir site/articles

site/articles.html: templates/content.html templates/articles.html interpolate.py articles.py
	python3 interpolate.py articles > $@

site/%: pages/% templates/content.html interpolate.py
	python3 interpolate.py page $< > $@

site/articles/%.html: articles/%.md templates/content.html templates/article.html interpolate.py articles.py
	mkdir -p site/articles
	pandoc --read=markdown --write=html --mathjax articles/$*.md | python3 interpolate.py article $* > $@
