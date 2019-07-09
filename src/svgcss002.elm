module SvgCss002 exposing (main)

--   <defs>
--     <style type="text/css"><![CDATA[
--        #MyRect {
--          stroke: black;
--          fill: red;
--        }
--     ]]></style>
--   </defs>
--   <rect x="10" height="180" y="10" width="180" id="MyRect"/>

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "200", SA.height "200" ]
            [ Svg.defs []
                [ Svg.style
                    [ SA.id "myRect" ]
                    [ Svg.
                        [ SA.contentStyleType "text/css"
                        , SA.style "fill:red; stroke-width: 3; stroke :green"
                        ]
                        []
                    ]
                ]
            , Svg.rect
                [ SA.x "10"
                , SA.height "180"
                , SA.y "10"
                , SA.width "180"
                , SA.style "url(.myRect)"
                ]
                []
            ]
        ]
