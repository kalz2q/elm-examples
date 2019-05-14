module SimpleHelloWorldElm exposing (main)

import Html exposing (Html, div, text)



-- text文は2行書けるか => くっついてしまう。仕様。
-- divとtextの違い


main =
    div []
        [ text "hello world"
        , text "2行目です。"
        , div [] [ text "2行目です。" ]
        ]
ｌｓ