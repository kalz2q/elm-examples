module Paragraph001 exposing (main)

import Html
import Html.Attributes as HA


main =
    Html.div
        [ HA.style "background-color" "yellow"
        , HA.style "width" "600px"
        -- , HA.style "height" "400px"
        , HA.style "margin" "auto"
        , HA.style "position" "relative"
        ]
        [ Html.p
            [ HA.style "margin" "50px auto"
            , HA.style "width" "400px"
            , HA.style "background-color" "lightgreen"
            , HA.style "text-align" "left"
            ]
            [ Html.h2 [] [ Html.text "Hello, world!" ]
            , Html.text "This is a pen. "
            , Html.text "This is not a pen. "
            , Html.text "This is a ball. "
            , Html.text "This is a pen. "
            , Html.text "This is not a pen. "
            , Html.text "This is a ball. "
            , Html.text "This is a pen. "
            , Html.text "This is not a pen. "
            , Html.text "This is a ball. "
            , Html.text "This is a pen. "
            , Html.text "This is not a pen. "
            , Html.text "This is a ball. "
            , Html.text "This is a pen. "
            , Html.text "This is not a pen. "
            , Html.text "This is a ball. "
            , Html.text "This is a pen. "
            , Html.text "This is not a pen. "
            , Html.text "This is a ball. "
            , Html.h2 [] [ Html.text "今日はいい天気です" ]
            , Html.text "今日はいい天気です. "
            , Html.text "This is not a pen. "
            , Html.text "今日はいい天気です. "
            , Html.text "This is not a pen. "
            , Html.text "今日はいい天気です. "
            , Html.text "This is not a pen. "
            , Html.text "今日はいい天気です. "
            , Html.text "This is not a pen. "
            , Html.text "今日はいい天気です. "
            , Html.text "This is not a pen. "
            , Html.text "今日はいい天気です. "
            , Html.text "This is not a pen. "
            , Html.text "今日はいい天気です. "
            , Html.text "This is not a pen. "
            ]
        ]
