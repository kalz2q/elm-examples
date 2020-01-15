module Svgchristmas exposing (main)

import Html exposing (text)
import Html.Attributes exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Tuple exposing (first, second)


width =
    "300"


height =
    "300"


main : Html.Html msg
main =
    svg
        [ Svg.Attributes.width width
        , Svg.Attributes.height height
        , Svg.Attributes.style "border: 1px solid black"
        , viewBox <| "0 0 " ++ width ++ " " ++ height
        ]
        [ Svg.defs []
            [ Svg.linearGradient
                [ Svg.Attributes.id "mygrad"
                , x1 "0"
                , x2 "0"
                , y1 "0"
                , y2 "1"
                ]
                [ Svg.stop [ offset "0%", stopColor "green" ] []
                , Svg.stop [ offset "100%" ] []
                ]
            , Svg.linearGradient [ Svg.Attributes.id "base" ]
                [ Svg.stop [ offset "0%", stopColor "brown" ] []
                , Svg.stop [ offset "100%" ] []
                ]
            , Svg.radialGradient [ Svg.Attributes.id "star" ]
                [ Svg.stop [ offset "0%", stopColor "yellow" ] []
                , Svg.stop [ offset "100%", stopColor "orange" ] []
                ]
            , Svg.filter
                [ Svg.Attributes.id "glow"
                , Svg.Attributes.width "200%"
                , Svg.Attributes.height "200%"
                , x "-50%"
                , y "-50%"
                ]
                [-- Svg.feGaussianBlur
                 -- [ Svg.Attributes.in_ "StrokePaint"
                 -- , stdDeviation "3"
                 -- ]
                 -- []
                ]
            ]

        -- BASE
        , Svg.polygon
            [ points <|
                polyPoints
                    [ ( 130, 250 )
                    , ( 170, 250 )
                    , ( 170, 300 )
                    , ( 130, 300 )
                    ]
            , fill "url(#base)"
            , stroke "black"
            ]
            []

        -- GREANERY
        , Svg.polygon
            [ points <|
                polyPoints
                    [ ( 50, 270 )
                    , ( 250, 270 )
                    , ( 200, 200 )
                    , ( 100, 200 )
                    ]
            , fill "url(#mygrad)"
            , stroke "black"
            ]
            []
        , Svg.polygon
            [ points <|
                polyPoints
                    [ ( 70, 230 )
                    , ( 230, 230 )
                    , ( 180, 150 )
                    , ( 120, 150 )
                    ]
            , fill "url(#mygrad)"
            , stroke "black"
            ]
            []
        , Svg.polygon
            [ points <|
                polyPoints
                    [ ( 90, 180 )
                    , ( 210, 180 )
                    , ( 150, 100 )
                    ]
            , fill "url(#mygrad)"
            , stroke "black"
            ]
            []

        -- STAR
        , Svg.polygon
            [ points <|
                polyPoints
                    [ ( 150, 120 ) --bottom
                    , ( 160, 90 )
                    , ( 180, 80 ) -- right
                    , ( 160, 70 )
                    , ( 150, 50 ) -- top
                    , ( 140, 70 )
                    , ( 120, 80 ) -- left
                    , ( 140, 90 )
                    ]
            , fill "url(#star)"
            , stroke "black"
            ]
            []
        , light 150 200
        , light 100 210
        , light 200 210
        , light 130 150
        , light 150 170
        , light 170 150
        , light 80 250
        , light 120 250
        , light 180 250
        , light 220 250
        ]


light : Int -> Int -> Svg.Svg msg
light xx yy =
    Svg.g []
        [ Svg.circle
            [ cx <| String.fromInt xx
            , cy <| String.fromInt yy
            , r "6"
            , Svg.Attributes.filter "url(#glow)"
            , fill "yellow"
            ]
            []
        , Svg.circle
            [ cx <| String.fromInt xx
            , cy <| String.fromInt yy
            , r "3"
            , fill "yellow"
            ]
            []
        ]


pointToString : ( Float, Float ) -> String
pointToString p =
    let
        x =
            String.fromFloat <| first p

        y =
            String.fromFloat <| second p
    in
    x ++ "," ++ y


polyPoints : List ( Float, Float ) -> String
polyPoints l =
    List.map pointToString l |> String.join " "
