module Dotinstall004 exposing (main)

-- listを表現する => Dotinstall003.elm
-- table を作る => Dotinstall004.elm
--
-- ellie-app.comで使うstyleをどうコメントで書くか
--
--

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { int : Int }


init : Model
init =
    Model 0


type Msg
    = Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            model


view : Model -> Html Msg
view model =
    div
        [ HA.style "width" "600px"
        , HA.style "margin" "auto"
        ]
        [ pinkheart
        , table []
            [ thead [] [ text "年" ]
            , thead [] [ text "出来事" ]
            , td []
                [ text "2015"
                , text "会社設立"
                ]
            , td [] [ text "2019" ]
            , td [] [ text "サイト" ]
            ]
        ]


pinkheart =
    Svg.svg
        [ SA.width "600"
        , SA.height "50"
        , SA.style "background:#38a"
        , SA.viewBox "0 0 28 10"
        ]
        [ Svg.path
            [ SA.d "M14 26c-0.25 0-0.5-0.094-0.688-0.281l-9.75-9.406c-0.125-0.109-3.563-3.25-3.563-7 0-4.578 2.797-7.313 7.469-7.313 2.734 0 5.297 2.156 6.531 3.375 1.234-1.219 3.797-3.375 6.531-3.375 4.672 0 7.469 2.734 7.469 7.313 0 3.75-3.437 6.891-3.578 7.031l-9.734 9.375c-0.187 0.187-0.438 0.281-0.688 0.281z"
            , SA.fill "pink"
            ]
            []
        ]


swedishflag =
    Svg.svg
        [ SA.width "160"
        , SA.height "100"
        , SA.viewBox "0 0 320 200"
        ]
        [ Svg.rect
            [ SA.style "opacity:1;fill:#005aad;fill-opacity:0.96862745;fill-rule:evenodd;stroke:none;stroke-width:5;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;paint-order:fill markers stroke"
            , SA.width "320"
            , SA.height "200"
            ]
            []
        , Svg.path
            [ SA.d "M 100 0 L 100 80 L 0 80 L 0 120 L 100 120 L 100 200 L 140 200 L 140 120 L 320 120 L 320 80 L 140 80 L 140 0 L 100 0 z "
            , SA.style "opacity:1;fill:#ffc200;fill-opacity:0.96862745;fill-rule:evenodd;stroke:none;stroke-width:5;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;paint-order:fill markers stroke"
            ]
            []
        ]
