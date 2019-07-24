module Picshare003 exposing (main)

-- success in Santa Claus in Picshare002
-- project is browser

import Html
import Html.Attributes as HA


initialModel : { url : String, caption : String }
initialModel =
    { url = "https://drive.google.com/uc?id=1NyeKCX2Hh0iioPYQs7JsJ8e_okLC4L5Y"
    , caption = "Santa Clause"
    }


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
            , HA.style "width" "400px"
            ]
            [ viewDetailedPhoto initialModel.url initialModel.caption
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
            , HA.style "width" "400px"
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
