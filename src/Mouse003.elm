module MouseOver exposing (main)

-- I am studyign https://ellie-app.com/qPWtPP4f9fa1 wghichi is written in with an older version of the elm compiler

import Browser
import Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (..)



-- MAIN


main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { mouseEnter : Bool
    , mouseLeave : Bool
    }


initialModel : Model
initialModel =
    Model False False


type Msg
    = MouseEnter
    | MouseLeave


update : Msg -> Model -> Model
update msg model =
    case msg of
        MouseEnter ->
            { model
                | mouseEnter = True
                , mouseLeave = False
            }

        MouseLeave ->
            { model
                | mouseEnter = False
                , mouseLeave = True
            }


view : Model -> Html Msg
view model =
    div []
        [ div
            [ style "background" "red"
            , style "padding" "20px"
            , onMouseEnter MouseEnter
            , onMouseLeave MouseLeave
            ]
            [ text "This is layer 2... Hover over me!" ]
          ,  div [] [text (Debug.toString model)]
        ]
