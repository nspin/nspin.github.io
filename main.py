import os
import os.path
import sys
import time
import subprocess
import urllib
import posixpath
from glob import glob
from threading import Thread
from collections import defaultdict, namedtuple
from http.server import SimpleHTTPRequestHandler, HTTPServer
from jinja2 import Environment, FileSystemLoader

Action = namedtuple('Action', ['inputs', 'outputs', 'run', 'msg'])

class Site(object):

    def __init__(self):
        self.all_inputs = set()
        self.all_outputs = set()
        self.on_modify = defaultdict(set)
        self.mtimes = defaultdict(lambda: -1)

    def register(self, action):
        self.all_inputs.update(action.inputs)
        self.all_outputs.update(action.outputs)
        for path in action.inputs:
            self.on_modify[path].add(action)

    def register_simple(self, msg, output, inputs, run):
        self.register(Action(
            inputs=tuple(inputs),
            outputs=(output,),
            run=run,
            msg=msg,
            ))

    def update(self):
        while True:
            modified = set()
            for path in self.all_inputs:
                real = os.stat(path).st_mtime_ns
                if real > self.mtimes[path]:
                    modified.add(path)
            if not modified:
                break
            actions = set()
            for path in modified:
                actions.update(self.on_modify[path])
            for action in actions:
                print('  <<< ACTION: {} >>>'.format(action.msg))
                action.run()
            for path in modified:
                self.mtimes[path] = os.stat(path).st_mtime_ns

site = Site()

env = Environment(
        loader=FileSystemLoader('.'),
        auto_reload=True,
        )

def render(input, output, data={}):
    def run():
        os.makedirs(os.path.dirname(output), exist_ok=True)
        with open(output, 'w') as f:
            env.get_template(input).stream(data).dump(f)
    return run

for page in glob('pages/*.html'):
    dst = 'site/' + os.path.basename(page)
    site.register_simple(
        'Page: {}'.format(page),
        dst,
        [page, 'templates/content.html'],
        render(page, dst)
        )

Article = namedtuple('Article', ['id', 'title', 'description', 'date'])

articles = [
    Article(
        'solving-the-rubiks-cube-blindfolded',
        "Solving the Rubik's Cube Blindfolded",
        'A math-based explanation from scratch.',
        'Feb 02 2018',
        ),
    Article(
        'pure-x11-logic-in-haskell',
        'Pure X11 Logic in Haskell',
        'A set of libraries providing a pure interface to XHB.',
        'Jul 22 2016',
        ),
    ]

site.register_simple(
    'Articles',
    'site/articles.html',
    ['templates/articles.html', 'templates/content.html'],
    render('templates/articles.html', 'site/articles.html', data={
        'articles': articles,
        })
    )

def make_article(article):
    def run():
        proc = subprocess.run(
            ['pandoc', '--read=markdown', '--write=html', '--mathjax', 'articles/{}.md'.format(article.id)],
            stdout=subprocess.PIPE,
            stderr=sys.stderr,
            encoding='utf8',
            check=True,
            )
        render('templates/article.html', 'site/articles/{}.html'.format(article.id), data={
            'title': article.title,
            'date': article.date,
            'description': article.description,
            'body': proc.stdout,
            })()
    return run

for article in articles:
    site.register_simple(
        'Article: {}'.format(article.id),
        'site/articles/{}.html'.format(article.id),
        ['articles/{}.md'.format(article.id), 'templates/article.html', 'templates/content.html'],
        make_article(article)
        )


class L0lHTTPRequestHandler(SimpleHTTPRequestHandler):
    def translate_path(self, path):
        path = path.split('?',1)[0]
        path = path.split('#',1)[0]
        trailing_slash = path.rstrip().endswith('/')
        try:
            path = urllib.parse.unquote(path, errors='surrogatepass')
        except UnicodeDecodeError:
            path = urllib.parse.unquote(path)
        path = posixpath.normpath(path)
        words = path.split('/')
        words = filter(None, words)
        path = os.path.join(os.getcwd(), 'site')
        for word in words:
            if os.path.dirname(word) or word in (os.curdir, os.pardir):
                continue
            path = os.path.join(path, word)
        if trailing_slash:
            path += '/'
        return path

def serve():
    server_address = ('', 8000)
    L0lHTTPRequestHandler.protocol_version = "HTTP/1.0"
    with HTTPServer(server_address, L0lHTTPRequestHandler) as httpd:
        sa = httpd.socket.getsockname()
        serve_message = "Serving HTTP on {host} port {port} (http://{host}:{port}/) ..."
        print(serve_message.format(host=sa[0], port=sa[1]))
        httpd.serve_forever()


def main():

    Thread(target=serve, daemon=True).start()

    while True:
        site.update()
        time.sleep(.2)

if __name__ == '__main__':
    main()
