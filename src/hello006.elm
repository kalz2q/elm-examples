module Hello005 exposing (main)


import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


main =
  layout [] 
    (el [centerX, centerY] (text "Cats, the Gathering"))
  