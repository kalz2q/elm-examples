module Arc003 exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [ SA.width "325", SA.height "325" ]
            [ Svg.path
                [ SA.d """M 80 80
                  A 45 45, 0, 0, 0, 125 125
                  L 125 80 Z"""
                , SA.fill "green"
                , SA.strokeWidth "3"
                , SA.stroke "black"
                ]
                []
            , Svg.path
                [ SA.d """M 230 80
                  A 45 45, 0, 1, 0, 275 125
                  L 275 80 Z"""
                , SA.fill "red"
                , SA.strokeWidth "3"
                , SA.stroke "black"
                ]
                []
            , Svg.path
                [ SA.d """M 80 230
                  A 45 45, 0, 0, 1, 125 275
                  L 125 230 Z"""
                , SA.fill "purple"
                , SA.strokeWidth "3"
                , SA.stroke "black"
                ]
                []
            , Svg.path
                [ SA.d """M 230 230
                  A 45 45, 0, 1, 1, 275 275
                  L 275 230 Z"""
                , SA.fill "blue"
                , SA.strokeWidth "3"
                , SA.stroke "black"
                ]
                []
            ]
        ]
