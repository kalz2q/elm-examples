module Portfolio exposing (greeting, main)

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
        [ Html.header
            [ style "text-align" "right"
            , style "padding" "20"
            , style "background-image" "url(header002.png)"
            , style "height" "240px"
            , style "background-size" "cover"
            , style "background-position" "50% 50%"
            , style "margin-bottom" "60px"
            ]
            [ Html.nav []
                [ Html.ul
                    [ style "margin" "0"
                    , style "list-style-type" "none"
                    , style "padding-left" "0"
                    ]
                    [ Html.a
                        [ attribute "href" "profile.html"

                        -- , style "color" "inherit"
                        ]
                        [ Html.li
                            [ style "display" "inline-block"
                            , style "padding" "8px 8px"
                            ]
                            [ text "HOME" ]
                        ]
                    , Html.a
                        [ attribute "href" "about.html" ]
                        [ Html.li [ style "display" "inline-block", style "padding" "8px 8px" ] [ text "ABOUT" ] ]
                    ]
                ]

            -- , div [ style "margin" "0" ] [ Html.img [ src "header.png", style "width" "100%", style "height" "200", alt "header picture" ] [] ]
            ]
        , Html.section [ style "text-align" "center" ]
            [ Html.img
                [ src "taro002.png"
                , width 200
                , height 200
                , alt "taro's icon"
                , style "border-radius" "50%"
                , style "border" "pink solid 10px"
                , style "box-shadow" "0px 0px 20px red"
                ]
                []
            , Html.h1
                h1style
                [ text "Hello!"
                ]
            , Html.p
                [ style "margin" "60px auto"
                , style "width" "400px"
                , style "text-align" "left"
                , style "border-bottom" "3px solid gray"
                ]
                [ Html.h2 [] [ text "this is a pen. " ]
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                ]
            ]
        , Html.footer
            [ style "border-top" "3px solid red"
            , style "width" "400px"
            , style "margin" "0px auto 60px"
            ]
            [ Html.ul
                [ style "list-style-type" "none"
                , style "padding-left" "0px"
                , style "float" "left"
                ]
                [ Html.a [ attribute "href" "mailto:xxxx@gmail.com" ]
                    [ Html.li [ style "display" "inline-block" ] [ Html.img [ src "mail.png", width 40, alt "メール送信" ] [] ] ]
                , Html.a [ attribute "href" "https://dotinstall.com", attribute "target" "_blank" ]
                    [ Html.li [ style "display" "inline-block" ] [ Html.img [ src "blog.png", width 40, alt "ブログサイトへ" ] [] ] ]
                , Html.a [ attribute "href" "https://dotinstall.com", attribute "target" "_blank" ]
                    [ Html.li [ style "display" "inline-block" ] [ Html.img [ src "photos.png", width 40, alt "写真サイトへ" ] [] ] ]
                ]
            , Html.p
                [ style "color" "gray"
                , style "font-size" "20px"
                , style "text-align" "right"
                ]
                [ text ("©" ++ "TaroCatty") ]
            ]
        ]


h1style =
    [ style "color" "#380"
    , style "height" "90px"
    , style "width" "100%"
    , style "margin" "0"
    ]
