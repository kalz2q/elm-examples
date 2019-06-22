module Arc exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [ SA.width "320", SA.height "320" ]
            [ Svg.path
                [ SA.d """M 10 315
                        L 110 215
                        A 30 50 0 0 1 162.55 162.45  
                        L 172.55 152.45           
                        A 30 50 -45 0 1 215.1 109.9 
                        L 315 10"""

                -- """M 10 315
                -- L 110 215
                -- A 30 50 0 0 1 162.55 162.45  L 172.55 152.45
                -- A 30 50 -45 0 1 215.1 109.9 L 315 10"""
                , SA.stroke "black"
                , SA.fill "green"
                , SA.strokeWidth "2"
                , SA.fillOpacity "0.5"
                ]
                []
            , Svg.circle
                [ SA.cx "162.55"
                , SA.cy "162.45"
                , SA.r "10"
                , SA.fill "red"
                , SA.opacity "0.5"
                ]
                []
            , Svg.circle
                [ SA.cx "110"
                , SA.cy "215"
                , SA.r "10"
                , SA.fill "red"
                , SA.opacity "0.5"
                ]
                []
            ]
        ]
