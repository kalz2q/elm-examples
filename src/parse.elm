module Main exposing (Route(..), route, toRoute)

import Url
import Url.Parser as Parser exposing ((</>), Parser, int, map, oneOf, parse, s, top)


type Route
    = Home
    | Blog Int
    | NotFound


route : Parser (Route -> a) a
route =
    Parser.oneOf
        [ Parser.map Home top
        , Parser.map Blog (s "blog" </> int)
        ]


toRoute : String -> Route
toRoute string =
    case Url.fromString string of
        Nothing ->
            NotFound

        Just url ->
            Maybe.withDefault NotFound (parse route url)



-- toRoute "/blog/42"                            ==  NotFound
-- toRoute "https://example.com/"                ==  Home
-- toRoute "https://example.com/blog"            ==  NotFound
-- toRoute "https://example.com/blog/42"         ==  Blog 42
-- toRoute "https://example.com/blog/42/"        ==  Blog 42
-- toRoute "https://example.com/blog/42#wolf"    ==  Blog 42
-- toRoute "https://example.com/blog/42?q=wolf"  ==  Blog 42
-- toRoute "https://example.com/settings"        ==  NotFound
