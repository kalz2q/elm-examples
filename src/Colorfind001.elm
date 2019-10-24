module ColorFind001 exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Events exposing (..)
import Html


main =
    layout [] <|
        wrappedRow
            [ spacing 20
            , padding 10
            , Background.color lightpink
            ]
            [ row [ width <| px 150, height <| px 150, Background.color lightgoldenrodyellow ] [ text "this1" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgreen ] [ text "that2" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgoldenrodyellow, explain Debug.todo ] [ text "this3" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgreen ] [ text "that4" ]
            , el [ width <| px 100, height <| px 150, spacing <| 20, Background.color lightgoldenrodyellow, explain Debug.todo ] <| text "this5"
            , Element.row [ padding 10, spacing 7, Background.color lightgreen ]
                [ Element.el [] <| text "that6"
                , Element.el [] <| text "tht7"
                , Element.el [] <| text "hat8"
                ]
            , row [ width <| px 150, height <| px 150, Background.color lightgreen ] [ text "that9" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgoldenrodyellow ] [ text "this10" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgreen ] [ text "that9" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgoldenrodyellow ] [ text "this10" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgreen ] [ text "that9" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgoldenrodyellow ] [ text "this10" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgreen ] [ text "that9" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgoldenrodyellow ] [ text "this10" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgreen ] [ text "that9" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgoldenrodyellow ] [ text "this10" ]
            ]


lavender =
    rgb255 230 230 250


lightgoldenrodyellow =
    rgb255 250 250 210


lightgreen =
    rgb255 144 238 144


lightpink =
    rgb255 255 182 193
