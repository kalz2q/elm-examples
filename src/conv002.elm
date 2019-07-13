module Conv002 exposing (main)

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { input : String
    }


init : Model
init =
    { input = "" }


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newInput ->
            { model | input = newInput }


view : Model -> Html.Html Msg
view model =
    Html.div
        [ HA.style "background-color" "lightpink"
        , HA.style "width" "600px"
        , HA.style "height" "300px"
        , HA.style "margin" "auto"
        , HA.style "textAlign" "center"
        , HA.style "font-size" "32px"
        , HA.style "position" "relative"
        ]
        [ case String.toFloat model.input of
            Just celsius ->
                viewConverter model.input "blue" (String.fromFloat (celsius * 1.8 + 32))

            Nothing ->
                viewConverter model.input "red" "???"
        ]


viewConverter : String -> String -> String -> Html.Html Msg
viewConverter userInput color equivalentTemp =
    Html.span []
        [ Html.input [ HA.value userInput, HE.onInput Change, HA.style "width" "40px" ] []
        , Html.text "°C = "
        , Html.span [ HA.style "color" color ] [ Html.text equivalentTemp ]
        , Html.text "°F"
        ]
