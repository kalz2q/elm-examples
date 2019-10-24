module Conv002 exposing (main)

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { inputA : String
    , inputB : String
    , inputC : String
    }


init : Model
init =
    { inputA = "", inputB = "", inputC = "" }


type Msg
    = ChangeA String
    | ChangeB String
    | ChangeC String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeA newInput ->
            { model | inputA = newInput }

        ChangeB newInput ->
            { model | inputB = newInput }

        ChangeC newInput ->
            { model | inputC = newInput }


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
        [ case String.toFloat model.inputA of
            Just celsius ->
                viewConverter model.inputA "blue" "black" (String.fromFloat (celsius * 1.8 + 32))

            Nothing ->
                viewConverter model.inputA "red" "red" "???"
        , Html.p [] []
        , case String.toFloat model.inputB of
            Just fahrenheit ->
                viewConverter2 model.inputB "blue" "black" (String.fromFloat ((fahrenheit - 32) / 1.8))

            Nothing ->
                viewConverter2 model.inputB "red" "red" "???"
        , Html.p [] []
        , case String.toFloat model.inputC of
            Just inch ->
                viewConverter3 model.inputC "blue" "black" (String.fromFloat (inch * 2.54))

            Nothing ->
                viewConverter3 model.inputC "red" "red" "???"
        ]


viewConverter : String -> String -> String -> String -> Html.Html Msg
viewConverter userInput color bordercolor equivalentTemp =
    Html.span []
        [ Html.input [ HA.value userInput, HE.onInput ChangeA, HA.style "width" "40px", HA.style "border-color" bordercolor ] []
        , Html.text "°C = "
        , Html.span [ HA.style "color" color ] [ Html.text equivalentTemp ]
        , Html.text "°F"
        ]


viewConverter2 : String -> String -> String -> String -> Html.Html Msg
viewConverter2 userInput color bordercolor equivalentTemp =
    Html.span []
        [ Html.input [ HA.value userInput, HE.onInput ChangeB, HA.style "width" "40px", HA.style "border-color" bordercolor ] []
        , Html.text "°F = "
        , Html.span [ HA.style "color" color ] [ Html.text equivalentTemp ]
        , Html.text "°C"
        ]


viewConverter3 : String -> String -> String -> String -> Html.Html Msg
viewConverter3 userInput color bordercolor equivalentTemp =
    Html.span []
        [ Html.input [ HA.value userInput, HE.onInput ChangeC, HA.style "width" "40px", HA.style "border-color" bordercolor ] []
        , Html.text "inch = "
        , Html.span [ HA.style "color" color ] [ Html.text equivalentTemp ]
        , Html.text "cm"
        ]
