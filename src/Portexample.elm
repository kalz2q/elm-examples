port module Main exposing (main)

-- // cf. elmprogramming.com

import Browser
import Html exposing (..)
import Html.Events exposing (..)


type alias Model =
    String


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick SendDataToJS ]
            [ text "Click to Send Data to JavaScript"
            , br [] []
            , text "See the Result in Cosole"
            ]
        ]


type Msg
    = SendDataToJS


port sendData : String -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendDataToJS ->
            ( model, sendData "Hello JavaScript!" )


init : () -> ( Model, Cmd Msg )
init _ =
    ( "", Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
