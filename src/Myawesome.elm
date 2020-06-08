module Myawesome exposing (main)

-- this is a kind of translation from dotinstall myawesome application
-- in order to change the application to smart phone format, add following line in the html version
-- <meta name="viewport" content="width=device-width, initial-scale=1">
-- html version is like this elm make src/Myawesome.elm --output=Myawesome.html

import Browser
import Html exposing (..)
import Html.Attributes as HA exposing (name)
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


header : List (Html msg) -> Html msg
header children =
    div [ HA.style "font-size" "30pt" ] children


button : List (Attribute msg) -> List (Html msg) -> Html msg
button attributes children =
    div ([ HA.style "font-size" "40pt" ] ++ attributes) children


view : Model -> Html Msg
view model =
    header
        [ div
            [ HA.style "background" "#a59a55"
            , HA.style "color" "#fff"
            , HA.style "text-align" "center"
            , HA.style "padding-top" "16px"
            ]
            [ div [] [ text "すごいアプリ" ]
            , div [] [ text "ウルトラすごいアプリです" ]
            , button
                [ HA.style "font-weight" "bold"
                ]
                [ text "ダウンロード" ]
            , div [] [ text "لَيْسَ عِنْدِك وِشاح" ]
            ]
        , section [] []
        , footer []
            [ text "Convert latin to arabic"
            , div [] [ text "SabaaH" ]
            , div [] [ text "next test" ]
            , button [] [ text "Show Answer" ]
            , button [] [ text "Delete" ]
            , button [] [ text "Next" ]
            ]
        ]
