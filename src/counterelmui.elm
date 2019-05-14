module Main exposing (main)

import Browser
import Element exposing (centerX, column, el, fill, fillPortion, padding, px, row, spacing, width)
import Element.Background
import Element.Events
import Element.Font
import Html exposing (Html)


type alias Model =
    { count : Int, menu : Bool }


initialModel : Model
initialModel =
    { count = 0, menu = False }


type Msg
    = Increment
    | Decrement
    | OpenMenu
    | CloseMenu


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

        OpenMenu ->
            { model | menu = True }

        CloseMenu ->
            { model | menu = False }


view : Model -> Html Msg
view model =
    Element.layout [ Element.Background.color (Element.rgb255 30 30 30), padding 10 ] <|
        column [ spacing 10, width <| px 200, Element.Background.color (Element.rgb255 200 30 10) ]
            [ el
                [ width fill
                , padding 8
                , Element.Font.center
                , Element.Background.color <|
                    Element.rgb255 120 120 180
                ]
              <|
                Element.text (String.fromInt model.count)
            , el
                [ centerX
                , Element.Events.onClick OpenMenu
                , Element.below <| myMenu model
                ]
              <|
                Element.text "I'm a menu!"
            ]


myMenu model =
    case model.menu of
        False ->
            el [] Element.none

        True ->
            row
                [ width <| px 200
                , Element.centerX
                , Element.Background.color (Element.rgb255 200 200 200)
                ]
                [ el
                    [ width <| fillPortion 1
                    , Element.Background.color <| Element.rgba255 50 100 150 0.4
                    , Element.Font.center
                    , Element.Events.onClick Increment
                    ]
                  <|
                    Element.text "+"
                , el [ width <| fillPortion 2 ] Element.none
                , el
                    [ width <| fillPortion 1
                    , Element.Background.color <| Element.rgba255 150 100 50 0.8
                    , Element.Font.center
                    , Element.Events.onClick Decrement
                    ]
                  <|
                    Element.text "-"
                ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
