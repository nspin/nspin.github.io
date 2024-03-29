---
{}
...

X11 programming in Haskell has traditionally been done using the [X11 package](https://hackage.haskell.org/package/X11-1.6.1.2).
Many of these bindings were written by hand and, due to their reliance on FFI, are susceptible to some threading issues.
[xhb](https://hackage.haskell.org/package/xhb), a newer package, provides low-level bindings to X11 based on the same XML as [xcb](https://xcb.freedesktop.org/).
I present a new set of libraries which serve as layers of abstraction over the low-level xhb bindings.
These libraries encapsulate interaction with the X server in a monad transformer, enabling the expression of pure X logic.
