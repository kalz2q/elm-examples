module AddText001 exposing (main)

-- Concatenate texts using "++". AddText001
-- rewrite to use AddText button

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
    { content1 : String
    , content2 : String
    }


init : Model
init =
    { content1 = ""
    , content2 = ""
    }


type Msg
    = Change1 String
    | Change2 String
    | AddText


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change1 newContent ->
            { model
                | content1 = newContent
            }

        Change2 newContent ->
            { model
                | content2 = newContent
            }

        AddText ->
            model


viewFormat : List (Html msg) -> Html msg
viewFormat children =
    div
        [ HA.style "background-color" "lemonchiffon"
        , HA.style "color" "crimson"
        , HA.style "width" "600px"
        , HA.style "height" "400px"
        , HA.style "margin" "auto"
        , HA.style "font-size" "32px"
        , HA.style "text-align" "center"
        , HA.style "position" "relative"
        ]
        children


view : Model -> Html Msg
view model =
    viewFormat
        [ p
            []
            [ text "Type texts to add" ]
        , input
            [ HA.style "background" "pink"
            , HA.placeholder "Content 1"
            , HA.value model.content1
            , HA.autofocus True
            , HE.onInput Change1
            ]
            []
        , input
            [ HA.style "background" "pink"
            , HA.placeholder "Content 2"
            , HA.value model.content2
            , HE.onInput Change2
            ]
            []
        , button [ HE.onClick AddText ] [ text "AddText" ]
        , h3 [ HA.style "color" "olive" ] [ text (model.content1 ++ model.content2) ]
        ]
