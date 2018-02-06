{-# LANGUAGE OverloadedStrings #-}

import Control.Monad
import Data.Monoid
import Hakyll
import Text.Pandoc.Options

config :: Configuration
config = defaultConfiguration { providerDirectory = "site" }

main :: IO ()
main = hakyllWith config $ do

    match "templates/*" $ compile templateCompiler

    mapM copy
        [ "CNAME"
        , "favicon.ico"
        , "resume.pdf"
        , "images/*"
        , "css/*.css"
        ]

    mapM content
        [ "404.html"
        , "index.html"
        , "projects.html"
        ]

    match "articles/*" $ do
        route $ setExtension ".html"
        compile $ pandoc
            >>= loadAndApplyTemplate "templates/article.html" defaultContext
            >>= loadAndApplyTemplate "templates/content.html" defaultContext

    create ["articles.html"] $ do
        route idRoute
        let ctx =  constField "title" "Articles"
                <> listField "articles" defaultContext (loadAll "articles/*")
                <> defaultContext
        compile $ makeItem ""
            >>= loadAndApplyTemplate "templates/article.html" defaultContext
            >>= loadAndApplyTemplate "templates/content.html" defaultContext

  where

    copy pattern = match pattern $ do
        route idRoute
        compile copyFileCompiler

    content pattern = match pattern $ do
        route idRoute
        compile $ getResourceBody
            >>= loadAndApplyTemplate "templates/content.html" defaultContext

    pandoc = pandocCompilerWith defaultHakyllReaderOptions $
        defaultHakyllWriterOptions
            { writerHTMLMathMethod = MathJax ""
            }
