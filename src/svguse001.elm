module SvgUse001 exposing (main)

import Html
import Svg
import Svg.Attributes as SA

-- This doesn't work

main =
    Html.div []
        [ Svg.svg
            [ SA.width "160"
            , SA.height "160"
            ]
            [Svg.defs []
              [Svg.g [SA.id "Port"]
                [Svg.circle [SA.fill "red", SA.r "40"][]
              ]
            , Svg.use [SA.cx "50", SA.cy "50", SA.xlinkHref "url(#Port)"][]


-- <use x="50" y="10" xlink:href="#Port" />
-- use => 

            ]
        ]

        ]