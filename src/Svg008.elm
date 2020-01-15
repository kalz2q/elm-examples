module Svg008 exposing (main)



import Html exposing (..)
import Svg
import Svg.Attributes as SA


main : Html msg
main =
    div []
        [ faceSvg
        ]


faceSvg : Html msg
faceSvg =
    Svg.svg
        [ SA.width "160", SA.height "160" ]
        [ Svg.rect
            [ SA.x "0"
            , SA.y "0"
            , SA.width "160"
            , SA.height "160"
            , SA.fill "skyblue"
            ]
            []
        , Svg.circle [ SA.cx "80", SA.cy "80", SA.r "40", SA.fill "gold" ] []
        , Svg.circle [ SA.cx "65", SA.cy "75", SA.r "5", SA.fill "black" ] []
        , Svg.circle [ SA.cx "95", SA.cy "75", SA.r "5", SA.fill "black" ] []
        , Svg.line [ SA.x1 "75", SA.y1 "100", SA.x2 "85", SA.y2 "100", SA.stroke "red", SA.strokeWidth "5", SA.strokeLinecap "round" ] []
        ]
