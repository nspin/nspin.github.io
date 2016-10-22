{-# LANGUAGE OverloadedStrings #-}

import           Control.Monad
import           Data.Monoid
import           Hakyll

config :: Configuration
config = defaultConfiguration { providerDirectory = "site" }

main :: IO ()
main = hakyllWith config $ do

    let copies = [ "CNAME"
                 , "favicon.ico"
                 , "images/*"
                 , "css/*"
                 , "resume.pdf"
                 ]

    forM copies $ flip match (route idRoute >> compile copyFileCompiler)

    let stack ctx tmplts = foldl (>=>) return $ map (flip loadAndApplyTemplate ctx) tmplts

    match "templates/*" $ compile templateCompiler

    match "404.html" $ do
        route $ idRoute
        compile $ getResourceBody >>= stack defaultContext ["templates/content.html"]

    match "index.html" $ do
        route $ idRoute
        compile $ getResourceBody >>= stack defaultContext ["templates/content.html"]

    match "projects.md" $ do
        route $ setExtension ".html"
        compile $ pandocCompiler >>= stack defaultContext ["templates/content.html"]

    match "articles/*" $ do
        route $ setExtension ".html"
        compile $ pandocCompiler >>= stack defaultContext ["templates/article.html", "templates/content.html"]

    create ["articles.html"] $ do
        route idRoute
        let ctx =  constField "title" "Articles"
                <> listField "articles" defaultContext (loadAll "articles/*")
                <> defaultContext
        compile $ makeItem "" >>= stack ctx ["templates/articles.html", "templates/content.html"]
