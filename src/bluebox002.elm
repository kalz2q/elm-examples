module BlueBox002 exposing (main)

import Element exposing (..)
import Element.Background as Background
import Html exposing (Html)



-- draw a blue box , skyblue, centering


main =
    layout [] <|
        column [ centerX ]
            [ wrappedRow
                []
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


lavender =
    rgb255 230 230 250


ghostwhite =
    rgb255 248 248 255


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
