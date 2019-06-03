module Profile exposing (greeting, main)

-- This is a elm version of profile program of dotinstall's  html/css lessons

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main =
    greeting


greeting : Html msg
greeting =
    div [ style "color" "red", style "font-family" "Noto Serif CJK JP", style "margin" "0" ]
        [ Html.header [ style "background-color" "pink" ]
            [ Html.nav []
                [ Html.ul [ style "margin" "0", style "list-style-type" "none", style "padding-left" "0" ]
                    [ Html.a
                        [ attribute "href" "profile.html", style "color" "inherit"]
                        [ Html.li [ style "display" "inline-block", style "padding" "\n                        8px 8px", style "font-size" "12px" ] [ text "HOME" ] ]
                    , Html.a
                        [ attribute "href" "about.html" ]
                        [ Html.li [ style "display" "inline-block", style "padding" "\n                        8px 8px", style "font-size" "12px" ] [ text "ABOUT" ] ]
                    ]
                ]
            , div [ style "margin" "0" ] [ Html.img [ src "header.png", style "width" "100%", style "height" "200", alt "header picture" ] [] ]
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
    [ style "color" "#380"
    , style "height" "90px"
    , style "width" "100%"
    , style "margin" "0"
    ]
