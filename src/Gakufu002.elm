module Gakufu002 exposing (main)

-- Gakufu001で、pdfを表示、mp3を鳴らすのができた。
-- randomボタンとplay controlをつける。
-- 数曲のファイルにする。
-- play => 10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Random


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { pdfUrl : String
    , mp3Url : String
    , title : String
    }


init : Model -> ( Model, Cmd Msg )
init =
    ( { pdfUrl = "https://drive.google.com/uc?id=1yYAaH3a9SZ2FdkRWXIeCqc6G3u9_awL2"
      , mp3Url = "https://drive.google.com/uc?id=10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY"
      , title = "湯の町エレジー"
      }
    , Cmd.none
    )


type Msg
    = Submit
    | NewRandom Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Submit ->
            ( model
            , Random.generate NewRandom (Random.int 1 (List.length dict))
            )

        NewRandom n ->
            ( { model | pdfUrl = (List.take 1 (List.drop n dict)).pdfUrl }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


viewDetailedPdf : Model -> Html Msg
viewDetailedPdf model =
    div
        [ HA.style "box-shadow" "0 0 10px #555"
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
                [ HA.style "font-size" "30px"
                , HA.style "font-weight" "lighter"
                , HA.style "font-style" "italic"
                , HA.style "margin" "0 0 10px 0"
                ]
                [ Html.text model.title ]
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
                , button [ HE.onClick Submit ] [ text "Random" ]
                , audio
                    [ HA.src "https://drive.google.com/uc?id=10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY"
                    , HA.controls True
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


dict : List Model
dict =
    [ { pdfUrl = "https://drive.google.com/uc?id=1yYAaH3a9SZ2FdkRWXIeCqc6G3u9_awL2"
      , mp3Url = "https://drive.google.com/uc?id=10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY"
      , title = "湯の町エレジー"
      }
    , { pdfUrl = ""
      , mp3Url = ""
      , title = ""
      }
    ]
