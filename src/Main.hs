{-# LANGUAGE OverloadedStrings #-}

import           Data.Monoid
import           Hakyll
-- import qualified Text.Pandoc as P

config :: Configuration
config = defaultConfiguration { providerDirectory = "site" }

main :: IO ()
main = hakyllWith config $ do

    match "CNAME" $ do
        route idRoute
        compile copyFileCompiler

    match "favicon.ico" $ do
        route idRoute
        compile copyFileCompiler

    match "404.md" $ do
        route $ setExtension ".html"
        compile $ do
            pandocCompiler
                >>= loadAndApplyTemplate "templates/content.html" defaultContext
                >>= loadAndApplyTemplate "templates/default.html" defaultContext

    -- static files
    match "images/*" $ do
        route idRoute
        compile copyFileCompiler
    match "css/*" $ do
        route idRoute
        compile copyFileCompiler

    match ( "index.html"
          ) $ do
        route $ idRoute
        compile $ do
            getResourceBody
                >>= loadAndApplyTemplate "templates/content.html" defaultContext
                >>= loadAndApplyTemplate "templates/default.html" defaultContext

    match "articles/*" $ do
        route $ setExtension ".html"
        compile $ do
            pandocCompiler
                >>= loadAndApplyTemplate "templates/article.html" defaultContext
                >>= loadAndApplyTemplate "templates/content.html" defaultContext
                >>= loadAndApplyTemplate "templates/default.html" defaultContext

    create ["articles.html"] $ do
        route idRoute
        compile $ do
            articles <- loadAll "articles/*"
            let ctx =  constField "title" "Articles"
                    <> listField "articles" defaultContext (return articles)
                    <> defaultContext
            makeItem ""
                >>= loadAndApplyTemplate "templates/articles.html" ctx
                >>= loadAndApplyTemplate "templates/content.html" ctx
                >>= loadAndApplyTemplate "templates/default.html" ctx
    

    match  (   "projects.md"
          .||. "contact.md"
           ) $ do
        route $ setExtension ".html"
        compile $ do
            pandocCompiler
                >>= loadAndApplyTemplate "templates/content.html" defaultContext
                >>= loadAndApplyTemplate "templates/default.html" defaultContext

    match  "resume.md" $ do
        route $ setExtension ".html"
        compile $ do
            pandocCompiler
                >>= loadAndApplyTemplate "templates/resume.html" defaultContext
                >>= loadAndApplyTemplate "templates/content.html" defaultContext
                >>= loadAndApplyTemplate "templates/default.html" defaultContext

    match "templates/*" $ do
        compile templateCompiler
