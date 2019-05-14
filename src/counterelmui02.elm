module CounterElmUi exposing (Model, Msg(..), black, init, main, tan, update, view)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


type alias Model =
    { count : Int }


init : Model
init =
    { count = 68 }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


tan : Element.Color
tan =
    rgb255 215 175 135


black =
    rgb255 0 0 0

red = rgb255 255 0 0

view : Model -> Html Msg
view model =
    Element.layout [ padding 10, Background.color tan ] <|
        column [ spacing 10, width <| px 200, centerX ]
            [ el
                [ Element.Events.onClick Increment
                ]
              <|
                Element.text "増"
            , el
                [Font.color red]
              <|
                Element.text (String.fromInt model.count ++ "歳")
            , el
                [ Element.Events.onClick Decrement
                ]
              <|
                Element.text "減"
            ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
