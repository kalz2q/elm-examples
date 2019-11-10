module Viewbody exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE



-- MODEL


type alias Model =
    { int : Int }


init : Model
init =
    Model 0



-- VIEW


viewBody : List (Html msg) -> Html msg
viewBody children =
    div [ HA.style "color" "red" ] children


view : Model -> Html Msg
view model =
    viewBody [ text "hello" ]



-- UPDATE


type Msg
    = Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            model



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
