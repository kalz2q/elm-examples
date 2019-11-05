module Elmbase exposing (main)

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


type Msg
    = Reset



-- VIEW


view : Model -> Html Msg
view model =
    div [] []


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
