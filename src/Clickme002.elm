module ClickMe002 exposing (Model, Msg(..), init, main, update, view)

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
    , background : String
    , borderRadius : String
    }


init : Model
init =
    { string = "Click Me!"
    , background = "pink"
    , borderRadius = "0%"
    }


type Msg
    = Click1 | Click2


update : Msg -> Model -> Model
update msg model =
    case msg of
        Click1 ->
            if model.background == "pink" then
                { model
                    | background = "skyblue"
                    , borderRadius = "50%"
                }

            else
                { model
                    | background = "pink"
                    , borderRadius = "0%"
                }

        Click2 ->
            if model.background == "pink" then
                { model
                    | background = "skyblue"
                    , borderRadius = "50%"
                }

            else
                { model
                    | background = "pink"
                    , borderRadius = "0%"
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
            [ HA.style "class" "box"
            , HA.style "width" "200px"
            , HA.style "height" "200px"
            , HA.style "margin" "60px auto"
            , HA.style "position" "relative"
            , HA.style "cursor" "pointer"
            , HA.style "background" model.background
            , HA.style "borderRadius" model.borderRadius

            -- , HA.style "transform" "rotate(180deg)"
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
            ,
            div
            [ HA.style "class" "box"
            , HA.style "width" "200px"
            , HA.style "height" "200px"
            , HA.style "margin" "60px auto"
            , HA.style "position" "relative"
            , HA.style "cursor" "pointer"
            , HA.style "background" model.background
            , HA.style "borderRadius" model.borderRadius

            -- , HA.style "transform" "rotate(180deg)"
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
