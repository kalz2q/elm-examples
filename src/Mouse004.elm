module Mouse004 exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


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
    | MouseOut


update : Msg -> Model msg -> Model msg
update msg model =
    case msg of
        MouseEnter ->
            { model | bgcolor = style "background-color" "red" }

        MouseOut ->
            { model | bgcolor = style "background-color" "slategray" }


view : Model Msg -> Html Msg
view model =
    div
        [ style "width" "600px"
        , style "height" "400px"
        , style "margin" "auto"
        , style "cursor" "pointer"
        , onMouseEnter MouseEnter
        , onMouseOut MouseOut
        , model.bgcolor
        ]
        [ div
            [
            ]
            [ text "Hover over me!" ]
        ]
