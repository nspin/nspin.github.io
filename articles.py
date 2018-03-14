from collections import namedtuple
from datetime import date

Article = namedtuple('Article', ['id','title','desc','date','has_math'])

articles = [
    Article(
        id       = 'solving-the-rubiks-cube-blindfolded',
        title    = "Solving the Rubik's Cube Blindfolded",
        desc     = 'A math-based explanation from scratch.',
        date     = date(2018, 2, 2),
        has_math = True,
        ),
    Article(
        id       = 'pure-x11-logic-in-haskell',
        title    = 'Pure X11 Logic in Haskell',
        desc     = 'A set of libraries providing a pure interface to XHB.',
        date     = date(2016, 7, 22),
        has_math = False,
        ),
    ]
