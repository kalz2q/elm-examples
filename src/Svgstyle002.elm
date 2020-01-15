module Svgstyle002 exposing (main)

-- this does not work
-- the idea is clipPath, svgclip.elm where defs Svg,clipPath,Svg.circle SA.clipPath that is clipPath is use for Svg and SA.
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
                [ Svg.style
                    [ SA.id "mycircle"
                    , SA.fill "orange"
                    , SA.stroke "blue"
                    , SA.strokeWidth "10"
                    ]
                    [ Svg.style
                        [ SA.fill "red" ]
                        []
                    ]
                ]
            , Svg.circle
                [ SA.cx "50"
                , SA.cy "50"
                , SA.r "40"
                , SA.style "url(#mycircle)"
                ]
                []
            ]
        ]
