

-- onchange.elm
-- ElmでプルダウンメニューのonChangeイベント
-- https://qiita.com/asmasa/items/f2db1c4f3320283f823c
-- => edrror

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events exposing (on)
import Json.Decode as Json

type Msg
    = Change String


view : Model -> Html Msg
view model =
    let
        handler selectedValue =
            Change selectedValue
    in
    div []
        [ div [] [ text selectedText ]
    select [ onChange handler ]
        [ option [ value "a" ] [ text "a" ]
        , option [ value "b" ] [ text "b" ]
        , option [ value "c" ] [ text "c" ]
    ]



onChange : (String -> msg) -> Attribute msg
onChange handler =
    on "change" (Json.map handler Events.targetValue)
    