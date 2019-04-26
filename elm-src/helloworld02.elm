module HelloWorldHtml exposing (main)

import Html exposing (Html, text)


main : Html msg
main =
    text "Hello, World!"

-- typeについてよくわからないが、mainというもの(なにか)がHtml msgという型(type)を持っている
-- Html.textは引数に文字列をとり、Html msgという型を返す
-- mainを定義する前にmain : Html msgとすることにより、mainの定義の型が決まっているので、それと違った定義はあり得ない
-- コンパイルエラーになる
-- 定義前に型を指定することは強制ではないが、後からでも加えておくことがプログラムを読む際に役に立つ
