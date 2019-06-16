module Svg002 exposing (main)

-- dotinstall introduction to svg #03 viewBox won't work as demonstrated
-- it is because of elm or my elm translation or elm measurement , idon't know 
-- it is time to learn svg on mdn

import Html
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
                , SA.width "160"
                , SA.height "160"
                , SA.fill "skyblue"
                ]
                []
            , Svg.rect
                [ SA.x "40"
                , SA.y "40"
                , SA.width "80"
                , SA.height "80"
                , SA.fill "tomato"
                ]
                []
            ]
        , Svg.svg
            [ SA.width "160"
            , SA.height "160"
            , SA.viewBox "40 40 80 80"
            ]
            [ Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "160"
                , SA.height "160"
                , SA.fill "skyblue"
                ]
                []
            , Svg.rect
                [ SA.x "40"
                , SA.y "40"
                , SA.width "80"
                , SA.height "80"
                , SA.fill "tomato"
                ]
                []
            ]
        ]
