-- 
module Main exposing (main)

-- We're importing the Html module the text value available in our file, so we
-- can just reference it if we want.

import Html exposing (text)



-- The main value manages what gets displayed on the page. If we set the main
-- value to (text "Hello, World!"), then a text node with the string "Hello, World!"
-- will display on the page.


main =
    text "Hello, World!"
