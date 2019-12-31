module Counter001 exposing (main)

-- The original program is elm guide sample
-- exercise : rewrite using "exposing as"
-- exercise : Use Html.Architecture

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    Int


init : Model
init =
    0


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


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-1" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+1" ]
        ]
