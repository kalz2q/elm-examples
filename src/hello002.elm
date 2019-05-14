module SimpleHelloWorldElm exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Html exposing (Html)

-- hello001をElement.layoutでwrapしてみる
-- hello002.elm
-- Element.textはStirng -> Element msg
-- layoutはList (Element.Attribute msg) -> Element.Element msg -> Html.Html msg
-- Element系のdivとかはList (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
-- 比較すると、2番目の引数がargumentがListかmsgかの違いがある。
-- Listではないので`()`でくるむか、<|で放り込むことになる


main =
    layout []
        -- (text "hello world")
        -- (el [] (text "hello world"))
        <| text "hello woorld"

-- Element.paragraph []
--     [ text "lots of text ...."
--     , el [ Font.bold ] (text "this is bold")
--     , text "lots of text ...."
--     ]