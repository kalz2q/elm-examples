-- svg and canvas is not treated by elm-ui
-- canvas is not available on elm
-- there is canvas but it is not working because it uses color
-- now checking svg on elm
-- or d3.js


module Main exposing (main)

import Svg exposing (..)
import Svg.Attributes exposing (..)


main =
    svg
        [ width "120"
        , height "120"
        , viewBox "0 0 120 120"
        ]
        [ rect
            [ x "10"
            , y "10"
            , width "100"
            , height "100"
            , rx "15"
            , ry "15"
            ]
            []
        , circle
            [ cx "50"
            , cy "50"
            , r "50"
            ]
            []
        ]
