module Avh4color001 exposing (main)

import Color exposing (Color)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes exposing (style)


main =
    layout [] <|
        -- view : Color -> Html msg
        -- view foreground =
        --     let
        --         hue =
        --             (Color.toHsla foreground).hue
        --         borderColor =
        --             Color.hsla hue 0.75 0.5 0.8
        --     in
        el [centerX, centerY, Background.color Color.green, Font.color Color.white]
        <|
            --     style "background-color" (Color.toCssString Color.lightOrange)
            -- , style "color" (Color.toCssString foreground)
            -- , style "border-color" (Color.toCssString borderColor)
            text "(ᵔᴥᵔ)"
