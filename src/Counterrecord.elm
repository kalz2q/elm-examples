module Counterrecord exposing (Model, Msg(..), init, main, update, view)

-- rewrite the counter program using a record

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { number : Int }


init : Model
init =
    { number = 0 }



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | number = model.number + 1 }

        Decrement ->
            { model | number = model.number - 1 }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "マイナス!!" ]
        , div [] [ text (String.fromInt model.number) ]
        , button [ onClick Increment ] [ text "プラス!!" ]
        ]
