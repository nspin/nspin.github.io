import sys
from jinja2 import Environment, FileSystemLoader

import articles

env = Environment(loader=FileSystemLoader('.'))

def article_by_id(article_id):
    for article in articles.articles:
        if article.id == article_id:
            return article
    raise Exception('invalid article id: ' + article_id)

def do_page(template_name):
    env.get_template(template_name).stream().dump(sys.stdout)

def do_article(article_id):
    article = article_by_id(article_id)
    with open('articles/{}.md'.format(article_id), 'r') as f:
        body = f.read()
    env.get_template('templates/article.html').stream({
        'meta': article,
        'body': sys.stdin.read(),
    }).dump(sys.stdout)

def do_articles():
    env.get_template('templates/articles.html').stream({
        'articles': articles.articles,
    }).dump(sys.stdout)

def main():
    op = sys.argv[1]
    if op == 'page':
        do_page(sys.argv[2])
    elif op == 'article':
        do_article(sys.argv[2])
    elif op == 'articles':
        do_articles()
    else:
        exit('! invalid op')

if __name__ == '__main__':
    main()
