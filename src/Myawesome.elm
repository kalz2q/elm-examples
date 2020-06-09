module Myawesome exposing (main)

-- this is a kind of translation from dotinstall myawesome application
-- in order to change the application to smart phone format, add following line in the html version
-- html version is like this elm make src/Myawesome.elm --output=Myawesome.html
-- <meta name="viewport" content="width=device-width, initial-scale=1">
-- HA.class "btn"
-- .btn:hover {
-- opacity: 0.5;
-- }

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


button : List (Attribute msg) -> List (Html msg) -> Html msg
button attributes children =
    div
        ([ HA.class "btn"
         , HA.style "font-size" "16px"
         , HA.style "background" "#fff"
         , HA.style "color" "#f59a00"
         , HA.style "display" "block"
         , HA.style "width" "140px"
         , HA.style "line-height" "44px"
         , HA.style "margin" "40px auto 48px"
         , HA.style "font-weight" "bold"
         , HA.style "border-radius" "10px"
         ]
            ++ attributes
        )
        children


body : List (Attribute msg) -> List (Html msg) -> Html msg
body attributes children =
    div
        ([ HA.style "font-size" "20pt"
         , HA.style "margin" "0"
         , HA.style "font-family" "Verdana, sans-serif"
         , HA.style "color" "#333"
         ]
            ++ attributes
        )
        children


header : List (Attribute msg) -> List (Html msg) -> Html msg
header attributes children =
    div
        ([ HA.style "background" "#a59a55"
         , HA.style "color" "#fff"
         , HA.style "text-align" "center"
         , HA.style "padding-top" "16px"
         ]
            ++ attributes
        )
        children


view : Model -> Html Msg
view model =
    body []
        [ header
            []
            [ div [ HA.style "font-size" "200%", HA.style "font-weight" "bold" ] [ text "すごいアプリ" ]
            , p [ HA.style "margin" "0" ] [ text "ウルトラすごいアプリです" ]
            , button
                []
                [ text "ダウンロード" ]
            , div [ HA.class "btn" ] [ text "لَيْسَ عِنْدِك وِشاح" ]
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
