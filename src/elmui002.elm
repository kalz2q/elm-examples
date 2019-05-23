module ElmUi002 exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


type alias Model =
    Int


init : Model
init =
    68


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1 

        Decrement ->
          model - 1


tan : Element.Color
tan =
    rgb255 215 175 135


black =
    rgb255 0 0 0

red = rgb255 255 0 0

-- view : Model -> Html Msg
-- view model =
view model =
  Html.div []
    [ Html.button [] [ Html.text "数字をマイナスするよ" ]
    , Html.div [] [ Html.text (String.fromInt model) ]
    , Html.button [  ] [ Html.text "数字をプラスするよ" ]
    , Element.layout [] <|
      text "this is a pen"
    ]

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
