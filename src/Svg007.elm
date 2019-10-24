module Svg007 exposing (main)

-- another example of viewport

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg
            [ SA.width "160"
            , SA.height "160"
            , SA.viewBox "0 0 160 160"
            ]
            [ Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "100%"
                , SA.width "100%"
                ]
                []
            , Svg.circle
                [ SA.cx "50%"
                , SA.cy "50%"
                , SA.r "4"
                , SA.fill "white"
                ]
                []
            ]
        , Svg.svg
            [ SA.width "80"
            , SA.height "80"
            , SA.viewBox "0 0 10 10"
            ]
            [ Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "100%"
                , SA.width "100%"
                ]
                []
            , Svg.circle
                [ SA.cx "50%"
                , SA.cy "50%"
                , SA.r "4"
                , SA.fill "white"
                ]
                []
            ]
        , Svg.svg
            [ SA.width "160"
            , SA.height "160"
            , SA.viewBox "-5 -5 10 10"
            ]
            [ Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "100%"
                , SA.width "100%"
                ]
                []
            , Svg.circle
                [ SA.cx "50%"
                , SA.cy "50%"
                , SA.r "4"
                , SA.fill "white"
                ]
                []
            ]
        ]
