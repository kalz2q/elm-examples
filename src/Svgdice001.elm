module Svgdice001 exposing (main)

-- let's show the dieface first

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg
            [ SA.width "120"
            , SA.height "120"
            , SA.viewBox "0 0 120 120"
            , SA.fill "white"
            , SA.stroke "black"
            , SA.strokeWidth "3"
            , HA.style "padding-left" "20px"
            ]
            (List.append
                [ Svg.rect [ SA.x "1", SA.y "1", SA.width "100", SA.height "100", SA.rx "15", SA.ry "15" ] [] ]
                (svgCirclesForDieFace 1)
            )
        ]


svgCirclesForDieFace : Int -> List (Svg.Svg msg)
svgCirclesForDieFace dieFace =
    case dieFace of
        1 ->
            [ Svg.circle [ SA.cx "50", SA.cy "50", SA.r "10", SA.fill "red", SA.stroke "red" ] [] ]

        2 ->
            [ Svg.circle [ SA.cx "25", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "75", SA.r "10", SA.fill "black" ] []
            ]

        3 ->
            [ Svg.circle [ SA.cx "25", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "50", SA.cy "50", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "75", SA.r "10", SA.fill "black" ] []
            ]

        4 ->
            [ Svg.circle [ SA.cx "25", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "25", SA.cy "75", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "75", SA.r "10", SA.fill "black" ] []
            ]

        5 ->
            [ Svg.circle [ SA.cx "25", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "25", SA.cy "75", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "75", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "50", SA.cy "50", SA.r "10", SA.fill "black" ] []
            ]

        6 ->
            [ Svg.circle [ SA.cx "25", SA.cy "20", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "25", SA.cy "50", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "25", SA.cy "80", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "20", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "50", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "80", SA.r "10", SA.fill "black" ] []
            ]

        _ ->
            [ Svg.circle [ SA.cx "50", SA.cy "50", SA.r "50", SA.fill "red", SA.stroke "none" ] [] ]
