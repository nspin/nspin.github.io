---
id: using-hakyll
title: Using Hakyll
description: A description of the tool used to build what you are looking at now.
date: 2015-10-24
---

# Biz Baz

A static website is basically a bunch of files meant to be served by directory.
You could think if it as a pure mapping from filepaths to files, where most filepaths map to a default 404 page.
Pages can't be generated on the fly, but there is one serious benefit to a static website: they're really really easy to mantain and host.
There are a lot of companies that will serve a static directory for you, and getting this set up is super easy because you don't have to worry about *any* server logic.
Github, for example, will serve your static site from a repository called *username*.github.io for free under the domain of the same name.
That's how this site is hosted.

# Foo Bar

What's more, there are a bunch of tools for 'compiling' directories of static files from other files.
Some names you might have heard of are Jekyll, Middleman, and Octopress.
I chose to use on called [Hakyll](http://jaspervdj.be/hakyll).
Hakyll isn't actually an executable or a script.
It's just a library consisting of a EDLS for describing transformations of static files.
So, this website consists of a bunch of html, css, and markdown files and templates, and a Haskell program that describes the process these files go through to become the static files being served to you now.
Its source can be found here: [github.com/nickspinale/website](http://github.com/nickspinale/website).

Hakyll is a really great approach to the static website problem, remeniscent of how projects such as xmonad and yi approach configuration.
Learn more about it [here](http://jaspervdj.be/hakyll), or check out its source [here](http://github.com/jaspervdj/hakyll).

