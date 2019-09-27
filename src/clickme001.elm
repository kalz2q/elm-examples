module ClickMe001 exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { string : String
    , background1 : String
    , background2 : String
    , borderRadius1 : String
    , borderRadius2 : String
    }


init : Model
init =
    { string = "Click Me!"
    , background1 = "pink"
    , background2 = "pink"
    , borderRadius1 = "0%"
    , borderRadius2 = "0%"
    }


type Msg
    = Click1
    | Click2


update : Msg -> Model -> Model
update msg model =
    case msg of
        Click1 ->
            if model.background1 == "pink" then
                { model
                    | background1 = "skyblue"
                    , borderRadius1 = "50%"
                }

            else
                { model
                    | background1 = "pink"
                    , borderRadius1 = "0%"
                }

        Click2 ->
            if model.background2 == "pink" then
                { model
                    | background2 = "skyblue"
                    , borderRadius2 = "50%"
                }

            else
                { model
                    | background2 = "pink"
                    , borderRadius2 = "0%"
                }


view : Model -> Html.Html Msg
view model =
    div
        [ HA.style "display" "flex"
        , HA.style "flex-wrap" "wrap"
        , HA.style "width" "600px"
        , HA.style "margin" "auto"
        ]
        [ div
            [ HA.style "id" "box1"
            , HA.style "width" "200px"
            , HA.style "height" "200px"
            , HA.style "margin" "60px auto"
            , HA.style "position" "relative"
            , HA.style "cursor" "pointer"
            , HA.style "background" model.background1
            , HA.style "borderRadius" model.borderRadius1
            , HA.style "transition" "0.8s"
            , HE.onClick Click1
            ]
            [ div
                [ HA.style "position" "absolute"
                , HA.style "top" "50%"
                , HA.style "left" "50%"
                , HA.style "transition" "0.8s"
                , HA.style "transform" "translate(-50%, -50%)"
                ]
                [ text model.string ]
            ]
        , div
            [ HA.style "id" "box"
            , HA.style "width" "200px"
            , HA.style "height" "200px"
            , HA.style "margin" "60px auto"
            , HA.style "position" "relative"
            , HA.style "cursor" "pointer"
            , HA.style "background" model.background2
            , HA.style "borderRadius" model.borderRadius2
            , HA.style "transition" "0.8s"
            , HE.onClick Click2
            ]
            [ div
                [ HA.style "position" "absolute"
                , HA.style "top" "50%"
                , HA.style "left" "50%"
                , HA.style "transition" "0.8s"
                , HA.style "transform" "translate(-50%, -50%)"
                ]
                [ text model.string ]
            ]
        ]
