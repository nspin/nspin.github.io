import sys
import os.path
from jinja2 import Environment, FileSystemLoader, Markup

import articles

def article_by_id(article_id):
    for article in articles.articles:
        if article.id == article_id:
            return article
    raise Exception('invalid article id: ' + article_id)

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
            # sys.stderr.write('[interpolate] in {}, {} is {}\n'.format(os.path.join('/', os.path.relpath(self.output_path, self.build_dir)), abs_path, rel_path))
            return rel_path
        with open(self.output_path, 'w') as f:
            self.env.get_template(template_name).stream(dict(path_to=path_to, **data)).dump(f)

    def page(self, template_name):
        self.interpolate(template_name, {})

    def article(self, article_id):
        self.interpolate('templates/article.html', {
            'meta': article_by_id(article_id),
            'body': sys.stdin.read(),
        })

    def articles(self):
        self.interpolate('templates/articles.html', {
            'articles': articles.articles,
        })

def main():
    build_dir = sys.argv[1]
    output_path = sys.argv[2]
    op = sys.argv[3]
    interpolator = Interpolator(build_dir, output_path)
    getattr(interpolator, op)(*sys.argv[4:])

if __name__ == '__main__':
    main()
