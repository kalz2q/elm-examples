module Hoge exposing (..)

komojiFree : String -> String
komojiFree input =
  String.replace "ぁ" "あ" input
  |> String.replace "ぃ" "い"
  |> String.replace "ぅ" "う"
  |> String.replace "ぇ" "え"
  |> String.replace "ぉ" "お"
  |> String.replace "ゃ" "や"
  |> String.replace "ゅ" "ゆ"
  |> String.replace "ょ" "よ"
  |> String.replace "っ" "つ"
  |> String.replace "ゎ" "わ"
