module Picshare001 exposing (main)
-- programmingElmJeremyFairbank

import Html
import Html.Attributes as HA


main : Html.Html msg
main =
    Html.div []
        [ Html.div
            [ HA.style "background-color" "#aaa"
            , HA.style "padding-bottom" "10px"
            , HA.style "padding-top" "10px"
            , HA.style "text-align" "center"
            ]
            [ Html.h1 [] [ Html.text "Picshare" ] ]
        , Html.div
            [ --  HA.style "margin" "0 auto 60px"
              HA.style "margin" "auto"
              , HA.style "width" "400px"
            ]
            [ Html.div
                [ HA.style "box-shadow" "0 0 10px #ccc"
                , HA.style "background" "#fff"
                ]
                [ Html.img [ HA.src "https://programming-elm.com/1.jpg" ] []
                , Html.div [ HA.style "padding-bottom" "10px" ]
                    [ Html.h2
                        [ HA.style "font-size" "30px"
                        , HA.style "font-weight" "lighter"
                        , HA.style "font-style" "italic"
                        , HA.style "margin" "0 0 10px 0"
                        ]
                        [ Html.text "Surfing" ]
                    ]
                ]
            ]
        ]
