module HolyG001 exposing (main)

import Element exposing (..)


main =
    layout [] <|
        column [ width fill, height fill, explain  Debug.todo ]
            [ row [ width fill, height <| px 100 ] [ text "header" ]
            , row [ width fill, height fill, explain Debug.todo ]
                [ column [ width <| px 100, height fill ] [ text "nav" ]
                , column [ width fill, height fill ] [ text "main" ]
                , column [ width <| px 100, height fill ] [ text "ad" ]
                ]
            , row [ width fill, height <| px 100 ] [ text "footer" ]
            ]
