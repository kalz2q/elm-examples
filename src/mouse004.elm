module Mouse004 exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (..)


main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }



-- MODEL


type alias Model msg =
    { mouseEnter : Bool
    , mouseLeave : Bool
    , bgcolor : Html.Attribute msg
    }


initialModel : Model msg
initialModel =
    Model False False (style "background-color" "yellow")


type Msg
    = MouseEnter
    | MouseLeave


update : Msg -> Model msg -> Model msg
update msg model =
    case msg of
        MouseEnter ->
            { model | bgcolor = style "background-color" "red" }

        MouseLeave ->
            { model | bgcolor = style "background-color" "slategray" }


view : Model Msg -> Html Msg
view model =
    div
        [ style "width" "600px"
        , style "height" "400px"
        , style "margin" "auto"
        , onMouseEnter MouseEnter
        , onMouseLeave MouseLeave
        , model.bgcolor
        ]
        [ div
            [-- onMouseEnter MouseEnter
             -- , onMouseLeave MouseLeave
            ]
            [ text "This is layer 2... Hover over me!" ]
        ]
