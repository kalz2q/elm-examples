module Svgelm002 exposing (main)

-- Rewriting Svg example program  https://elm-lang.org/examples/shapes

import Html exposing (Html)
import Svg as Svg
import Svg.Attributes as SA


main : Html msg
main =
    Svg.svg
        [ SA.viewBox "0 0 400 400"
        , SA.width "400"
        , SA.height "400"
        , SA.style "background:#aaa"
        ]
        [ Svg.circle
            [ SA.cx "50"
            , SA.cy "50"
            , SA.r "40"
            , SA.fill "red"
            , SA.stroke "black"
            , SA.strokeWidth "3"
            ]
            []
        , Svg.rect
            [ SA.x "100"
            , SA.y "10"
            , SA.width "40"
            , SA.height "40"
            , SA.fill "green"
            , SA.stroke "black"
            , SA.strokeWidth "2"
            ]
            []
        , Svg.line
            [ SA.x1 "20"
            , SA.y1 "200"
            , SA.x2 "200"
            , SA.y2 "20"
            , SA.stroke "blue"
            , SA.strokeWidth "10"
            , SA.strokeLinecap "round"
            ]
            []
        , Svg.polyline
            [ SA.points "200,40 240,40 240,80 280,80 280,120 320,120 320,160"
            , SA.fill "none"
            , SA.stroke "red"
            , SA.strokeWidth "4"
            , SA.strokeDasharray "20,2"
            ]
            []
        , Svg.text_
            [ SA.x "130"
            , SA.y "130"
            , SA.fill "black"
            , SA.textAnchor "middle"
            , SA.dominantBaseline "central"
            , SA.transform "rotate(-45 130,130)"
            ]
            [ Svg.text "Welcome to Shapes Club"
            ]
        ]



-- There are a lot of odd things about SVG, so always try to find examples
-- to help you understand the weird stuff. Like these:
--
--   https://www.w3schools.com/graphics/svg_examples.asp
--   https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/d
--
-- If you cannot find relevant examples, make an experiment. If you push
-- through the weirdness, you can do a lot with SVG.
