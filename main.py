import re
import sys
import glob
import os.path
from datetime import datetime
from pathlib import Path
from subprocess import check_output

import yaml
from jinja2 import Environment, FileSystemLoader, Markup

def get_md_meta(md_path):
    with open(md_path) as f:
        return next(yaml.load_all(f, Loader=yaml.FullLoader))

def compile_md(md_path):
    meta = get_md_meta(md_path)
    body = check_output(['pandoc', '--read=markdown', '--write=html', '--mathjax', md_path], encoding='utf8')
    return {
        'meta': meta,
        'body': body
        }

class Interpolator(object):

    def __init__(self, build_dir, output_path):
        self.build_dir = build_dir
        self.output_path = output_path
        self.env = Environment(loader=FileSystemLoader('.'))
        def include_raw(path):
            return Markup(self.env.loader.get_source(self.env, path)[0])
        self.env.globals['include_raw'] = include_raw

    def path_to(self, abs_path):
        assert abs_path.startswith('/')
        rel_path = os.path.relpath(self.build_dir + abs_path, os.path.dirname(self.output_path))
        return rel_path

    def interpolate(self, template_name, data):
        with open(self.output_path, 'w') as f:
            self.env.get_template(template_name).stream(dict(path_to=self.path_to, **data)).dump(f)

    def html(self, template_name):
        self.interpolate(template_name, {})

    def md(self, md_path):
        result = compile_md(md_path)
        self.interpolate(result['meta']['template'], result)

    # HACK
    def articles(self):
        def go():
            for summary_path in glob.glob('articles/*.md'):
                article_id = re.compile(r'articles/(.*)\.md').match(summary_path).group(1)
                article_path = 'dynamic/articles/{}.md'.format(article_id)
                yield {
                    'meta': get_md_meta(article_path),
                    'id': article_id,
                    'body': compile_md(summary_path)['body'],
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
    build = Path('_build')
    for root, dirs, files in os.walk(build):
        root = Path(root)
        for f in files:
            path = root / f
            mtime = path.stat().st_mtime
            mtime = datetime.utcfromtimestamp(mtime).isoformat(timespec='seconds')
            path = '/' + str(path.relative_to(build))
            if path.endswith('/index.html'):
                path = path.rsplit('index.html', 1)[0]
            yield path, mtime

def main():
    build_dir = sys.argv[1]
    output_path = sys.argv[2]
    op = sys.argv[3]
    interpolator = Interpolator(build_dir, output_path)
    getattr(interpolator, op)(*sys.argv[4:])

if __name__ == '__main__':
    main()
