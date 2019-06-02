module Attribute exposing (..)

-- This is a test site for attributes

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main =
  greeting

greeting : Html msg
greeting =
  div [] [
    Html.img [src "humanblack.png",  width 100] []
    , Html.h1
    [ style "background-color" "red"
    , style "height" "90px"
    , style "width" "100%"
    ]
    [ text "Hello!"
    ]
    , Html.p [] [
      text "This is a pen.  "
      , text  "This is a pen.  "
    ]
  ]