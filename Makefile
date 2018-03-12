STATIC_TARGS  := $(patsubst static/%,site/%,$(shell find static/ -type f))
PAGE_TARGS    := $(patsubst pages/%,site/%,$(wildcard pages/*))
ARTICLE_TARGS := $(patsubst articles/%.md,site/articles/%.html,$(wildcard articles/*))
ALL_TARGS     := $(STATIC_TARGS) $(PAGE_TARGS) $(ARTICLE_TARGS) site/articles.html


.PHONY: all
all: $(ALL_TARGS)

.PHONY: clean
clean:
	-rm -r site


dir_guard = @mkdir -p $(@D)

site/articles.html: templates/content.html templates/articles.html interpolate.py articles.py
	$(dir_guard)
	python3 interpolate.py articles > $@

site/%: pages/% templates/content.html interpolate.py
	$(dir_guard)
	python3 interpolate.py page $< > $@

site/articles/%.html: articles/%.md templates/content.html templates/article.html interpolate.py articles.py
	$(dir_guard)
	pandoc --read=markdown --write=html --mathjax articles/$*.md | python3 interpolate.py article $* > $@

$(STATIC_TARGS): site/%: static/%
	$(dir_guard)
	cp $< $@


.PHONY: deploy
deploy:
	git subtree push --prefix site origin master

.PHONY: resume
resume:
	cp ../resume/nick-spinale-resume.pdf site/resume.pdf
