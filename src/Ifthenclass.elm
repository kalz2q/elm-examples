module IfThenClass exposing (main)

import Html
import Html.Attributes as HA


main : Html.Html msg
main =
    Html.div
        [ if awesome then HA.class "awesome" else HA.class "" 
        ]
        [ case maybeName of
             Just name -> Html.div [] [ Html.text name]
             Nothing -> Html.text "" ]

awesome = True 

maybeName = Just "taro"