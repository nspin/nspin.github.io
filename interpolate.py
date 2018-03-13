import sys
import os.path
from jinja2 import Environment, FileSystemLoader

import articles

env = Environment(loader=FileSystemLoader('.'))

def article_by_id(article_id):
    for article in articles.articles:
        if article.id == article_id:
            return article
    raise Exception('invalid article id: ' + article_id)

def main():
    build_dir = sys.argv[1]
    out_path = sys.argv[2]
    op = sys.argv[3]

    def path_to(p):
        assert p[0] == '/'
        return os.path.relpath(build_dir + p, os.path.dirname(out_path))

    data = { 'path_to': path_to }

    with open(out_path, 'w') as f:

        if op == 'page':
            template_name = sys.argv[4]
            env.get_template(template_name).stream(data).dump(f)

        elif op == 'article':
            article_id = sys.argv[4]
            article = article_by_id(article_id)
            with open('articles/{}.md'.format(article_id), 'r') as fin:
                body = fin.read()
            data.update({
                'meta': article,
                'body': sys.stdin.read(),
            })
            env.get_template('templates/article.html').stream(data).dump(f)

        elif op == 'articles':
            data.update({
                'articles': articles.articles,
            })
            env.get_template('templates/articles.html').stream(data).dump(f)

        else:
            exit('! invalid op')

if __name__ == '__main__':
    main()
