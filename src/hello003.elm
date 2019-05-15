module Hello003 exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Html exposing (Html)



-- 複数行にするにはどうするか
-- なにかでwrapする必要がありそう => elか => columですね
-- hello003.elm
-- columnとrowはsecond argumentがListです



main =
    layout [] <|
        column []
            [ el []
                (text "hello world")
            , el [] (text "hellooooo woooorld")
            , el [] (text "whats up?")
            ]
