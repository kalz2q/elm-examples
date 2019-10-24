module Arithmetic exposing (main)

-- show elm arithmetic operators
-- use ul li  , numbered list
-- centering but left aligned

import Html
import Html.Attributes as HA


main =
    Html.div
        [ HA.style "background-color" "gainsboro"
        , HA.style "width" "600px"
        , HA.style "margin" "auto"
        , HA.style "position" "relative"
        ]
        [ Html.h1 [ HA.style "text-align" "center" ] [ Html.text "Arithmetic Operators" ]
        , Html.ol []
            [ Html.li [] [ Html.text ("addition: 1 + 2 is " ++ String.fromInt (1 + 2)) ]
            , Html.li [] [ Html.text ("subtraction: 1 -  2 is " ++ String.fromInt (1 - 2)) ]
            , Html.li [] [ Html.text ("multiplication: 3 * 2 is " ++ String.fromInt (3 * 2)) ]
            , Html.li [] [ Html.text ("division: 2 / 3 is " ++ String.fromFloat (2 / 3)) ]
            , Html.li [] [ Html.text ("division: floor ( 2 / 3 ) is " ++ String.fromInt (floor(2 / 3))) ]
            , Html.li [] [ Html.text ("modBy: modBy 4 -9 is " ++ String.fromInt (modBy 4 -9)) ]
            , Html.li [] [ Html.text ("modBy: modBy -4 9 is " ++ String.fromInt (modBy -4 9)) ]
            , Html.li [] [ Html.text ("modBy: modBy -4 -9 is " ++ String.fromInt (modBy -4 -9)) ]
            , Html.li [] [ Html.text ("remainderBy: remainderBy 4 -9 is " ++ String.fromInt (remainderBy 4 -9)) ]
            , Html.li [] [ Html.text ("remainderBy: remainderBy -4 9 is " ++ String.fromInt (remainderBy -4 9)) ]
            , Html.li [] [ Html.text ("remainderBy: remainderBy -4 -9 is " ++ String.fromInt (remainderBy -4 -9)) ]
            , Html.li [] [ Html.text ("power: 2 ^ 3 is " ++ String.fromInt (2 ^ 3)) ]
            , Html.li [] [ Html.text ("sqrt: sqrt 3 is " ++ String.fromFloat (sqrt 3)) ]
            , Html.li [] [ Html.text ("π: pi is " ++ String.fromFloat (pi)) ]
            , Html.li [] [ Html.text ("e: e is " ++ String.fromFloat (e)) ]
            , Html.li [] [ Html.text ("log: logBase 10 100  is " ++ String.fromFloat (logBase 10  100)) ]
            , Html.li [] [ Html.text ("sin: sin (degrees 30)   is " ++ String.fromFloat (sin (degrees 30))) ]
            , Html.li [] [ Html.text ("sin: sin (radians (pi / 6))   is " ++ String.fromFloat (sin (radians (pi / 6)))) ]
            ]
        ]
