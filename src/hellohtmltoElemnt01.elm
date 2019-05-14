module HelloworldElmUi exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


main =
    layout [] <|
        column [centerX]
          [html (Html.h1 [] [Html.text "hello world"])
          , text "what is this"
          ,text "wow!"
          , paragraph [] [text "this is a pen."
          , text "日本語はどうか"
          ]
          ]