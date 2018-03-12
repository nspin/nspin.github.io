from collections import namedtuple

Article = namedtuple('Article', ['id', 'title', 'description', 'date'])

articles = [
    Article(
        'solving-the-rubiks-cube-blindfolded',
        "Solving the Rubik's Cube Blindfolded",
        'A math-based explanation from scratch.',
        'Feb 2 2018',
        ),
    Article(
        'pure-x11-logic-in-haskell',
        'Pure X11 Logic in Haskell',
        'A set of libraries providing a pure interface to XHB.',
        'Jul 22 2016',
        ),
    ]
