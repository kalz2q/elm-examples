module HelloName001 exposing (main)

import Browser
import Html
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
    { input : String
    , output : String
    }


init : Model
init =
    { input = ""
    , output = ""
    }


type Msg
    = Input String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model | input = input }

        Submit ->
            { model
                | input = ""
                -- , output = "Hello, " ++ model.input ++ "!!!"
                , output = shoutHello model.input
            }



-- VIEW


view : Model -> Html.Html Msg
view model =
    Html.div
        [ HA.style "width" "600px"
        , HA.style "background-color" "aliceblue"
        , HA.style "margin" "auto"
        , HA.style "textAlign" "center"
        ]
        [ Html.h3 [] [ Html.text "What's your name? " ]
        , Html.form
            [ HE.onSubmit Submit
            ]
            [ Html.input
                [ HE.onInput Input
                , HA.value model.input
                ]
                []
            , Html.button
                [ HA.disabled (String.isEmpty (String.trim model.input))
                , HA.hidden True
                ]
                [ Html.text "Submit" ]
            ]
        , Html.h3 [] [ Html.text model.output ]
        ]

shoutHello name = "HELLO, " ++ (String.toUpper name) ++ "!!!"