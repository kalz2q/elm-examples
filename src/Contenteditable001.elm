module Main exposing (main)

-- https://qiita.com/maron8676/items/5a4d2750400a38b600dd

import Browser
import Html exposing (Html, div, label, text)
import Html.Attributes exposing (contenteditable, value)
import Html.Events exposing (keyCode, on, preventDefaultOn)
import Json.Decode as JD


main : Platform.Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { text : String
    }


type Msg
    = UpdateText String
    | NoOp


init =
    Model "init"


view : Model -> Html Msg
view model =
    div []
        [ div
            [ contenteditable True
            , preventDefaultOn "keydown"
                (JD.map (\x -> ( NoOp, isEnterCode x )) <| keyCode)
            , on "blur" <|
                JD.map UpdateText
                    (JD.at [ "target", "textContent" ] JD.string)
            ]
            [ text model.text ]
        , label [] [ text <| "edited: " ++ model.text ]
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateText newText ->
            { model | text = newText }

        NoOp ->
            model


isEnterCode : Int -> Bool
isEnterCode code =
    let
        enterCode =
            13
    in
    code == enterCode