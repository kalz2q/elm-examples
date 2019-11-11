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
    div
        [ HA.style "color" "red"
        , HA.style "background" "slategray"
        ]
        children


viewSection : String -> List (Html msg) -> Html msg
viewSection heading children =
    section [ HA.style "color" "blue" ]
        (h2 [] [ text heading ] :: children)


view : Model -> Html Msg
view model =
    viewBody
        [ text "hello"
        , viewSection "これから"
            [ text "はじまる"
            ]
        , viewSection "nazeka"
            [ text "wakaranai"
            ]
        ]



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
