{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll

main :: IO ()
main = hakyll $ do
  match "images/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match (fromList [ "programme.md"
                  , "registration.md"
                  , "contact.md"
                  , "participants.md"
                  , "index.md"
                  ]) $ do
    route   $ setExtension "html"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls
  --
  -- match "index.md" $ do
  --   route $ setExtension "html"
  --   compile $ pandocCompiler
  --   compile $ do
  --
  --     getResourceBody
  --       >>= loadAndApplyTemplate "templates/default.html" defaultContext
  --       >>= relativizeUrls

  match "templates/*" $ compile templateBodyCompiler
