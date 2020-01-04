module Texttolist001 exposing (main)

-- enter items and make a list

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
    { input : String
    , memos : List String
    }


init : Model
init =
    { input = ""
    , memos = []
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
                , memos = model.input :: model.memos
            }


view : Model -> Html Msg
view model =
    viewFormat
        [ form [ HE.onSubmit Submit ]
            [ input
                [ HE.onInput Input
                , HA.value model.input
                , HA.autofocus True
                ]
                []
            , button
                [ HA.disabled (String.isEmpty (String.trim model.input)) ]
                [ text "Submit" ]
            ]
        , ul [ HA.style "text-align" "left" ] (List.map viewMemo model.memos)
        ]


viewMemo : String -> Html Msg
viewMemo memo =
    li [] [ text memo ]


viewFormat : List (Html msg) -> Html msg
viewFormat children =
    div
        [ HA.style "background-color" "lemonchiffon"
        , HA.style "color" "crimson"
        , HA.style "width" "600px"
        , HA.style "height" "400px"
        , HA.style "margin" "auto"
        , HA.style "text-align" "center"
        ]
        children
