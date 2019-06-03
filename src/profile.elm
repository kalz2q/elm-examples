module Profile exposing (greeting, main)

-- This is a elm version of profile program of dotinstall's  html lessons

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main =
    greeting


greeting : Html msg
greeting =
    div []
        [ Html.header []
            [ Html.nav []
                [ Html.ul []
                    [ Html.a
                        [ attribute "href" "profile.html" ]
                        [ Html.li [] [ text "HOME" ] ]
                    , Html.a
                        [ attribute "href" "about.html" ]
                        [ Html.li [] [ text "ABOUT" ] ]
                    ]
                ]
            , div [] [ Html.img [ src "header.png", style "width" "100%", style "height" "200px", alt "header picture" ] [] ]
            ]
        , Html.img [ src "taro002.png", width 360, alt "taro's icon" ] []
        , Html.section []
            [ Html.h1
                h1style
                [ text "Hello!"
                ]
            , Html.p []
                [ text "This is a pen.  "
                , text "This is a pen.  "
                ]
            ]
        , Html.footer []
            [ Html.ul []
                [ Html.a [ attribute "href" "mailto:xxxx@gmail.com" ]
                    [ Html.li [] [ Html.img [ src "mail.png", width 40, alt "メール送信" ] [] ] ]
                , Html.a [ attribute "href" "https://dotinstall.com", attribute "target" "_blank" ]
                    [ Html.li [] [ Html.img [ src "blog.png", width 40, alt "ブログサイトへ" ] [] ] ]
                , Html.a [ attribute "href" "https://dotinstall.com", attribute "target" "_blank" ]
                    [ Html.li [] [ Html.img [ src "photos.png", width 40, alt "写真サイトへ" ] [] ] ]
                ]
            , Html.p [] [ text ("©" ++ "TaroCatty") ]
            ]
        ]


h1style =
    [ style "color" "red"
    , style "height" "90px"
    , style "width" "100%"
    ]
