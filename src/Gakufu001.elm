module Gakufu001 exposing (main)

-- サイト名 楽譜とMIDIのページ
-- ボタン select music (random)
-- ボタン play
-- pdf
-- 5. pdfファイルはgoogle cloudを使う。base64はelmに埋め込む。
-- https://drive.google.com/file/d/1zRy9O9U4w8HsSnJuMJvDQG276MwGept9/view?usp=sharing
-- => google.drive.comで接続が拒否されました
-- https://drive.google.com/uc?id=1NyeKCX2Hh0iioPYQs7JsJ8e_okLC4L5Y
-- https://drive.google.com/uc?id=1zRy9O9U4w8HsSnJuMJvDQG276MwGept9/view?usp=sharing
-- これで成功 embed iframe どちらでも枠ができてしまうけど。
-- wavも鳴らせた。autoplayはダメだけど
-- play => 10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY
--

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }


type alias Model =
    { url : String, caption : String }


initialModel : Model
initialModel =
    { url = "https://drive.google.com/uc?id=1yYAaH3a9SZ2FdkRWXIeCqc6G3u9_awL2"
    , caption = "湯の町エレジー"
    }


type Msg
    = NoMsg


update : Msg -> Model -> Model
update msg model =
    case msg of
        _ ->
            model


viewDetailedPdf : Model -> Html Msg
viewDetailedPdf model =
    div
        [ HA.class "detailed-photo"
        , HA.style "box-shadow" "0 0 10px #555"
        , HA.style "background" "#aaa"
        ]
        [ img
            [ HA.src model.url
            , HA.style "width" "100%"
            ]
            []
        , div
            [ HA.style "padding-bottom" "10px"
            ]
            [ h2
                [ HA.class "caption"
                , HA.style "font-size" "30px"
                , HA.style "font-weight" "lighter"
                , HA.style "font-style" "italic"
                , HA.style "margin" "0 0 10px 0"
                ]
                [ Html.text model.caption ]
            ]
        ]


view : Model -> Html Msg
view model =
    Html.div []
        [ div
            [ HA.style "background-color" "#aaa"
            , HA.style "padding-bottom" "10px"
            , HA.style "padding-top" "10px"
            , HA.style "text-align" "center"
            ]
            [ h1 []
                [ text "楽譜を歌おう"
                , button [] [ text "Random" ]
                , audio
                    [ HA.src "https://drive.google.com/uc?id=10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY"
                    , HA.controls True

                    -- , HA.id "myAudio"
                    -- , HA.style "myAudio.playbackRate" "3.0"
                    , HA.style "text-align" "right"
                    ]
                    []
                ]
            ]
        , div
            [ HA.style "margin" "auto"
            , HA.style "width" "90%"
            ]
            [ viewDetailedPdf model
            ]
        ]
