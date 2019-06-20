module Shapes exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [ SA.width "200", SA.height "250" ]
            [ Svg.rect [ SA.x "10", SA.y "10", SA.width "30", SA.height "30", SA.stroke "black", SA.fill "transparent", SA.strokeWidth "5" ] []
            , Svg.rect
                [ SA.x "60"
                , SA.y "10"
                , SA.rx "10"
                , SA.ry "10"
                , SA.width "30"
                , SA.height "30"
                , SA.stroke "olive"
                , SA.fill "pink"
                , SA.strokeWidth "7"
                ]
                []
            ]
            , Svg.circle [][]
            

            
        ]



-- <svg width="200" height="250" version="1.1" xmlns="http://www.w3.org/2000/svg">
--   <rect x="10" y="10" width="30" height="30" stroke="black" fill="transparent" stroke-width="5"/>
--   <rect x="60" y="10" rx="10" ry="10" width="30" height="30" stroke="black" fill="transparent" stroke-width="5"/>
--   <circle cx="25" cy="75" r="20" stroke="red" fill="transparent" stroke-width="5"/>
--   <ellipse cx="75" cy="75" rx="20" ry="5" stroke="red" fill="transparent" stroke-width="5"/>
--   <line x1="10" x2="50" y1="110" y2="150" stroke="orange" stroke-width="5"/>
--   <polyline points="60 110 65 120 70 115 75 130 80 125 85 140 90 135 95 150 100 145"
--       stroke="orange" fill="transparent" stroke-width="5"/>
--   <polygon points="50 160 55 180 70 180 60 190 65 205 50 195 35 205 40 190 30 180 45 180"
--       stroke="green" fill="transparent" stroke-width="5"/>
--   <path d="M20,230 Q40,205 50,230 T90,230" fill="none" stroke="blue" stroke-width="5"/>
-- </svg>
