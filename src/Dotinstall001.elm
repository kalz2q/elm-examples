module Dotinstall001 exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Svg
import Svg.Attributes as SA


type alias Model =
    { int : Int }


init : Model
init =
    Model 0


view : Model -> Html Msg
view model =
    div []
        [ pinkheart
        , h1 [] [ text "ドットインストール" ]
        , p [] [ text "プログラミング学習サービス" ]
        ]



-- UPDATE


type Msg
    = Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            model



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


pinkheart =
    Svg.svg
        [ SA.width "600"
        , SA.height "50"
        , SA.viewBox "0 0 10 10"

        -- , SA.viewBox "0 0 28 28"
        ]
        [ Svg.path
            [ SA.d "M14 26c-0.25 0-0.5-0.094-0.688-0.281l-9.75-9.406c-0.125-0.109-3.563-3.25-3.563-7 0-4.578 2.797-7.313 7.469-7.313 2.734 0 5.297 2.156 6.531 3.375 1.234-1.219 3.797-3.375 6.531-3.375 4.672 0 7.469 2.734 7.469 7.313 0 3.75-3.437 6.891-3.578 7.031l-9.734 9.375c-0.187 0.187-0.438 0.281-0.688 0.281z"
            , SA.fill "pink"
            ]
            []
        ]
