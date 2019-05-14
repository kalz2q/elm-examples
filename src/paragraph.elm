module Paragraph exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)

-- paragraphを使ってみる
-- paragraphでは文字列がつながってしまう。それはそれで使いみちがあるのだろうが、
-- columnとrowの方が便利そう



main =
    layout []
    -- <| Element.paragraph [width (px 400), height (px 400), Background.color (rgb255 200 180 170), centerX]
    --     [ text "lots of text ...."
    --     , el [ Font.bold ] (text "this is bold")
    --     , text "lots of text ...."
    --     ]
    <|
        column [ width (px 400), height (px 400), Background.color (rgb255 200 180 170), centerX ]
            [ text "lots of text ...."
            , el [ Font.bold ] (text "this is bold")
            , text "lots of text ...."
            ]
