import re
import os
import sys
from os.path import relpath
from datetime import datetime
from pathlib import Path
from subprocess import check_output

import yaml
from jinja2 import Environment, FileSystemLoader
from markupsafe import Markup

DEFAULT_PANDOC_CODE_STYLE = 'pygments'

def get_md_meta(md_path):
    with open(md_path) as f:
        return next(yaml.load_all(f, Loader=yaml.FullLoader))

def compile_md(md_path, code_style=DEFAULT_PANDOC_CODE_STYLE):
    meta = get_md_meta(md_path)
    args = ('pandoc', '--read=markdown+raw_html', '--write=html', '--highlight-style', code_style, '--mathjax', md_path)
    body = check_output(args, encoding='utf8')
    return {
        'meta': meta,
        'body': body,
        'pandoc': {
            'has_math': meta.get('has_math', False),
            'has_code': True, # HACK
            'code_style': code_style,
            },
        }

def wrap_css_tag(css):
    return '<style>' + css + '</style>'

class Interpolator(object):

    def __init__(self, build_dir, src_dir, output_path):
        self.build_dir = build_dir
        self.src_dir = src_dir
        self.tmp_dir = Path('_tmp') # TODO
        self.output_path = output_path

        self.env = Environment(loader=FileSystemLoader(self.src_dir))
        self.env.globals['path_to'] = self.path_to
        self.env.globals['read_build'] = self.read_build
        self.env.globals['read_src'] = self.read_src
        self.env.globals['read_tmp'] = self.read_tmp
        self.env.globals['include_pandoc_css_base'] = self.include_pandoc_css_base
        self.env.globals['include_pandoc_css_code'] = self.include_pandoc_css_code
        self.env.globals['include_pandoc_math'] = self.include_pandoc_math

    # template env

    def path_to(self, abs_path, absolute=False):
        abs_path = Path(abs_path)
        assert abs_path.is_absolute()
        if absolute:
            return abs_path
        else:
            return relpath(abs_path, self.output_path.parent)

    def read_tmp(self, path):
        return (self.tmp_dir / path).read_text()

    def read_src(self, path):
        return (self.src_dir / path).read_text()

    def read_build(self, path):
        return (self.build_dir / path).read_text()

    def include_pandoc_math(self):
        return self.read_tmp('pandoc/math.fragment.html')

    def include_pandoc_css_base(self):
        return wrap_css_tag(self.read_build('css/pandoc/base.css'))

    def include_pandoc_css_code(self, style):
        return wrap_css_tag(self.read_build('css/pandoc/code.{}.css'.format(style)))

    def include_pandoc_css_code_default(self):
        return include_pandoc_css_code(DEFAULT_PANDOC_CODE_STYLE)

    # utils

    def real_output_path(self):
        return self.build_dir / self.output_path.relative_to(self.output_path.root)

    def interpolate(self, template_name, data):
        with self.real_output_path().open('w') as f:
            self.env.get_template(template_name).stream(data).dump(f)

    # ops

    def html(self, template_name):
        self.interpolate(template_name, {})

    def md(self, md_path):
        result = compile_md(self.src_dir / md_path)
        self.interpolate(result['meta']['template'], result)

    # HACK
    def articles(self):
        def go():
            for preview_path in (self.src_dir / 'previews').glob('*.md'):
                article_id = preview_path.stem
                article_path = self.src_dir / 'dynamic/articles/{}.md'.format(article_id)
                yield {
                    'meta': get_md_meta(article_path),
                    'id': article_id,
                    'body': compile_md(preview_path)['body'],
                    }
        self.interpolate('templates/articles.html', {
            'articles': list(sorted(go(), key=lambda x: x['meta']['date'], reverse=True)),
        })

    def redirect(self, target):
        self.interpolate('templates/redirect.html', {
            'target': target
            })

    def sitemap(self, root, include_yaml, exclude_yaml, *html):
        def load_yaml(path):
            with open(path) as f:
                return yaml.load(f, Loader=yaml.FullLoader)
        def exclude(path):
            for clude in load_yaml(path):
                yield re.compile(clude)
        def include(path):
            for clude in load_yaml(path):
                assert len(clude) == 1
                clude, info = next(iter(clude.items()))
                yield re.compile(clude), info
        include = list(include(include_yaml))
        exclude = list(exclude(exclude_yaml))

        paths = {}
        for path, mtime in http_paths():
            skip = False
            for r in exclude:
                if r.fullmatch(path) is not None:
                    skip = True
                    break
            if skip:
                continue
            for r, info in include:
                if r.fullmatch(path) is not None:
                    if path not in paths:
                        paths[path] = {
                            'lastmod': mtime,
                            'images': [],
                            }
                    if info is not None:
                        if 'priority' in info:
                            paths[path]['priority'] = info['priority']
                        if 'images' in info:
                            for image_path, image_info in info['images'].items():
                                loc = root + image_path
                                paths[path]['images'].append(dict(loc=loc, **image_info))

        def urls():
            for path, info in paths.items():
                loc = root + path
                yield dict(loc=loc, **info)

        self.interpolate('templates/sitemap.xml', {
            'urls': urls(),
            })

def http_paths():
    build = Path('_site')
    for root, dirs, files in os.walk(build):
        root = Path(root)
        for f in files:
            path = root / f
            mtime = path.stat().st_mtime
            mtime = datetime.utcfromtimestamp(mtime).isoformat(timespec='seconds') + '+00:00' # TODO HACK
            path = '/' + str(path.relative_to(build))
            if path.endswith('/index.html'):
                path = path.rsplit('index.html', 1)[0]
            yield path, mtime

def main():
    args = iter(sys.argv)
    next(args)
    build_dir = Path(next(args))
    src_dir = Path(next(args))
    output_path = Path(next(args))
    op = next(args)
    interpolator = Interpolator(build_dir, src_dir, output_path)
    getattr(interpolator, op)(*args)

if __name__ == '__main__':
    main()
