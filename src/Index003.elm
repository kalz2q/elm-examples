module Index003 exposing (main)

import Html exposing (a, div, h1, h2, li , a , p, text, ul)
import Html.Attributes as Ha


main =
    div
        [ Ha.style "font-family" "Noto Serif CJK JP"
        , Ha.style "width" "600px"
        , Ha.style "background-color" "lightpink"
        , Ha.style "margin" "auto"
        ]
        [ h1 [ Ha.style "text-align" "center" ]
            [ text "Links to Examples"
            ]
        , h2 [ Ha.style "text-align" "left" ]
            [ p [] [ text "I am learning Elm 0.19." ]
            , p [] [ text "Source files are available at" ]
            , a
                [ Ha.attribute "href" "https://github.com/kalz2q/elm-examples"
                ]
                [ text "https://github.com/kalz2q/elm-examples" ]
            , p [] [ text "コピペしたり試行錯誤してElmで作りました。" ]
            ]
        , ul []
            [ li [] [a [ Ha.attribute "href" "random001.html" ]
                [ text "random001.html => random number 発生機"
                ]]
            , li [] [ a 
                [ Ha.attribute "href" "textalignleft.html"
                ]
                [ text "textalignleft.html => Elmでごく普通に左寄せの文章を書く実験。英語と日本語。"
                ]]
            , li [] [ a 
                [ Ha.attribute "href" "time002.html"
                ]
                [ text "time002.html => デジタル時計"
                ]]
            , li [] [ a 
                [ Ha.attribute "href" "holyg002.html"
                ]
                [ text "holyg002.html => 色付き聖杯"
                ]]
            , li [] [ a 
                [ Ha.attribute "href" "hello006.html"
                ]
                [ text "hello006.html => 色付きハローワールドセンタリング"
                ]]
            , li [] [ a 
                [ Ha.attribute "href" "bluebox002.html"
                ]
                [ text "bluebox002.html => 青の研究"
                ]]
            , li [] [ a 
                [ Ha.attribute "href" "bluebox001.html"
                ]
                [ text "bluebox001.html => 青い正方形を上下センタリング"
                ]]
            , li [] [ a 
                [ Ha.attribute "href" "hello001.html"
                ]
                [ text "hello001.html => 一番簡単な hello world"
                ]]
            ]
        ]
