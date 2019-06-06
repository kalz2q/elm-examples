module Hover exposing (Model, Msg(..), init, main, update, view)

--

import Browser
import Html exposing (..)
import Html.Events exposing (onClick, onMouseOver)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { number : Int
    , backgroundcolor : String
    }


init : Model
init = { 
    number = 68
    , backgroundcolor = "red"
     }



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Change


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model.number + 1

        Decrement ->
            model.number  - 1

        Change ->
            model.backgroundcolor "blue"



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button
            [ onClick Decrement
            , onMouseOver Change
            ]
            [ text "数字をマイナスするよ" ]

        -- , div [] [ text (String.fromInt model) ]
        -- , button [ onClick Increment ] [ text "数字をプラスするよ" ]
        ]
