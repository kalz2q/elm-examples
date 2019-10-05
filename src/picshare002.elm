module Picshare002 exposing (main)

import Html
import Html.Attributes as HA


main : Html.Html msg
main =
    Html.div []
        [ Html.div
            [ HA.class "header"
            , HA.style "background-color" "#aaa"
            , HA.style "padding-bottom" "10px"
            , HA.style "padding-top" "10px"
            , HA.style "text-align" "center"
            ]
            [ Html.h1 [] [ Html.text "Picshare" ] ]
        , Html.div
            [ --  HA.style "margin" "0 auto 60px"
              HA.style "margin" "auto"
            , HA.style "width" "300px"
            ]
            [ viewDetailedPhoto (baseUrl ++ "1.jpg") "Surfing"
            , viewDetailedPhoto (baseUrl ++ "2.jpg") "The Fox"
            , viewDetailedPhoto (baseUrl ++ "3.jpg") "Evening"
            , viewDetailedPhoto ("https://drive.google.com/uc?id=1NyeKCX2Hh0iioPYQs7JsJ8e_okLC4L5Y") "santaclause"
            ]
        ]


viewDetailedPhoto : String -> String -> Html.Html msg
viewDetailedPhoto url caption =
    Html.div
        [ HA.class "detailed-photo"
        , HA.style "box-shadow" "0 0 10px #555"
        , HA.style "background" "yellow"
        ]
        [ Html.img
            [ HA.src url
            , HA.style "width" "200px"
            , HA.style "margin-top" "10px"
            ]
            []
        , Html.div
            [ HA.class "photo-info"
            , HA.style "padding-bottom" "10px"
            ]
            [ Html.h2
                [ HA.class "caption"
                , HA.style "font-size" "30px"
                , HA.style "font-weight" "lighter"
                , HA.style "font-style" "italic"
                , HA.style "margin" "0 0 10px 0"
                ]
                [ Html.text caption ]
            ]
        ]


baseUrl : String
baseUrl =
    "https://programming-elm.com/"
