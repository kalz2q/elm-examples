module Svg006 exposing (main)

-- This is how to use defs => failure

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg
            [ SA.width "160"
            , SA.height "160"
            ]
            [ Svg.defs []
                [ Svg.style
                    [ SA.id "mybox"]
                    []
                , Svg.linearGradient [ SA.id "base" ]
                    [ Svg.stop [ SA.offset "0%", SA.stopColor "brown" ] []
                    , Svg.stop [ SA.offset "100%" ] []
                    ]
                ]
            , Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "160"
                , SA.height "160"
                , SA.fill "skyblue"
                ]
                []
            , Svg.rect
                [ SA.x "20"
                , SA.y "20"
                , SA.width "30"
                , SA.height "30"
                , SA.style "fill:#08c; stroke:#eee; stroke-width:5"
                ]
                []
            , Svg.rect
                [ SA.x "65"
                , SA.y "20"
                , SA.width "30"
                , SA.height "30"
                , SA.fill "lightgreen"

                -- , SA.class "mybox"
                -- , SA.fill "url(#mybox)"
                -- > disappear
                , SA.style "url(#mybox)"
                -- > black -> lightgreen
                -- , SA.style "#mybox"
                --> black -> lightgreen
                -- , SA.fill "url(#base)"
                ]
                []
            ]
        ]
