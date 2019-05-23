module BlueBox002 exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)



-- draw a blue box , skyblue, centering


main =
    layout [Font.size 12] <|
        column [ centerX , centerY]
            [ wrappedRow
                [width <| px 400]
                [ row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color skyblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "skyblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color cadetblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "cadetblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color powderblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "powderblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color deepskyblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "deepskyblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color lightblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "lightblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color skyblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "skyblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color lightskyblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "lightskyblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color steelblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "steelblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color dodgerblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "dodgerblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color lightsteelblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "lightsteelblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color cornflowerblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "cornflowerblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color royalblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "royalblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color darkblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "darkblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color mediumblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "mediumblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color blue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "blue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color midnightblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "midnightblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color navy
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "navy" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color darkslateblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "darkslateblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color slateblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "slateblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color mediumslateblue
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "mediumslateblue" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color mediumpurple
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "mediumpurple" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color rebeccapurple
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "rebeccapurple" ] ]
                , row
                    [ width <| px 100
                    , height <| px 100
                    , Background.color blueviolet
                    , centerX
                    , centerY
                    ]
                    [ row [ centerX, centerY ] [ text "blueviolet" ] ]

                ]
            ]


cadetblue =
    rgb255 95 158 160


powderblue =
    rgb255 176 224 230


deepskyblue =
    rgb255 0 191 255


lightblue =
    rgb255 173 216 230


skyblue =
    rgb255 135 206 235


lightskyblue =
    rgb255 135 206 250


steelblue =
    rgb255 70 130 180


dodgerblue =
    rgb255 30 144 255


slategray =
    rgb255 112 128 144


lightslategray =
    rgb255 119 136 153


lightsteelblue =
    rgb255 176 196 222


cornflowerblue =
    rgb255 100 149 237


royalblue =
    rgb255 65 105 225


aliceblue =
    rgb255 240 248 255


darkblue =
    rgb255 0 0 139


mediumblue =
    rgb255 0 0 205


blue =
    rgb255 0 0 255


midnightblue =
    rgb255 25 25 112


navy =
    rgb255 0 0 128


darkslateblue =
    rgb255 72 61 139


slateblue =
    rgb255 106 90 205


mediumslateblue =
    rgb255 123 104 238


mediumpurple =
    rgb255 147 112 219


rebeccapurple =
    rgb255 102 51 153


blueviolet =
    rgb255 138 43 226
