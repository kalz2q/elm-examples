module CounterElmUi exposing (Model, Msg(..), init, main, update, view)

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
    { count = 38 }


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


lightgreen : Element.Color
lightgreen =
    rgb255 118 255 118


view : Model -> Html Msg
view model =
    Element.layout [ padding 10, Background.color lightgreen ] <|
        column [ spacing 10, width <| px 200, centerX ]
            [ el
                [ Element.Events.onClick Increment
                ]
              <|
                Element.text "増"
            , el
                []
              <|
                Element.text (String.fromInt model.count)
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
