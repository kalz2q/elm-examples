module SimpleHelloWorldElm exposing (main)

import Html exposing (text)

-- 一番簡単なElmによるハローワールドです。
-- このtextの型はString -> Html Msgだと思う。
-- elm-uiにはElement.textという関数があってこれはElement Msgを作る
-- それでlayoutできるようになる。やってみよう。


main =
    text "Hello, World!"
