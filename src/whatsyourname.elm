module WhatsYourName exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { input : String
    , answer: String
    }


init : Model
init =
    { input = ""
    , answer = ""
    }



-- UPDATE


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
                , answer = "Hello, " ++ model.input
            }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [style "text-align" "center"] [text "What's your name?"]
        , Html.form [ onSubmit Submit ]
            [ input [ onInput Input, value model.input ] []
            ]
        , text model.answer
        ]

