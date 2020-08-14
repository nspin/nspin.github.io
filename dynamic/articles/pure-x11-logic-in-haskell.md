---
template: templates/article.html
title: Pure X11 Logic in Haskell
date: 2016-07-22
...

X11 programming in Haskell has traditionally been done using the [X11 package](https://hackage.haskell.org/package/X11-1.6.1.2).
Many of these bindings were written by hand and, due to their reliance on FFI, are susceptible to some threading issues.
[xhb](https://hackage.haskell.org/package/xhb), a newer package, provides low-level bindings to X11 based on the same XML as [xcb](https://xcb.freedesktop.org/).

It doesn't seem as though much has been done with XHB yet.
In fact, at the time of writing (Aug 22, 2016), exactly two packages on Hackage depend on xhb.
Nevertheless, I believe it hold great promise in the future of X programming in Haskell.

I've been working on a set of libraries that allows for layers of abstraction to be stacked on top of the low-level xhb bindings.
This post will become more fleshed out as I find time to finish up and document the actual libraries, but here's an overview.

## xhb-requests

(*[source](https://github.com/nspin/xhb-requests), [docs](https://nspin.github.io/xhb-requests)*)

Most generated functions in xhb have types similar to those below:

```haskell
createWindow :: Connection -> CreateWindow -> IO ()
grabKeyboard :: Connection -> GrabKeyboard -> IO (Receipt GrabStatus)
```

Those requests which expect responses can wait for them as follows:

```haskell
getReply :: Receipt a -> IO (Either SomeError a)
```

Some functions are a bit different (request parameters don't live inside a dedicated type, but are passed directly to the function):

```haskell
configureWindow :: Connection -> WINDOW -> ValueParam Word16 -> IO ()
queryTextExtents :: Connection -> FONTABLE -> [CHAR2B] -> IO (Receipt QueryTextExtentsReply)
```

Nevertheless, thanks to disciplined code generation, xhb has a clean and uniform code base.
The (in progress) [xhb-requests](https://github.com/nspin/xhb-requests) package wraps all of these generated request functions in two classes:

```haskell
class Request a where
    requestIO :: a -> Connection -> IO ()

class RequestWithReply a b | a -> b, b -> a where
    requestWithReplyIO :: a -> Connection -> IO (IO (Either SomeError b))
```

The instances of this class are generated from the xhb code that is itself generated from XML, which sounds ugly, but it worked quite well.
This is the foundation for xhb-monad.

## xhb-monad

(*[source](https://github.com/nspin/xhb-monad), [docs](https://nspin.github.io/xhb-monad)*)

This package defines the following class:


```haskell
class Monad x => XContext x where
    request :: Request a => a -> Connection -> x ()
    requestWithReply :: RequestWithReply a b => a -> Connection -> x (x (Either SomeError b))
    awaitEvent :: Connection -> x SomeEvent

instance XContext IO where
    request = requestIO
    requestWithReply = requestWithReplyIO
    awaitEvent = waitForEvent
```

and the following monad transformer:

```haskell
class (XContext x, Monad m) => MonadX x m | m -> x where
    liftX :: x a -> m a
    askX :: m Connection
    catchErrorX :: m a -> (SomeError -> m a) -> m a
    throwErrorX :: SomeError -> m a

newtype X m a = X { runX :: ReaderT Connection (ExceptT SomeError m) a }
    deriving (Functor, Applicative, Monad, MonadIO, Typeable)

instance XContext x => MonadX x (X x) where
    liftX = X . lift . lift
    askX = X ask
    catchErrorX m f = X $ catchError (runX m) (runX . f)
    throwErrorX = X . throwError

--- mtl stuff also
instance MonadFoo Bar where...
```

This abstraction allows for *pure* X logic.
It also lets us isolate unwieldy layers of computation and bits of state in the usual `mtl` way.
xhb-mapping-state is an example of this.

## xhb-mapping-state

(*[source](https://github.com/nspin/xhb-mapping-state), [docs](https://nspin.github.io/xhb-mapping-state)*)

<!-- *   [xhb-keysyms](/xhb-keysyms) -->

`TODO`
