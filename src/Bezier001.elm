module Bezier001 exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [ SA.width "190", SA.height "160" ]
            [ Svg.path
                [ SA.d "M 10 10 C 20 20, 40 20, 50 10"
                , SA.stroke "black"
                , SA.fill "transparent"
                ]
                []
            , Svg.path
                [ SA.d "M 70 10 C 70 20, 120 20, 120 10", SA.stroke "black", SA.fill "transparent" ]
                []
            , Svg.path  [ SA.d "M 130 10 C 120 20, 180 20, 170 10", SA.stroke "black", SA.fill "transparent" ] []
            , Svg.path  [ SA.d "M 10 60 C 20 80, 40 80, 50 60", SA.stroke "black", SA.fill "transparent" ] []
            , Svg.path  [ SA.d "M 70 60 C 70 80, 110 80, 110 60", SA.stroke "black", SA.fill "transparent" ] []
            , Svg.path  [ SA.d "M 130 60 C 120 80, 180 80, 170 60", SA.stroke "black", SA.fill "transparent" ] []
            , Svg.path  [ SA.d "M 10 110 C 20 140, 40 140, 50 110", SA.stroke "black", SA.fill "transparent" ] []
            , Svg.path  [ SA.d "M 70 110 C 70 140, 110 140, 110 110", SA.stroke "black", SA.fill "transparent" ] []
            , Svg.path  [ SA.d "M 130 110 C 120 140, 180 140, 170 110", SA.stroke "black", SA.fill "transparent" ] []
            ]
        ]
