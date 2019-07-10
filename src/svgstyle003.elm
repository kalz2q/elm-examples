module SvgStyle003 exposing (main)

--   <defs>
--   <style>
--     circle {
--       fill: orange;
--       stroke: black;
--       stroke-width: 10px; /* Note: The value of a pixel depends
--                              on the view box */
--     }
--   </defs>
--   </style>
--   <circle cx="50" cy="50" r="40" />

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "200", SA.height "200" ]
            [ Svg.defs []
                [ Svg.style []
                    [ Svg.text """circle {
                                     fill: orange;
                                     stroke: black;
                                     stroke-width: 10px;
                               }
                               """
                    ]
                ]
            , Svg.circle
                [ SA.cx "50"
                , SA.cy "50"
                , SA.r "40"
                ]
                []
            ]
        ]
