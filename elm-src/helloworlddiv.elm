module HelloWorldDiv exposing (main)


import Html exposing (Html, div, text)


main : Html msg
main =
    div [] [ text "Hello, World!" ]

-- text関数が今回はdiv関数の中に入っています
-- text関数がdiv関数の`child`になっています
-- divの型を調べると次のようになっています
-- <function> : List (Attribute msg) -> List (Html msg) -> Html msg
-- divは2つのList型の引数をとり、1つ目はattributeのリスト、2つ目はhtmlのリストです



