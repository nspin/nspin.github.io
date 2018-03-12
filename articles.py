from collections import namedtuple

Article = namedtuple('Article', ['id','title','desc','date','has_math'])

articles = [
    Article(
        id       = 'solving-the-rubiks-cube-blindfolded',
        title    = "Solving the Rubik's Cube Blindfolded",
        desc     = 'A math-based explanation from scratch.',
        date     = 'Feb 2 2018',
        has_math = True
        ),
    Article(
        id       = 'pure-x11-logic-in-haskell',
        title    = 'Pure X11 Logic in Haskell',
        desc     = 'A set of libraries providing a pure interface to XHB.',
        date     = 'Jul 22 2016',
        has_math = False
        ),
    ]
