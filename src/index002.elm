module MyElmProjects exposing (main)

import Html exposing (Html,a, h1, li, ul, p, div)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input

main : Html msg
main =
   layout [Font.family [Font.typeface "Noto Serif CJK JP"]] <|
     column [width (px 400), height (px 400), Background.color (rgb255 200 180 170), centerX] 
       [ el [Font.size 40, Font.bold] <| text "Links to Examples"
       , el [] <|text "I am learning Elm 0.19." 
       , el [] <| text "All the elm source files are availabel at "
       , link [] {
           url="https://github.com/kalz2q/elm-projects"
           , label=text "https://github.com/kalz2q/elm-projects"
        }
        , p [ style "font-size" "30px", style "font-family" "Noto Serif CJK JP", label=text "コピペしたり試行錯誤してElmから作ったもののリストです。" ]
        , ul []
            [ li [] [ a [ url="src/helloworldattribute.html", label=texttext "attribute付きハローワールド" ] ]
            , li [] [ a [ url="src/helloworlddiv.html", label=text "div付きハローワールド" ] ]
            , li [] [ a [ url="src/helloworldtype.html", label=text "型付きハローワールド" ] ]
            , li [] [ a [ url="src/helloworld01.html", label=text "一番簡単なElmによるハローワールド" ] ]
            , li [] [ a [ url="src/helloworldcss.html", label=text "cssの組み込み実験" ] ]
            , li [] [ a [ url="src/httpgutenberg.html", label=text "httpグーテンベルグ" ] ]
            , li [] [ a [ url="src/jsoncats.html", label=text "jsonによる猫動画" ] ]
            , li [] [ a [ url="src/randomnumber.html", label=text "randomサイコロ" ] ]
            , li [] [ a [ url="src/timenow.html", label=text "time今何時?" ] ]
            , li [] [ a [ url="src/maybetemperature.html", label=text "Maybe華氏何度?" ] ]
            , li [] [ a [ url="src/passwordmatch.html", label=text "パスワードマッチ" ] ]
            , li [] [ a [ url="src/fieldtoreverse.html", label=text "テキストフィールドのサンプル" ] ]
            , li [] [ a [ url="src/httpgetrepository.html", label=text "Httpのサンプル" ] ]
            , li [] [ a [ url="src/textformlist.html", label=text "Formテキスト入力" ] ]
            , li [] [ a [ url="src/counter.html", label=text "Counter.html" ] ]
            ]
        ]
