import re
import sys
import glob
import os.path
from subprocess import check_output

import yaml
from jinja2 import Environment, FileSystemLoader, Markup

def get_md_meta(md_path):
    with open(md_path) as f:
        return next(yaml.load_all(f))

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

    def interpolate(self, template_name, data):
        def path_to(abs_path):
            assert abs_path.startswith('/')
            rel_path = os.path.relpath(self.build_dir + abs_path, os.path.dirname(self.output_path))
            return rel_path
        with open(self.output_path, 'w') as f:
            self.env.get_template(template_name).stream(dict(path_to=path_to, **data)).dump(f)

    def page(self, template_name):
        self.interpolate(template_name, {})

    def md(self, md_path):
        result = compile_md(md_path)
        self.interpolate(result['meta']['template'], result)

    def article(self, md_path):
        result = compile_md(md_path)
        self.interpolate('templates/article.html', result)

    def articles(self):
        def go():
            for md_path in glob.glob('articles/*.md'):
                yield {
                    'meta': get_md_meta(md_path),
                    'id': re.compile(r'articles/(.*)\.md').match(md_path).group(1)
                    }
        self.interpolate('templates/articles.html', {
            'articles': list(sorted(go(), key=lambda x: x['meta']['date'], reverse=True)),
        })

def main():
    build_dir = sys.argv[1]
    output_path = sys.argv[2]
    op = sys.argv[3]
    interpolator = Interpolator(build_dir, output_path)
    getattr(interpolator, op)(*sys.argv[4:])

if __name__ == '__main__':
    main()
