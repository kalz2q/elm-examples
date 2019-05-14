module SimpleHelloWorldElm exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Html exposing (Html)



-- 複数行にするにはどうするか
-- なにかでwrapする必要がありそう => elか => columですね
-- background.colorをつけてみる



main =
    layout [] <|
        column [Background.color (rgb255 200 200 200)
        , height fill
        , centerX]
            [ el []
                (text "hello world")
            , el [] (text "hellooooo woooorld")
            , el [] (text "whats up?")
            ]
