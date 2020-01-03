module ReverseText003 exposing (main)

-- the original is from elm guide
-- rewirte using HA.style => ReverseText002
-- count characters, words, lines => Reversetext003

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


viewFormat : List (Html msg) -> Html msg
viewFormat children =
    div
        [ HA.style "background-color" "lemonchiffon"
        , HA.style "color" "crimson"
        , HA.style "width" "600px"
        , HA.style "height" "400px"
        , HA.style "margin" "auto"
        , HA.style "font-size" "32px"
        , HA.style "text-align" "center"
        , HA.style "position" "relative"
        ]
        children


view : Model -> Html Msg
view model =
    viewFormat
        [ p
            []
            [ text "Type a text to reverse" ]
        , input
            [ HA.style "background" "pink"
            , HA.placeholder "Text to reverse"
            , HA.value model.content
            , HA.autofocus True
            , HE.onInput Change
            ]
            []
        , h3 [ HA.style "color" "olive" ] [ text (String.reverse model.content) ]
        , h5 [ HA.style "color" "darkblue" ]
            [ p [] [ text ("characters :" ++ String.fromInt (String.length model.content)) ]
            , p [] [ text ("words : " ++ String.fromInt (List.length (String.words model.content))) ]
            , p [] [ text ("lines :" ++ String.fromInt (List.length (String.lines model.content))) ]
            ]
        ]
