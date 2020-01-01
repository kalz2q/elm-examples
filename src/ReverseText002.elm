module ReverseText002 exposing (main)

-- the original is from elm guide
-- rewirte using HA.style => ReverseText002

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }


view : Model -> Html Msg
view model =
    Html.div
        [ HA.style "background-color" "lemonchiffon"
        , HA.style "width" "600px"
        , HA.style "height" "200px"
        , HA.style "margin" "auto"
        , HA.style "textAlign" "center"
        , HA.style "font-size" "32px"
        , HA.style "position" "relative"
        ]
        [ p
            [ HA.style "textAlign" "center"
            ]
            [ text "Type a text to reverse" ]
        , input
            [ HA.style "background" "pink"
            , HA.placeholder "Text to reverse"
            , HA.value model.content
            , HE.onInput Change
            ]
            []
        , div [] [ Html.text (String.reverse model.content) ]
        ]
