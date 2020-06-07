module Myawesome exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Random


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    String


init : () -> ( Model, Cmd Msg )
init _ =
    ( ""
    , Cmd.none
    )


type Msg
    = NoMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        _ ->
            ( "next string", Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ header []
            [ h1 [] [ text "すごいアプリ" ]
            , p [] [ text "ウルトラすごいアプリです" ]
            , a [] [ text "ダウンロード" ]
            ]
        , section [] []
        , footer []
            [ text "Convert latin to arabic"
            , p [] [ text "SabaaH" ]
            , button [] [ text "Show Answer" ]
            , button [] [ text "Delete" ]
            , button [] [ text "Next" ]
            ]
        ]
