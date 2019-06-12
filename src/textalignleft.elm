module TextAlignLeft exposing (main)

import Html
import Html.Attributes



-- elmでごく普通に左寄せの文章を書く
-- 英語と日本語


main =
    Html.div
        [ Html.Attributes.style "width" "600px"
        , Html.Attributes.style "margin" "auto"
        ]
        [ Html.div [ Html.Attributes.style "text-align" "left" ]
            [ Html.text "Elmでごく普通に左寄せの文章を書くじっけん。英語と日本語の両方でやってみたい。材料なしてやりだしたが、どうなることやら。つまりまずはなにもimportしないで書いてみる。たぶんHtml、Browser, Html.Attributeが必要なのではないか。"
            , Html.text "this is a pen . TThsi is not a p;en.  This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. "
            , Html.p []
                [ Html.text "Elmでごく普通に左寄せの文章を書くじっけん。英語と日本語の両方でやってみたい。材料なしてやりだしたが、どうなることやら。つまりまずはなにもimportしないで書いてみる。たぶんHtml、Browser, Html.Attributeが必要なのではないか。" ]
            , Html.div []
                [ Html.text "this is a pen . TThsi is not a p;en.  This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. "
                ]
            , Html.div []
                [ Html.text "Elmでごく普通に左寄せの文章を書くじっけん。英語と日本語の両方でやってみたい。材料なしてやりだしたが、どうなることやら。つまりまずはなにもimportしないで書いてみる。たぶんHtml、Browser, Html.Attributeが必要なのではないか。" ]
            , Html.div []
                [ Html.text "this is a pen . TThsi is not a p;en.  This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. This is an apple. "
                ]
            , Html.p []
                [ Html.text "Html.textで書くとどんどんつながる。Html.divなりHtml.pなりで区切ると改行が入る。divだと改行は入るが段落との間はあかない。とりあず趣味的にはHtml.pですね。いまgoogle-chromeでみてみたらHtml.pだとmarginが上下に16入る。"
                ]
            ]
        ]
