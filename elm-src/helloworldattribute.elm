module HelloWorldAttribute exposing (main)

import Html exposing (Html, div, node, text)
import Html.Attributes exposing (..)


main : Html msg
main =
    div [ class "text-center" ]       [ stylesheet, text "Hello, World!" ]
    -- div [ id "container" ] [ stylesheet, text "ハロー、CSS" ]



-- Html.Attributesモジュールをimportします
-- classとかidとかが使えるようになります
-- text-centerを試しにやってみました


stylesheet =
    let
        tag =
            "link"

        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "styles.css"
            ]

        children =
            []
    in
    node tag attrs children
