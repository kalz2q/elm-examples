module Hello002 exposing (main)

-- write hello world using browser.sandbox => Hello002

import Browser
import Html exposing (..)
import Html.Attributes as HA


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    String



-- Let's initial model to be "hello world"


init : Model
init =
    "hello, world!"



-- Because there is no interaction on the browser, there is no msg


type Msg
    = NoMsg



-- update is not used but sandbox template need it and it must conform to the type signature


update : Msg -> Model -> Model
update msg model =
    case msg of
        _ ->
            "some other string"



-- in this view model is shown but it is really defined by init


viewFormat : List (Html msg) -> Html msg
viewFormat children =
    div [ HA.style "background-color" "yellow" ] children


view : Model -> Html Msg
view model =
    viewFormat
        [ h2 [] [ text model ]
        , text "this is a pen."
        ]



-- layout []
-- -- (text "hello world")
-- -- (el [] (text "hello world"))
-- <|
--     text "hello woorld"
-- Element.paragraph []
--     [ text "lots of text ...."
--     , el [ Font.bold ] (text "this is bold")
--     , text "lots of text ...."
--     ]
