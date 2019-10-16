{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
-- ^ non toccare questa parte: il pragma e gli import servono!

main :: IO ()
main = hakyll $ do
  match "images/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match (fromList [ "pages/contact.md"
                  , "index.md"
                  , "pages/participants.md"
                  , "pages/programme.md"
                  , "pages/registration.md"
                  ]) $ do
    -- le opzioni che sono fissate dalla concatenazione monadica che segue
    -- sono applicate a tutti gli item della lista sopra ^
    route   $ setExtension "html"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      -- questa monade applica il template di default alle pagine, definito nel
      -- file templates/default.html.
      >>= relativizeUrls
      {- pandoc genera pagine html a partire dal markdown, e questa monade
         gli insegna a creare hyperlink relativi; la monade traversa l'HTML
         "and changes absolute URLs (e.g. /posts/foo.markdown into relative
         ones: ../posts/foo.markdown). This is extremely useful if you want
         to deploy your site in a subdirectory.""
      -}
  match "templates/*" $ compile templateBodyCompiler
