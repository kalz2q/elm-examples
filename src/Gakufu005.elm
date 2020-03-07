module Gakufu005 exposing (main)

-- Achieved random list of music => Gakufu004.elm
-- next project is attach a button to show music sheet
-- Todo002.elm will work as reference
-- background color to each line

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
    { jpgUrl : String
    , mp3Url : String
    , title : String
    , filename : String
    , dolist : Bool
    , list : List Musicdata
    }


type alias Musicdata =
    { jpgUrl : String
    , mp3Url : String
    , title : String
    , filename : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" "" "" "" True dict
    , Random.generate NewList (shuffle dict)
    )


type Msg
    = Submit
    | NewRandom Int
    | Shuffle
    | NewList (List Musicdata)
    | ShowMusic Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Submit ->
            ( model
            , Random.generate NewRandom (Random.int 1 (List.length dict))
            )

        NewRandom n ->
            case List.drop n dict of
                x :: _ ->
                    ( { model
                        | jpgUrl = x.jpgUrl
                        , mp3Url = x.mp3Url
                        , title = x.title
                        , filename = x.filename
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model
                    , Cmd.none
                    )

        Shuffle ->
            ( model
            , Random.generate NewList
                (shuffle dict)
            )

        NewList newList ->
            ( { model | list = newList }
            , Cmd.none
            )

        ShowMusic index ->
            case List.drop index model.list of
                x :: _ ->
                    ( { model
                        | jpgUrl = x.jpgUrl
                        , mp3Url = x.mp3Url
                        , title = x.title
                        , filename = x.filename
                        , dolist = False
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model
                    , Cmd.none
                    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


viewDetailedPdf : Model -> Html Msg
viewDetailedPdf model =
    div
        []
        [ img
            [ HA.src model.jpgUrl
            , HA.style "width" "100%"
            ]
            []
        ]


linecolor : Int -> String
linecolor index =
    if modBy 2 index == 0 then
        "pink"

    else
        "yellow"


view : Model -> Html Msg
view model =
    case model.dolist of
        True ->
            div
                [ HA.style "margin" "auto"
                , HA.style "width" "800px"
                ]
                (List.indexedMap
                    (\index music ->
                        p
                            [ HE.onClick (ShowMusic index)
                            , HA.style "background" (linecolor index)
                            ]
                            [ text music.title
                            , button
                                [ HA.style "float" "right"
                                , HA.style "background" (linecolor index)
                                ]
                                [ text "Show Music" ]
                            ]
                    )
                    model.list
                )

        False ->
            div []
                [ div
                    []
                    [ h1 []
                        [ audio
                            [ HA.src model.mp3Url
                            , HA.controls True
                            , HA.style "float" "right"
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


shuffle : List a -> Random.Generator (List a)
shuffle list =
    let
        randomNumbers : Random.Generator (List Int)
        randomNumbers =
            Random.list (List.length list) <| Random.int Random.minInt Random.maxInt

        zipWithList : List Int -> List ( a, Int )
        zipWithList intList =
            List.map2 Tuple.pair list intList

        listWithRandomNumbers : Random.Generator (List ( a, Int ))
        listWithRandomNumbers =
            Random.map zipWithList randomNumbers

        sortedGenerator : Random.Generator (List ( a, Int ))
        sortedGenerator =
            Random.map (List.sortBy Tuple.second) listWithRandomNumbers
    in
    Random.map (List.map Tuple.first) sortedGenerator


dict =
    [ { jpgUrl = "https://drive.google.com/uc?id=1dvVCvdFKKJlVmU3WqRgMkg0YsugL3qKR"
      , mp3Url = "https://drive.google.com/uc?id=1877DcOpz7rhRQ7XhpV7I34MQf018IDYt"
      , title = "水戸黄門(じんせいらくありゃくもあるさ)"
      , filename = "mitokomon.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1uCHqo0azmYAlA_uXPSbIDqONPcCCsktO"
      , mp3Url = "https://drive.google.com/uc?id=1uz6hK-iGgWwpW3o09bLO9ZRg8AQ3NVxC"
      , title = "スーダラ節(植木等、ちょいといっぱいのつもりでのんで)"
      , filename = "sudarabushi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Z2Qxq8UoHBDMv6wXuRmNMJWwryg2EN0z"
      , mp3Url = "https://drive.google.com/uc?id=1Mz6hlYoD-PUHQRuGVl1DDm3128sIIIKV"
      , title = "ママがサンタにキスをした(クリスマス。I Saw Mommy Kissing Santa Claus)"
      , filename = "mommykisssanta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qXQbr3mQNF3S-v4DhMvkiKLo5jKEnxFk"
      , mp3Url = "https://drive.google.com/uc?id=1hA4f6JyrXacIqCoOu98Ssb_5mLvyU6iT"
      , title = "ラスト・クリスマス(ワム！)"
      , filename = "lastchristmas.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ldi4WgfnPKqNFh1ZnpOh4GLHoIKNCXed"
      , mp3Url = "https://drive.google.com/uc?id=1n6FeRm8jMkCnxQqx8sGnqW1LnZMy2ZB3"
      , title = "ジョニーが凱旋するとき(When Johnny Comes Marching Home)"
      , filename = "whenjohnny.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13H_NvIKtfeFW_fRM21rU0LV5VS2K970w"
      , mp3Url = "https://drive.google.com/uc?id=1PEARIfK0ThavDeGT0KH7l0rbnKqPb4zN"
      , title = "ホワイト・クリスマス"
      , filename = "whitechristmas.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10ZhxQ5_NiHQT9tAn7PHhqiNQ7AtzWxq8"
      , mp3Url = "https://drive.google.com/uc?id=17tul0wr1yBhuvCUdJjBuaLA1gpjMAJhP"
      , title = "おめでとうクリスマス(We Wish You a Merry Christmas)"
      , filename = "omedetouchristmas.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ouKwNK7a8O1SbxiNA6754Mekw4wqbq9r"
      , mp3Url = "https://drive.google.com/uc?id=1kSlQD5D8cV1oXBpKtjMzmGzN2-hUuC_N"
      , title = "そりすべり(リロイ・アンダーソン。クリスマス)"
      , filename = "sorisuberi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hM2sYbWnLcylOKAdMtxQnQz7yrFNsNpK"
      , mp3Url = "https://drive.google.com/uc?id=1jvYKa16U5WI-Yo1sWxKkVgFXlxRWWupv"
      , title = "もろびとこぞりて(クリスマス)"
      , filename = "morobito.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ggnDyoqTZbuDH03k4LZ-MkSf-aAOhtiP"
      , mp3Url = "https://drive.google.com/uc?id=1KH0cab55b9HdFkbuz7XnLZvyhm6qgvKd"
      , title = "テネシーワルツ"
      , filename = "tennessee.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1RQuGnQA-VVVLll_LQ2Zrg-TOHTuQZ0ea"
      , mp3Url = "https://drive.google.com/uc?id=1xU4mcYN6vjYW-IX5793FurYzR4DGrEpc"
      , title = "津軽海峡・冬景色(うえのはつのやこうれっしゃおりたときから)"
      , filename = "tsugaru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jpv7TUhae3NcmeOMebhfLYJu4bAEj6vG"
      , mp3Url = "https://drive.google.com/uc?id=1mEObQW8HP21XyA3CQrykrbPukem2f0TM"
      , title = "あら野のはてに(あらののはてにゆうひはおちて。クリスマス)"
      , filename = "aranonohateni.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1bRvWIAaz5jkCp2cF1dWILxHdF9roI3jq"
      , mp3Url = "https://drive.google.com/uc?id=1kDi3Uj0k1AsAIW404Z6vhktke11h_kIO"
      , title = "牧人ひつじを(まきびとひつじをまもれる。クリスマス)"
      , filename = "makibito.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MHOF5ij89pecc636InrKXQyWd2qm8oyT"
      , mp3Url = "https://drive.google.com/uc?id=1XOLRMNqxCtGSYCMTCC_0T_3WfC60RIDv"
      , title = "ひいらぎかざろう(クリスマス)"
      , filename = "hiiragi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ahV1jpiP5VTq98FbtWZLXR2mL1YxbPlv"
      , mp3Url = "https://drive.google.com/uc?id=1KR7Wd9MjJoUyvLvSsfvECZO2EpadaidE"
      , title = "涙そうそう(ふるいあるばむめくりありがとうってつぶやいた)"
      , filename = "nadasoso.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hG4WU868zBD3NwIRFLj4r6FujKpUdIHg"
      , mp3Url = "https://drive.google.com/uc?id=1xz7jJpUCuhgpDcZmJ9jo1pl4vUF5O_Ie"
      , title = "アメイジング・グレイス"
      , filename = "amazinggrace.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=17y4yFh6UfyjTlQhjPH7fgdgWwj20oP1S"
      , mp3Url = "https://drive.google.com/uc?id=1jlDhEgmfEGUZSIA7StuHTz_esjN3Rb8e"
      , title = "夢はひそかに(ディズニー「シンデレラ」)"
      , filename = "dreamisawish.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11nnSYaiShFBVFjnm-C-wXVuVr8zTVe7e"
      , mp3Url = "https://drive.google.com/uc?id=1XaG3H7bv9ftKFAzvnVvLsT2KWMqGLuP0"
      , title = "右から2番目の星(ディズニー「ピーター・パン」)"
      , filename = "migikara2banme.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1rHwKYFxld4fdO0tfBcfJRSjQgznWBxil"
      , mp3Url = "https://drive.google.com/uc?id=1lW7x2No_cMDxZgZz8eoh03SZ7NvBF2Au"
      , title = "花は咲く(まっしろなゆきみちにはるかぜかおる)"
      , filename = "hanawasaku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ysc2Bm8hSWUmqLmJRDn0mI8JRkSuZO7S"
      , mp3Url = "https://drive.google.com/uc?id=1VQG2ljNW7rGlG50O8nvoGvYweeIo5M5P"
      , title = "ライオンは寝ている(トークンズ)"
      , filename = "lionsleeps.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1YW3ASSfbO8RFLdkGWwF83mC2RJHQlKTm"
      , mp3Url = "https://drive.google.com/uc?id=17h58N9AFOuyCC6Mns-sVjwPoIMBqV5ag"
      , title = "ラ・ラ・ルー(ディズニー「わんわん物語」)"
      , filename = "lalalu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1VxPJtDXF08Q-QCnRz73_jqQ9BDNeivRL"
      , mp3Url = "https://drive.google.com/uc?id=1ygAkAE49i1yYSlRqiqiB4In_b-xT5POo"
      , title = "ドラゴンクエスト序曲"
      , filename = "dragonquest.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1wgH3vF3Ai7C1fTLVJk-s02x9B1s7Ysva"
      , mp3Url = "https://drive.google.com/uc?id=1cgdOkILV2stvb2TqTau0Z0-OOCdKyX_M"
      , title = "春の唄(らららあかいはなたば)"
      , filename = "harunoutararara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qxvdZrrnWJBsuIJcH6XSZrXtvMyI6z8y"
      , mp3Url = "https://drive.google.com/uc?id=1v-hAoSoiuNoZNaFmJLCqJ67IcoOsBqdd"
      , title = "シンコペーテッド・クロック(ルロイ・アンダーソン)"
      , filename = "syncopatedclock.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qLVBGoVXIivoP98uAvn3yxF1tK6hoF56"
      , mp3Url = "https://drive.google.com/uc?id=11TFnETlYYEEhpcf_X7ClfuRW3xnDQ7w0"
      , title = "オネスティ(ビリー・ジョエル)"
      , filename = "honesty.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=15ETizs6k2i0-DOzVrGVL7stHTNZKNrWV"
      , mp3Url = "https://drive.google.com/uc?id=1DCKvW0_W3slyIBUyYw1Y902gLCAD-nAZ"
      , title = "ビッグ・ベンの鐘(ウェストミンスター宮殿の時計)"
      , filename = "bigben.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1lNT8N9TuQEgJH840sp4j19LbILyv-D2C"
      , mp3Url = "https://drive.google.com/uc?id=1BhHv9LrNPP72BjieWt6VHUSji9vkWGTG"
      , title = "恋は水色(ポール・モーリア)"
      , filename = "lamourestbleu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-wOeFLfqnVM96CJ5nz6Bav4mC00QfB0K"
      , mp3Url = "https://drive.google.com/uc?id=1vyTgp3Pe3vJL7f2NeY77_uNmcXG0TCQ9"
      , title = "ポリリズム(Perfume とてもだいじなきみのおもいは)"
      , filename = "polyrhythm.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Q-qvIUB4vJhojte5Gl4TcebEfnP2XoXs"
      , mp3Url = "https://drive.google.com/uc?id=1ULAQpP62VcW3oGR4LcZzgS-7-yutIsVk"
      , title = "春よ、来い(松任谷由美。あわきひたりたつにわかあめ)"
      , filename = "haruyokoimatsutoya.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1wrrUDfRCEN5rOpWcOf3YDbfrLgXXXwyz"
      , mp3Url = "https://drive.google.com/uc?id=1_XRfq3pQyshxhjGk4jnxGEGp3XNzj-tz"
      , title = "浪花節だよ人生は(のめといわれてすなおにのんだ)"
      , filename = "naniwabushi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1LMibWxQMAnQQzel6SMeQJzNMeaCab2Fs"
      , mp3Url = "https://drive.google.com/uc?id=1xvUEHUkyZ566gXRaSgNhxQ8QeT-nmWe1"
      , title = "マルエツの歌(どくたーげんきどくたーげんき)"
      , filename = "maruetsu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1SOgvT204wgKf8ZOm0L1sVl85sjI8druw"
      , mp3Url = "https://drive.google.com/uc?id=13EUkyyxzgmZvdSIkxhhG-kce5rsL0Gh-"
      , title = "ローソンストア100(ひゃくひゃくひゃくえん)"
      , filename = "lawsonhyaku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1J24Drfi9KqQ8r52P_qnXdfDHdufXcS1F"
      , mp3Url = "https://drive.google.com/uc?id=1s4yIJlA9llHSjFhEWB4-0zNDO0VguDHt"
      , title = "ケーズデンキの歌(ゆめゆめはっぴーいつでもやすい)"
      , filename = "ksdenki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1n4j-GgKcCdbJh6N65PEA_objdUznXmVo"
      , mp3Url = "https://drive.google.com/uc?id=10kEgfV2KGjM9oWWaB10wnz1W8asNyPuP"
      , title = "セサミストリートのテーマ(さーにーでい)"
      , filename = "sesamistreet.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14vFMATcmJ9XV6h_TAEPmVcvdcNfsIWO8"
      , mp3Url = "https://drive.google.com/uc?id=1IZYVIRAMdYTxTl4buyZpEgU8MlBohZz8"
      , title = "ハート・アンド・ソウル(Heart and Soul)"
      , filename = "heartandsoul.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14rSEr5sGqWguJVfCjOqUN3niHthbww0s"
      , mp3Url = "https://drive.google.com/uc?id=187rB_4IbKxlySnLWvOLKotNwPCLlfc_t"
      , title = "東京節(パイノパイノパイ)"
      , filename = "tokyobushi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Q-upRUVCBtjYMzn_Cv19aya7U7-QgbLi"
      , mp3Url = "https://drive.google.com/uc?id=14sJKZB5sU_97W98x9DQr4IaeE2iNICQ8"
      , title = "行商人(コロブチカ、korobeiniki, korobushka)"
      , filename = "korobeiniki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1a1mn2DXPQaJxrBudJhZw7iWVqU_AgOaE"
      , mp3Url = "https://drive.google.com/uc?id=1fkBoUIZ_yISrn-4qcnICromLiYbqTG44"
      , title = "蒲田行進曲(にじのみやこひかりのみなときねまのてんち)"
      , filename = "kamata.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1_xVaabYUbL7M1VNVguYoAYLo2DLf5sZS"
      , mp3Url = "https://drive.google.com/uc?id=1jzDlfFfDi3or0B5MR-oonA2okFHFkMjd"
      , title = "カリンカ"
      , filename = "kalinka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1A0CJZcuio21j0_9fUL_04DTT0g9vDkl6"
      , mp3Url = "https://drive.google.com/uc?id=1c-OhnN2zG00F2MNhIieF5ULWUc4oHyLY"
      , title = "君は我が心の中に(Du, Du Liegst Mir Im Herzen)"
      , filename = "duliegstmir.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1XcrL82FKCba7bM487s7PNMmsNUI4REFE"
      , mp3Url = "https://drive.google.com/uc?id=1RQlxrWBJVr70okBGvml5Z6nkb1bLBGeF"
      , title = "冬のソナタ(最初から今まで )"
      , filename = "fuyunosonata.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jE0-N9KOGFq8Wok-CzplCIyvhI_jXvfA"
      , mp3Url = "https://drive.google.com/uc?id=1e5SNtOTP_PV5xyPiU0zJyxSUJTqKm3Y0"
      , title = "いつも何度でも(千と千尋の神隠し。よんでいるどこかむねのおくで)"
      , filename = "itsumonando.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Z2kMe0ghb6jC5Uxuv65KCq_ygY3LttPG"
      , mp3Url = "https://drive.google.com/uc?id=1UBsVhZHAFJZp0TXFAFin46CKQ8hrgL8Q"
      , title = "主よ人の望みの喜びよ(J.S.バッハ)"
      , filename = "shuyohitononozomino.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jm6PhloLJV6GrcLYsZ6CsvyzHz2hBQbj"
      , mp3Url = "https://drive.google.com/uc?id=1kkHN0Mira_KfuGNOR-0dNJNuAAdyQVyT"
      , title = "ありのままで(アナと雪の女王イントロ。let It Go)"
      , filename = "letitgointro.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1OM0vxy4FAJPl9r3ViH_2I7fFXgxLAvfl"
      , mp3Url = "https://drive.google.com/uc?id=12VjafmXELv5HJjJYUrAV0FsK3koM8xxY"
      , title = "ます(シューベルト。きよきながれをひかりはえてますははしれり)"
      , filename = "schubertmasu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ib49mMTNbJqrPOStCxNWqwaIFT758XTb"
      , mp3Url = "https://drive.google.com/uc?id=1w7yAe4dKezP1tZn7GssP-YcaO1MN6-Vh"
      , title = "華麗なる大円舞曲(ショパン)"
      , filename = "kareinaru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zgnlJbF9fyF6uXkx_jEG0PX3d2DhM2bV"
      , mp3Url = "https://drive.google.com/uc?id=111giGLdFiDE8pvVnfwP31gq04M5vPXH7"
      , title = "天国と地獄(オッフェンバック)"
      , filename = "tengokujigoku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=17x2M9193-I44D2yJrZ6PZkMpSyQLOJOj"
      , mp3Url = "https://drive.google.com/uc?id=17pYZnZMuBo4CCh_gCeWdCBmyZ2z0U86h"
      , title = "クシコス・ポスト(ネッケ)"
      , filename = "csikospost.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1i5vt1PIXpPTxyurhwlr-3KZGRzTmYH74"
      , mp3Url = "https://drive.google.com/uc?id=16OlB-FsTnY-8R1mE5SX_j6-KxzRdFglw"
      , title = "恋とはどんなものかしら(モーツアルト。フィガロの結婚より)"
      , filename = "koitowadonna.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1S4i8guOwAti_55LgtJ09StN8uT15G6DQ"
      , mp3Url = "https://drive.google.com/uc?id=1eH-C9NqTNGKY9coURlKNMJdCMUP9U7H1"
      , title = "ジムノペディ1番(サティ)"
      , filename = "gymnopedies.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1UuOwx135urMNvk5obIJ4X_NI19VeJzee"
      , mp3Url = "https://drive.google.com/uc?id=1MxPKtxYwK8K5XnbGDi2Hq03smCrTrPvo"
      , title = "亜麻色の髪の乙女(ドビュッシー)"
      , filename = "amairodebussy.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1tcxz356pIlhJGuxq8GYv8Sx8ESmNLCt_"
      , mp3Url = "https://drive.google.com/uc?id=11cXjM6Vhh89c0G4AZFR1R940gb7cM8js"
      , title = "美しき青きドナウ(ヨハン・シュトラウス2世)"
      , filename = "donau.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1nmRM0PvD0tyiqoy7Rt1lk_oXCAvpMH-h"
      , mp3Url = "https://drive.google.com/uc?id=1BbI5uYSih3ZN9-1_9pzkzc9QF6eofXeQ"
      , title = "ジュ・トゥ・ヴ(エリック・サティ)"
      , filename = "jeteveux.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1C1bHJX1coLxu-p8AeKy-06F1JIuOEC-Q"
      , mp3Url = "https://drive.google.com/uc?id=1oFARTSCKkwL-DXduZ6C25IgH5bunpmeR"
      , title = "モーツァルトの子守歌(ねむれよいこよにわやまきばに)"
      , filename = "mozartkomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=17eVjT4HOC8w1QRs7X86JzHLCzA7Zwp1v"
      , mp3Url = "https://drive.google.com/uc?id=1xoFNN2tJ1cd-OXrbqIoWJuT2CnJdT9eP"
      , title = "ブラームスの子守歌(ねんねんころり)"
      , filename = "brahmskomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1VVdq0KrKjYxbkgycYhm02cKjism8HHIh"
      , mp3Url = "https://drive.google.com/uc?id=1mZXkhY9tGiwf9POwdjVvSmZqJqzJqFty"
      , title = "運命(ベートーベン交響曲5番)"
      , filename = "unmei.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1CDaVU0XjiFnDFhriij0eQAEQdU_KPiFP"
      , mp3Url = "https://drive.google.com/uc?id=1ZR0JA3gj7ATEAAQiomElGSwL-Z0rFdZo"
      , title = "ハバネラ(ビゼー。カルメンより)"
      , filename = "habanera.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1_Ac3Rk8CJH5zUoM2Zx3nXddoYOQ8PRAX"
      , mp3Url = "https://drive.google.com/uc?id=1Ty10QEffZ-hxMAbKf8q51qm_0k6SQ9G3"
      , title = "新世界(ドヴォルザーク)"
      , filename = "shinsekaip.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11fH3Ekzgv7vCcrROlRlqa5KDXoc6ZxG1"
      , mp3Url = "https://drive.google.com/uc?id=1G4EP0M7qIpGXraaDIrzOW6YLcfU7c-KA"
      , title = "ヴィヴァルディ四季より春"
      , filename = "vivaldishiki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qFNBBqt_E4PsHjsx6fVIwpDO_T9Qnqpj"
      , mp3Url = "https://drive.google.com/uc?id=1EUWUhemlvRwYKC1cHi0XCaZPpg7-l7AL"
      , title = "威風堂々(エルガー。いふうどうどう)"
      , filename = "ifudodo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1A7n3h7KqnGfL_7R2qsXFTFkgEicu46AF"
      , mp3Url = "https://drive.google.com/uc?id=1eIGiSxWo9kLbSiIr1Aj8myvpn7Hj7S2S"
      , title = "春の歌(メンデルスゾーン)"
      , filename = "mendelsharunouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Mo7XmprxhLBTkRffQoo-hBGKrC_CC2lP"
      , mp3Url = "https://drive.google.com/uc?id=1HkbtqUxqnNhFHY7rCznAyJHiC2jxvfjp"
      , title = "乾杯の歌(ヴェルディ。椿姫より)"
      , filename = "kanpai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1u2eLbZdoFMFo6OT9R9k_sHXq5OoLXJTc"
      , mp3Url = "https://drive.google.com/uc?id=1qwtV9HR-AsPfNeM-jLgUs-1_rmGjtxlr"
      , title = "ラデツキー行進曲(ヨハン・シュトラウス1世)"
      , filename = "radetzky.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10p7NcuKPY3lIL55tvv712xIksWoyC3mp"
      , mp3Url = "https://drive.google.com/uc?id=1GpNrRtmi-y9lzmGYTl36PkP2Oy-_1nXT"
      , title = "ずいずいずっころばし(ごまみそずいちゃつぼにおわれてとっぴんしゃん)"
      , filename = "zuizui.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DW8gcnWRffG6ZE2adEEq7wF0Q-8INVWv"
      , mp3Url = "https://drive.google.com/uc?id=1BHOn481oLb5q-dC8iYRnqDr4gE-fhFJ1"
      , title = "燃えろよ燃えろよ"
      , filename = "moeroyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1yoHCu6mhLCn1HMlFgg51OTrdySVbd69X"
      , mp3Url = "https://drive.google.com/uc?id=1GHAmUg3ZsKvC8O5mAip9wqeZAB9-d3G9"
      , title = "マイ・ボニー(My Bonnie Lies Over the Ocean。まいぼにー)"
      , filename = "mybonnie.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1v3SCofTxg2gYNP13iIp9TkcHAemOGBX-"
      , mp3Url = "https://drive.google.com/uc?id=1s5yw81tNyUCM_Qz3IP_gisKD9r8AkSTT"
      , title = "茶色の小瓶"
      , filename = "chairo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1y0CN0x6t0uBKWbR5Yp18jGixdpRXoNRE"
      , mp3Url = "https://drive.google.com/uc?id=1Z0Chk-3kM4GclVhMjTPhpo7JhruPFwr8"
      , title = "権兵衛さんの赤ちゃん(ごんべえさんのあかちゃんが)"
      , filename = "gonbe.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-tbVeYFSzVYzJUsmpDF33kSoD1ZUTsBj"
      , mp3Url = "https://drive.google.com/uc?id=1v01I0ZC09yK7SrBto1wJnab-ipDmUUmb"
      , title = "山の音楽家(わたしゃおんがくかやまのこりす)"
      , filename = "yamanoongakuka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1CId-_uO92l_R1ciCHKHOlALk4Q4Zojk0"
      , mp3Url = "https://drive.google.com/uc?id=10S5zMSbW1bxHbcQYn0QR66D77-ytaR7c"
      , title = "木星(ホルスト「惑星」よりジュピター)"
      , filename = "mokusei.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=16AsfJ_6Y2w6fpo969gSa9Rfd_tLYO-XK"
      , mp3Url = "https://drive.google.com/uc?id=1USdA-PXDzPd-Gnbw0nkZigIk8ixt415d"
      , title = "アイネ・クライネ・ナハト・ムジーク(モーツァルト)"
      , filename = "eineclinenacht.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1uCDdmklyq3uDkqsu3xWM2WUxOfoUs90s"
      , mp3Url = "https://drive.google.com/uc?id=1TaQVLcgr3iquaoLhmaiI1E1TmaddFS1L"
      , title = "雨だれの前奏曲(ショパン)"
      , filename = "amadare.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1c6kEhVnDgkPyQ64SfhYpU-lYffBDi_90"
      , mp3Url = "https://drive.google.com/uc?id=1NWEYaFtt2Imu-JxfwxwtO4bVamtJLJOc"
      , title = "愛の喜び(マルティーニ)"
      , filename = "ainoyorokobi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1cZ-YLAQkhh9Z39z4B1sXJA2xuevzpVG3"
      , mp3Url = "https://drive.google.com/uc?id=1qGfklxN1OMgfl6Oe2hOv9guJtv9gzpVa"
      , title = "江戸の子守唄(ねんねんころりよおころりよ)"
      , filename = "edokomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1yp765_JrH_Y2RcopTKYjBVHcSJApYawQ"
      , mp3Url = "https://drive.google.com/uc?id=1t2rvtaHQjn6v9RhOcFINbMAa2Jsr--31"
      , title = "あんたがたどこさ(ひごさひごどこさくまもとさ)"
      , filename = "antagata.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ssnGS0GdXloDZlpF4Epjk6gICWE_WWiu"
      , mp3Url = "https://drive.google.com/uc?id=1shHTsftfJiv-HEmA0ebWQ-z2KWdL69SK"
      , title = "森のくまさん(あるひもりのなかくまさんにであった)"
      , filename = "morinokuma.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-7sowp8_dvpF0fJ50zyEw7qsnDjPeJGB"
      , mp3Url = "https://drive.google.com/uc?id=1ZjV1gdDA2MCxg13_oiBeZP9Aqfwr111l"
      , title = "ブラームスのワルツ(円舞曲)"
      , filename = "waltzbrahms.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1yRv0yF58qrFPkxdwSzff1Se4wXsDs-8M"
      , mp3Url = "https://drive.google.com/uc?id=1-n_O43SDQVsCL1TfIrMnKBB0t9-Ap8B8"
      , title = "女のみち(わたしがささげたそのひとに)"
      , filename = "onnanomichi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Wg6NzmAt0c82rN57WBJWm5FEbqAGlBNe"
      , mp3Url = "https://drive.google.com/uc?id=1xZMtjeOdzSiKGeRf6R06fZMlLO4mKfF_"
      , title = "ペールギュントより朝(グリーグ)"
      , filename = "peergyntasagrieg.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=153Xoh2BXwupoyUgCOOfQhVRD0tRYUWfm"
      , mp3Url = "https://drive.google.com/uc?id=1ak_0vasbM215p6mcbbcvN2Sfl-hxt1UP"
      , title = "ホルン協奏曲第1番(モーツァルト)"
      , filename = "hornmozart.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ACyCgD0JIbIvdSDXfV20qkIrNie9Ti--"
      , mp3Url = "https://drive.google.com/uc?id=1m3y7JvvBylzVWxDcdPMHW4uLmi-RkCOU"
      , title = "池の雨(ヤマハ音楽教室幼児科メロディー暗唱曲)"
      , filename = "ikenoame.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10jPVYnapneZaz0Z3DhAAtLwM_Y2JuShL"
      , mp3Url = "https://drive.google.com/uc?id=1BnK43j7Izorjld6wfR_KjOKUxx2GS0I_"
      , title = "ベートーベンのトルコ行進曲"
      , filename = "turkbeethoven.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1gmwB1G5HWfg7DgqDNz2UA_0Zi7GM_rgo"
      , mp3Url = "https://drive.google.com/uc?id=1s4xdrVVv9DIDyrts8qY85efbWuq0Yu12"
      , title = "聖者が街にやってくる(聖者の行進)"
      , filename = "seija.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1h35HYHAMZamRGVF5FbpgtZ3ChEnUsxNW"
      , mp3Url = "https://drive.google.com/uc?id=1MYR7yWYunHmSkH6m7W46XnWnVjgRMUPd"
      , title = "ロンドン橋(ろんどんばしおちた)"
      , filename = "londonbashi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1f0NYHiLK-w6KXo0safnfO4CTP2CQbh6M"
      , mp3Url = "https://drive.google.com/uc?id=115WGuy--x3DYjkU3P0QSWzBQQHRFkq6F"
      , title = "メリーさんの羊(めりーさんのひつじ)"
      , filename = "marysanno.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hCzT-6C1ZCWi7Spiu_ea0Pxm1cYZ0mvc"
      , mp3Url = "https://drive.google.com/uc?id=1KOVLjXQVFIb2N451H6OZwlai5Ij6BUNt"
      , title = "アブラハムの子(あぶらはむにはしちにんのこ)"
      , filename = "abrahamunoko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1_anB7_50Icnqnw72XzwSaGPbG0FGQFeL"
      , mp3Url = "https://drive.google.com/uc?id=17lUw9X8oWnMtrOV9iP_NcFOCjT2JEpzL"
      , title = "大きな古時計(おおきなのっぽのふるどけいおじいさんのとけい)"
      , filename = "okinafurudokei.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1p33p6AcEBgKQqrfByQWCLBxmyCFmtS2m"
      , mp3Url = "https://drive.google.com/uc?id=19OjobdnGuYn96yuNmvcOlvqVEofBrW3n"
      , title = "かごめかごめ(かごのなかのとりは)"
      , filename = "kagome.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1flKwKu9EzJs2AxP2Uw_zqvJ3AtaRtBnf"
      , mp3Url = "https://drive.google.com/uc?id=1e4LEm4DXUaqEyMCqLdHcgXKrE6M7vZyS"
      , title = "かえるの合唱(かえるのうたがきこえてくるよ)"
      , filename = "kaerunogassho.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1bWr6oICBWPLPzW2dUFYWUGW5mC29Si24"
      , mp3Url = "https://drive.google.com/uc?id=1dOb0Zd-bV1yfwKkVvANDZmy-wDGW1M1A"
      , title = "ゆかいな牧場(いちろうさんのまきばでいーあいいーあいおー)"
      , filename = "yukainamakiba.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Ez4BeywMtfrBTlAR6GtfHY7FClCaijj0"
      , mp3Url = "https://drive.google.com/uc?id=1Cd05l-iihpVT_a5zeXFNtggvTa7UZVyd"
      , title = "大きな栗の木の下で(おおきなくりのきのしたで)"
      , filename = "okinakuri.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dtrqgTM1a_FuGcRS7pCQ45m6tpK2XG4j"
      , mp3Url = "https://drive.google.com/uc?id=1C-FH8z0sjNk34NK_CwG5YmtJ50ngkAfg"
      , title = "凱旋行進曲(ヴェルディ。アイーダ)"
      , filename = "gaisen.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jsm43y2et47tEXW5XiVEgqwRynF3tmMq"
      , mp3Url = "https://drive.google.com/uc?id=1wfPPWpGdQwjB7QcWXIm1qZwt6-YN7Lno"
      , title = "Ob-La-Di, Ob-La-Da (ビートルズ)"
      , filename = "obladi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1gi9N06Fn5X3JoKpTKPv8FGq33BqgtrfA"
      , mp3Url = "https://drive.google.com/uc?id=1iVF-9H9cuc9hkrT3y3JA6gRgTGYGROsJ"
      , title = "Carry That Weight (ビートルズ)"
      , filename = "carrythatweight.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1YkNtnNZ8D2XUmc_pEVNT0-2wAbSjB45W"
      , mp3Url = "https://drive.google.com/uc?id=1dD-LpMMBPgnXhcrL7RzrUiv02ihFV_6t"
      , title = "Across the Universe (ビートルズ)"
      , filename = "acrossuniverse.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1QDsBcxf-0ETuoFSCA6r2bEbvk2zA0L5F"
      , mp3Url = "https://drive.google.com/uc?id=1wQvReBXq6S9yNk0qGrTqSjsERIFraU1T"
      , title = "秋桜(うすべにのこすもすがあきのひのなにげないひだまりにゆれている)"
      , filename = "cosmos.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1JYXpUnLFgTyht62TFMCq-JePJJEPSWCS"
      , mp3Url = "https://drive.google.com/uc?id=1XpVxzqAUwjglsqW_3s-_b1gn4LL_pPss"
      , title = "夜霧よ今夜もありがとう(しのびあうこいをつつむよぎりよ)"
      , filename = "yogiriyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1GzjTn5C2o2nO3Re6fFNjZnLt4wRgrm14"
      , mp3Url = "https://drive.google.com/uc?id=1ztUG1OikJ7JeqvHFf-UaVnNfMm07B7XQ"
      , title = "かっこう(かっこうかっこうどこかでなつをよぶもりのこえ)"
      , filename = "kakkou.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1T0IJaCENt_IScNDFTPR2GhN1m5P7Djsx"
      , mp3Url = "https://drive.google.com/uc?id=15BadqA9mHDFaaqeWlOWr13BRkpgdjGRe"
      , title = "きらきら星(きらきらぼし)"
      , filename = "kirakira.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Bw9opTMSr1CWGnJxvqx8n5_eiYGkKTqg"
      , mp3Url = "https://drive.google.com/uc?id=17m13_3iKfJbNOWkU6urrK3lNo_5jliEb"
      , title = "再会(さいかい。あえなくなってはじめてしった)"
      , filename = "saikai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1w64ryY-NyXIhQza4gWD9ST83rVd6bkEU"
      , mp3Url = "https://drive.google.com/uc?id=1jxeYCnXQ7CZMpEIrn_OJ-hm9dGtPiND9"
      , title = "小さな世界(ちいさなせかい、It's a small world、せかいじゅうどこだって)"
      , filename = "smallworld.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xCXyoEw5-9zctBrnz640d3WUDeMYR8U0"
      , mp3Url = "https://drive.google.com/uc?id=10uRPITMWRgop4qzQS_E5EHuc6Y7-GD0D"
      , title = "竹田の子もりうた(もりもいやがるぼんからさきにゃ)"
      , filename = "takedanokomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1m7g1nF7ojYNMItd9_q-0ey9MlCHD-aY8"
      , mp3Url = "https://drive.google.com/uc?id=1S8_3hTk-Ua7GS72oYqTfxEA5DmYxa8UP"
      , title = "赤鼻のトナカイ(Rudolph the Red-Nosed Reindeer、まっかなおはなの。クリスマス)"
      , filename = "tonakai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1KLxY-W20A0j6FJZWez0RqHX4YCfe07zV"
      , mp3Url = "https://drive.google.com/uc?id=1kFZhlj3Nd5LXC3TOZdcLN-920FOBXCaQ"
      , title = "幻想即興曲(ショパン)"
      , filename = "gensou.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1IvSpfKYPB1TCcvPFX8f_TNgRLIPWgTnA"
      , mp3Url = "https://drive.google.com/uc?id=1n-i9_UBsLWB_HwPxj-E_9mAlRDydV9lt"
      , title = "君が代(きみがよはちよにやちよに)"
      , filename = "kimigayo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1I_3DOLlaNiN6eJ-z7rb2v0pV9dwTmFBp"
      , mp3Url = "https://drive.google.com/uc?id=1PObnTX-60xqaB6zEg1FKFrwiy33JEE75"
      , title = "シューベルトの子守歌(ねむれねむらははのむねに)"
      , filename = "schubertkomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=18v4zRdw8s_1lHQch_rxfALV9o1vJxEHg"
      , mp3Url = "https://drive.google.com/uc?id=1HZQ9MOdHDPdotCMbk_9dMmN4PIAH88xu"
      , title = "シューベルトの野ばら(わらべはみたりのなかのばら)"
      , filename = "schubertnobara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vZ4ozxta2MXQWAvR5Xfjv2shg9Bx9cvT"
      , mp3Url = "https://drive.google.com/uc?id=1xp5dKQCLGxxdYtI8FmCpxKInmVY2yQGP"
      , title = "亜麻色の髪の乙女(ヴィレッジ・シンガーズ。あまいろのながいかみをかぜが)"
      , filename = "amaironokami.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1853bZ3RLa_-A16Zqd18m_dsbBshMujkb"
      , mp3Url = "https://drive.google.com/uc?id=18h4bIBi_UYOSOwH0dH1puReyCZFYWKj5"
      , title = "カントリー・ロード(かんとりーろーどこのみち)"
      , filename = "countryroad.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1EW8U886L9jqdG-DmnlFXweQLgxPDQm61"
      , mp3Url = "https://drive.google.com/uc?id=1NvxcOW3XfsGmbw4ASpKZTxPljlo98wSl"
      , title = "イエスタデイ・ワンス・モア(カーペンターズ)"
      , filename = "yesterdayonce.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1rK9xSFpnZ-mVz4BFCVAe4VQUdZacoYcb"
      , mp3Url = "https://drive.google.com/uc?id=1pbUzmGLfj5n23CEx9OanXdy4NUhZ7XCZ"
      , title = "たこのうた(たこたこあがれ)"
      , filename = "takotako.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vHoatud8GL2tGaGFbuz-fc5FySfZ-uyI"
      , mp3Url = "https://drive.google.com/uc?id=1k1a_-yvWssztDePXzVzWAm-N5Zzt_tdE"
      , title = "チューリップ(さいたさいたちゅーりっぷのはなが)"
      , filename = "tulip.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jlRhWy7kdIhergO6-cjnb6Th-Uyt-2Fz"
      , mp3Url = "https://drive.google.com/uc?id=1Q2KNpLnyiMMWMG5QYKP7adXXGKr0URZu"
      , title = "鉄腕アトム(そらをこえてららら)"
      , filename = "tetsuwan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hzFWYgZcfAnCkl4EYAOAdAsaP2lnghAS"
      , mp3Url = "https://drive.google.com/uc?id=16WJ8vbWNWXSGHYlPXtk7aY3jYSvC2mgN"
      , title = "手をたたきましょう"
      , filename = "tewotata.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1j4Xq9iU_IS4o6RLZIn8EuPlEXG6D1qEW"
      , mp3Url = "https://drive.google.com/uc?id=1XpNvTdHJxoY6kpauEdobLfrtmnhZhuP4"
      , title = "たなばたさま(ささのはさらさらのきばにゆれる)"
      , filename = "tanabatasama.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1LHP_RpWF-hSWb4IUMIXTfuiETn1gtqBo"
      , mp3Url = "https://drive.google.com/uc?id=1X3nfZgOn2rnD-BzTDo60O-mHoPNS7L7D"
      , title = "つき(でたでたつきが)"
      , filename = "tanabatasama.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1oP0q9blYIYqd8iI8qUvLfGflzL_lYQS2"
      , mp3Url = "https://drive.google.com/uc?id=1k_ogeiXqZO1t2j2blp_YXAPXCGhZ-WAT"
      , title = "アイアイ(あいあいあいあいおさるさんだよ)"
      , filename = "aiai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1x04LCyD7W7PGX-CfFc7nHJQrcz52vKub"
      , mp3Url = "https://drive.google.com/uc?id=1iQ1fIS_kb-gO76rEvZYRzpnHfIvV0JUI"
      , title = "愛国の花(ましろきふじのけだかさを)"
      , filename = "aikokunohana.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1sZLBoet1rQY2KpaEY-oiOTnuDUujnXho"
      , mp3Url = "https://drive.google.com/uc?id=1aCn5JSJsR_FWh3NK9gd9HXOnc_SA-JV7"
      , title = "赤城の子守唄(なくなよしよしねんねしな)"
      , filename = "akaginokomoriuta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zOwlo4l0G0j4_7iLBEURm7BxwE2FCWGT"
      , mp3Url = "https://drive.google.com/uc?id=1SQfGOXhNEMp6SgZqQ6kBFgIjXrK6vOhn"
      , title = "暁に祈る(あああのかおであのこえで)"
      , filename = "akatsukiniinoru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1v9Alp-27jquhozHihi0BWjtnRPU3Pae0"
      , mp3Url = "https://drive.google.com/uc?id=191copT2VibT0H4sWQwIxrOTp1IRqKGbw"
      , title = "アマリリス(みんなできこうたのしいオルゴールを)"
      , filename = "amaryllis.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1OMEmVbQmVeBBnNWB606QmkvR0hdT-r70"
      , mp3Url = "https://drive.google.com/uc?id=1Ickl_2Sh7BefCKRaC8HeKkPixioGiL5O"
      , title = "アルプス一万尺(あるぷすいちまんじゃくこやりのうえであるぺんおどりを)"
      , filename = "alpsichiman.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1PP7CFxRwKtwUhEsDN4HhUB5zHJBNQJ0L"
      , mp3Url = "https://drive.google.com/uc?id=1jZi0sumxmgzh7RtNz4HYwispequell5M"
      , title = "あわてんぼうのサンタクロース(クリスマス)"
      , filename = "awatenbo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13MeHhukH6xGmoKamFD4S83lt_3jDQGV0"
      , mp3Url = "https://drive.google.com/uc?id=1GW5ROHCU-UgY1VUNF6hOsNxSFIBBl5Ez"
      , title = "故郷を離るる歌(そののさゆりなでしこかきねのちぐさ)"
      , filename = "kokyowohanaruru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1PdO8UWaf4jVljLpuAy8aOEUwmBKQa-h5"
      , mp3Url = "https://drive.google.com/uc?id=1hYS0PSgCJPO-v_3KQZrSCqnUYO9_6NCO"
      , title = "高校三年生(あかいゆうひがこうしゃをそめて)"
      , filename = "kokosannensei.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1NTRw5ZV5sabMKj3_HwIafJSg_6UbFj9a"
      , mp3Url = "https://drive.google.com/uc?id=1sFTI-Rj04SqB0NHU-XYmJawAeM0JzV5m"
      , title = "げんこつやまのたぬきさん"
      , filename = "genkotsu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ZJw9F-jWm0w_JNT4FFaeCsFB75Zgzv0G"
      , mp3Url = "https://drive.google.com/uc?id=12szTF4rbz_95LXqq_MnipIe4mHH_95OI"
      , title = "ああそれなのに(そらにゃきょうもあどばるん)"
      , filename = "aasorenanoni.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1JYPnxgIPN_bxlCZDiyytkP_r3880bvrD"
      , mp3Url = "https://drive.google.com/uc?id=1K4TQFXgt53K93O0hQARD4Ness4BKWMQL"
      , title = "青い背広で(あおいせびろでこころもかるく)"
      , filename = "aoisebirode.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1pQzWz4mfkxYAiQxflPuNCsPJ510zQp07"
      , mp3Url = "https://drive.google.com/uc?id=1CxVD87Z8zOzDIoahhuYZgKulypMvt8yq"
      , title = "長崎の鐘(こよなくはれたあおぞらをかなしとおもうせつなさよ)"
      , filename = "nagasakinokane.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1U66InKL9npmROU8XUlVTYmJKhuZp3B4q"
      , mp3Url = "https://drive.google.com/uc?id=12TdhLx5SrVq0J2tdkNvbuv6Otf67tevE"
      , title = "長崎物語(あかいはなならまんじゅしゃげ)"
      , filename = "nagasakimonogatari.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1awuxwfziK58bbfoZENpV0AdGs9k9WYjj"
      , mp3Url = "https://drive.google.com/uc?id=12DqY7QpcHmTPmOKR9e2qisWw3nXj3bDW"
      , title = "ないしょ話(ないしょないしょないしょのはなしはあのねのね)"
      , filename = "naishobanashi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ZlUnwrNg5XUOAxY1nVaCJy_m7O7lUfw3"
      , mp3Url = "https://drive.google.com/uc?id=1lvvuDcLxS-woaFsoTwnyOeAkuWuk7uMU"
      , title = "とんび(とべとべとんびそらたかく)"
      , filename = "tonbi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MsTYw8MLXZiL2SfhofjIsqdbSoA5auqr"
      , mp3Url = "https://drive.google.com/uc?id=1tYmZ2sVI5HI5gKl2tUCE6dpizNWjAmLr"
      , title = "トンコ節(あなたのくれたおびどめの)"
      , filename = "tonkobushi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=16LQGzN4BDgm-Txa6RGtLbRCHietXqx1y"
      , mp3Url = "https://drive.google.com/uc?id=1XSW09EYOEjffm-PCVPSCzQznw6GqNE2B"
      , title = "隣組(とんとんとんからりととなりぐみ)"
      , filename = "tonarigumi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hT4qCwQ9Xmvb4jrjLkw61TkxjhAPTGN_"
      , mp3Url = "https://drive.google.com/uc?id=1Jl1RsrTooii0sgx4_rTzpMmgI1UiKFrF"
      , title = "どこかで春が"
      , filename = "dokokadeharuga.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1UkjEGNtTjuY-U0UdsZE5W8Ac84GJfZo2"
      , mp3Url = "https://drive.google.com/uc?id=1DusYJosZSNMid1R6RRXHXzBPHi0nGWBW"
      , title = "通りゃんせ(とおりゃんせとおりゃんせここはどこのほそみちじゃ)"
      , filename = "toryanse.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xrFn9jbVin6nG05-5wR8VBNoBCaQO2xp"
      , mp3Url = "https://drive.google.com/uc?id=1seVQLSfi-ujiWpBW2_dAxNALtGRVCmr0"
      , title = "天国に結ぶ恋(こよいなごりのみかづきも)"
      , filename = "tengokunimusubukoi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1C5BHdxtJgBx3D3rw6LQxDv6ih6Z5KcYt"
      , mp3Url = "https://drive.google.com/uc?id=1N-RXZ3mlKd-ZjijXqPTNfC6wn3ugLN_e"
      , title = "われは海の子(われはうみのこしらなみの)"
      , filename = "warewaumi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1E3Ll7wE3YQ8S_Wqj5H-fh1NoxpJV_fZ2"
      , mp3Url = "https://drive.google.com/uc?id=1SWixMVXncKkpZXORY3qqnu0mb0_I29Wq"
      , title = "喜びの歌(はれたるあおぞらただようくもよ)"
      , filename = "yorokobi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1pujCfxMZVMaYkZAz_4SlqEQLDQzNLWwY"
      , mp3Url = "https://drive.google.com/uc?id=1Cb04QLvT3UvuhX8MhABmyNAIZ7Vp_nD2"
      , title = "夢路より(ゆめじよりかえりてほしのひかりあおげや)"
      , filename = "yumejiyori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1pHUnNWGV5wjBc4jmfCQmga5hZNmdlxcr"
      , mp3Url = "https://drive.google.com/uc?id=10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY"
      , title = "湯の町エレジー(いずのやまやまつきあわく)"
      , filename = "yunomachieleby.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qVX7IPcTVTOrnNrKEf90ZeMAKq0b9MaZ"
      , mp3Url = "https://drive.google.com/uc?id=19GeCGxKLE6evrE0z0YLyK3o0zQK1A0iC"
      , title = "雪山讃歌(ゆきよいわよわれらがやどり)"
      , filename = "yukiyamasanka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=183GpC0-bxi3hqEuITo5DvZDjzIIl4WzN"
      , mp3Url = "https://drive.google.com/uc?id=1cYBC8QH3h_4Mg7lVlbZADiLQX374oCuU"
      , title = "夕日(ぎんぎんぎらぎらゆうひがしずむ)"
      , filename = "yuhi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1WEKzSiq-UNkRsxVRxe5x7x_L9bSPZ7N5"
      , mp3Url = "https://drive.google.com/uc?id=1M8VV8Z-TiMJ7dp1vbzxH28f488ghabs1"
      , title = "東京音頭(とうきょうおんど。はあーおどりおどるならちょいと)"
      , filename = "tokyoondo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Qa-4hVWdLYZz_2LM40ej8iLj5gQrRkc2"
      , mp3Url = "https://drive.google.com/uc?id=18DUNRRaJNYLqn5_kiPC4S5V_25uYMcdO"
      , title = "ローレライ(なじかはしらねどこころわびて)"
      , filename = "lorelei.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1S_KO2NsVQnUtwykXph6T5-LBKrbUfz6Q"
      , mp3Url = "https://drive.google.com/uc?id=1wnsrGB4hpE1lrxJgtpGve6lQVy6osVZm"
      , title = "露営の歌(かってくるぞといさましく)"
      , filename = "roeinouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MeMTWmbSMO59jgPDmNNPzSuIYnGptIBW"
      , mp3Url = "https://drive.google.com/uc?id=1ty_VQhVCQMT1b0EF_CenqsEPT0ZLWNXG"
      , title = "リンゴのひとりごと(わたしはまっかなりんごです)"
      , filename = "ringonohitorigoto.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hfAydttdTrvhwG9hzAPtsetwWJlFzT5R"
      , mp3Url = "https://drive.google.com/uc?id=1tJjKuEk2qGQcCdnEvanI7ZKC85SB-tc4"
      , title = "リンゴの歌(あかいりんごにくちびるよせて)"
      , filename = "ringonouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1KO1lpvy2FdbZbUDjpXlby2tAXaeLBMmt"
      , mp3Url = "https://drive.google.com/uc?id=1BRU-xzQU5tjz41rWMpcKYF1gzFrIBv6r"
      , title = "旅愁(ふけゆくあきのよたびのそらの)"
      , filename = "ryoshu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=16tauHVEefEK8Jqbc-g1A-lkWB1hsLyQF"
      , mp3Url = "https://drive.google.com/uc?id=1FygfukFnx8hG7pC21c_-s7DILxSJJlkm"
      , title = "柔(かつとおもうなおもえばまけよ)"
      , filename = "yawara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1UZbd4XAhTD5DWrT_LpMNasXX3iZRXYcy"
      , mp3Url = "https://drive.google.com/uc?id=1Abq4PrC_o7O5t7s_r9npCENWXOlEEBHO"
      , title = "森の水車(みどりのもりのかなたから)"
      , filename = "morinosuisha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-WJ1AN-4PyTAt6q5mlWuSsgq1venZJwh"
      , mp3Url = "https://drive.google.com/uc?id=1ZwAdHJKCD98e9XvLCP7LtTYCa5cfSvRq"
      , title = "桃太郎(ももたろさんももたろさんおこしにつけたきびだんご)"
      , filename = "momotaro.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13QuxkMVg1gDLKGGRMHJ4z-cvBWLeVU0g"
      , mp3Url = "https://drive.google.com/uc?id=1HpWU1ALfTSgFY-j6L6q5UbK2fU7Lqs0v"
      , title = "村の鍛冶屋(しばしもやすまずつちうつひびき)"
      , filename = "muranokajiya.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1QD03rIqSg_7TY_NXX0GdmfLUYD7ZgwKo"
      , mp3Url = "https://drive.google.com/uc?id=1oui6DyXrqYWAMrvSL1SeHXVTEsP_s8OZ"
      , title = "むすんでひらいて(むすんでひらいててをうってむすんで)"
      , filename = "musunde.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1RfceWQRNBrLtbUQ1fmRimF1Y0vz1lSiD"
      , mp3Url = "https://drive.google.com/uc?id=1wXhWbAbGfd0UxSKPcZa87-bM-lt-bUga"
      , title = "仰げば尊し(あおげばとうとしわがしのおん)"
      , filename = "aogeba.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1bA3q21dNRaqtc8LY7BjmkGE9I3j6xLX6"
      , mp3Url = "https://drive.google.com/uc?id=1mXIa3E4212g41CWLdoveCZ7yhMc8i_UM"
      , title = "あの町この町(あのまちこのまちひがくれる)"
      , filename = "anomachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hp_gGB3M228_JcyOm15zgoaXXWxmBEfA"
      , mp3Url = "https://drive.google.com/uc?id=1hdy6zjR0_VlMS6EejWcXQjHPgau89oAX"
      , title = "雨(あめがふりますあめがふる)"
      , filename = "ame.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10zAOp0w-5JZMEbUanYHw1VrWVu_7Wz-A"
      , mp3Url = "https://drive.google.com/uc?id=1bCcxaVcVFVf5LknsTh-EjM2zt3n4Tdlu"
      , title = "一寸法師(ゆびにたりないいっすんぼうし)"
      , filename = "issunboshi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1tGiA9HoEqIR-oCC14mAppe1wlPJSRd5x"
      , mp3Url = "https://drive.google.com/uc?id=1An1JMg3PBChR5oh_x6YeWfQ35kw6_50y"
      , title = "うさぎ(うさぎうさぎなにみてはねる)"
      , filename = "usagi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hPec2PBNt7JOfUQeC-2D4oj7xalvbMX-"
      , mp3Url = "https://drive.google.com/uc?id=1W0FziUExLRv5uZAQx0mkSyCQNS4j8Chf"
      , title = "兎のダンス(そそらそらそらうさぎのだんす)"
      , filename = "usaginodance.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1N7v9vUBjneGOBkYCld1loJLpJm-4Tvy7"
      , mp3Url = "https://drive.google.com/uc?id=1EYX9vEimFxmheBcfSW6yYeKeWn3wr7tF"
      , title = "別れ船(なごりつきないはてしない)"
      , filename = "wakarebune.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1KIpmWnqaydeM4DJvBzNwCrxVeptIJOnZ"
      , mp3Url = "https://drive.google.com/uc?id=1ukG2ddTIjNxixk3wFcxuHa6LoaERkOZ9"
      , title = "水色のワルツ(きみにあううれしさの)"
      , filename = "mizuironowaltz.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1H8-GLzC9Q_HPfPuP48xLLbmU_EQtMXcd"
      , mp3Url = "https://drive.google.com/uc?id=1I67md4E3xmihAW4NUtkpxMSBhuFFiwSj"
      , title = "啼くな小鳩よ(なくなこばとよこころのつまよ)"
      , filename = "nakunakobato.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=15cr3drUT2jqko4x9EFIcAydXJHX78bv9"
      , mp3Url = "https://drive.google.com/uc?id=1KPPux4R0iWYFLmgXkT3nlp7S0ARO4gsm"
      , title = "人形(わたしのにんぎょうはよいにんぎょう)"
      , filename = "ningyou.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=12KlKLNy7qB5zYJpw_h-HfSsK_D1BoIAc"
      , mp3Url = "https://drive.google.com/uc?id=1-EnDUJAs3H2mXxAuQUNTThOwEqwr2aeZ"
      , title = "おうま(おうまのおやこはなかよしこよし)"
      , filename = "ouma.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1nCI0J-uQi3JjOF8r-6cAlbdrtLe6IuOg"
      , mp3Url = "https://drive.google.com/uc?id=1fJlzuVAvv8HlLFnfEAZAYFKlzrcCrm_w"
      , title = "お江戸日本橋(おえどにほんばしななつだち)"
      , filename = "oedonihonbashi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kJ4b3-OR4Ss4H2kTDFFuvvs_7pOa7f9n"
      , mp3Url = "https://drive.google.com/uc?id=1zGxhzgyQzCioWc2q-ndPsngTc31B62Wl"
      , title = "男の純情(おとこいのちのじゅんじょうは)"
      , filename = "otokonojunjo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1VvglMG-PgfxVGFVSdbItP5YT2Yk8S7N-"
      , mp3Url = "https://drive.google.com/uc?id=1zYbflXUGPh9uanDKb0fUtFgBKess3CED"
      , title = "籠の鳥(あいたさみたさにこわさをわすれ)"
      , filename = "kagonotori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1usM9Vb2MzX23QXM9TgS2MM-koleuoqQ2"
      , mp3Url = "https://drive.google.com/uc?id=1W3TCfx2EcpHzwAZoTjEx8-Pd_9VUg7BO"
      , title = "霞か雲か(かすみかくもか)"
      , filename = "kasumikakumoka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1o1OpPnfjETSYry01NqLgs-KFQ3xXl6T7"
      , mp3Url = "https://drive.google.com/uc?id=1htBCrCocgK3yEJUEMIcuiPw80Y0vj6NJ"
      , title = "愛国行進曲(みよとうかいのそらあけて)"
      , filename = "aikokukoushinkyoku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11cN2dGIaIQ5ettwV6w__RjUdgOvgnGaA"
      , mp3Url = "https://drive.google.com/uc?id=1tfd7nMuibpLTtRt16BVpk_RHjXoBtd_s"
      , title = "かなりや(うたをわすれたかなりやは)"
      , filename = "canary.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1FKW6HVsOWC13OeY-wQFoBO52eNV6P0Mk"
      , mp3Url = "https://drive.google.com/uc?id=1aN36sgqSVuMOc1RQJsjMtzs6B2xmFVmE"
      , title = "鎌倉(しちりがはまのいそづたい)"
      , filename = "kamakura.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zq8n5GytjTfsVNOhZR9ElRdTN5vq4M6e"
      , mp3Url = "https://drive.google.com/uc?id=1e3PqIRk1uLk0ykS9S2htaLznGfnIKDrU"
      , title = "祇園小唄(つきはおぼろにひがしやま)"
      , filename = "gionkouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1sNMDchceP9jQIShFLTEIOJFBNW7yrmsn"
      , mp3Url = "https://drive.google.com/uc?id=1Ap1Ujj2e6h37hCgCMO9C32j5_xFjv2z_"
      , title = "こうま(はいしいはいしいあゆめよこうま)"
      , filename = "kouma.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dtUw5I9-JKGwjpnLe4lYKtMpY4wneB3H"
      , mp3Url = "https://drive.google.com/uc?id=1RZD7C6eRljOnZJDszAw2kNW4h6z9XjCO"
      , title = "お富さん(いきなくろべいみこしのまつに)"
      , filename = "otomisan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Cp87RUb0_YPHyj0peMqrJk3TWaUEQzbz"
      , mp3Url = "https://drive.google.com/uc?id=1atDmXTGnCXFjeqIwUdFMAZoloO1icviB"
      , title = "いい日旅立ち(ゆきどけまじかの)"
      , filename = "iihitabidachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1U8KS0x8Ocura_eZkJ0d2d0s0sJZgSEVK"
      , mp3Url = "https://drive.google.com/uc?id=1sCNJpF5SyRto08gQGy_6aW2-zpK03G_G"
      , title = "アラビアの唄(さばくにひがおちて)"
      , filename = "arabianouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1SPUkVZ6_VJgjr4q1lJEFwoFzF_p6zJj6"
      , mp3Url = "https://drive.google.com/uc?id=1LpspAcK4dttEfSF4zNXX_uzVzK-wsFpV"
      , title = "ハバロフスク小唄"
      , filename = "khabarovsk.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1EAqRgKfmM0e8tS4LkMP5VqoFl5YzHFBe"
      , mp3Url = "https://drive.google.com/uc?id=1qqpxzmEDIL_Vp1JPBpekRNIiupQvLXNl"
      , title = "人を恋うる歌(つまをめとらばさいたけて)"
      , filename = "hitowokouruuta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ClwkIMpH2qBfCwfeVIMqg-OvDI7hdDQT"
      , mp3Url = "https://drive.google.com/uc?id=1yLyidhYX6dVZz-XpRvv8983bAL0dxOrZ"
      , title = "蛍の光(ほたるのひかりまどのゆき)"
      , filename = "hotarunohikari.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1plrEKN8Y5UpH2eBuUktHxC90RKtO40Wd"
      , mp3Url = "https://drive.google.com/uc?id=1qQayn5QyVOgbhaKz--S9-sq0eOuDmVlb"
      , title = "麦と兵隊(じょしゅうじょしゅうとじんばはすすむ)"
      , filename = "mugitoheitai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dpX8iyiBkPMtU-NVfy-nR6B19kokuhE-"
      , mp3Url = "https://drive.google.com/uc?id=1BGF7fh9GuirKEX7ivBBLAiVv2zN9HYZH"
      , title = "たばこやの娘(むこうよこちょうのたばこやの)"
      , filename = "tabakoya.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1iWre5qvGBvkhXLZWUfL4v-eSDcKnSWk9"
      , mp3Url = "https://drive.google.com/uc?id=10CmpPNP-U7Ui4UMuKpIj_SejtZolx3fz"
      , title = "戦友(ここはおくにをなんびゃくり)"
      , filename = "senyu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1UrQznxPpZ9kUg5vEefe3dCDizDdyDD2D"
      , mp3Url = "https://drive.google.com/uc?id=1CmtL7-YmNxGsdCjD__Oay9o3S01Mxu9X"
      , title = "聖夜(きよしこのよる)"
      , filename = "kiyoshi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1do7NA3n64U9sFnYVlUZzTfnT_LDxu6RQ"
      , mp3Url = "https://drive.google.com/uc?id=1zPpRO5xKwJdogi-ayU2PJGTi1_PmceVf"
      , title = "水師営の会見(りょじゅんかいじょうやくなりて)"
      , filename = "suishiei.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1icO60KbahCHOqYgTzw8zwlK_UVp5PWm4"
      , mp3Url = "https://drive.google.com/uc?id=1ATE2aqVZfk_p9MdqjlLsmVY-g73aa-y8"
      , title = "ああモンテンルパの夜は更けて(モンテンルパの夜は更けて。Muntinlupa, フィリピン)"
      , filename = "muntinlupa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1bfgHqSUyLOA3qWtoxOVv_6yCn1_ZOfmw"
      , mp3Url = "https://drive.google.com/uc?id=1bQ9x8vhGDTvSKQlJOfMHB-fSleB6aEGa"
      , title = "君の名は(きみのなはとたずねしひとあり)"
      , filename = "kiminonawa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qCclnMVCVXqlnisSweNSRDXRH7Rr9d7G"
      , mp3Url = "https://drive.google.com/uc?id=195AS_p7wHipTgNWM39lRWm24US5uunhD"
      , title = "燦めく星座(おとこじゅんじょうのあいのほしのいろ)"
      , filename = "kirameku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1sXkqylmP0GKWctzx8CO69GJLp8HB3oMb"
      , mp3Url = "https://drive.google.com/uc?id=1-DNvDUoLpfrMbM4KriXxiOfzHtU7ABam"
      , title = "宵待草(まてどくらせどこぬひとを)"
      , filename = "yoimachigusa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1rNqYGsaFWlP5lRNuE1Qi19Y09nxZjQBb"
      , mp3Url = "https://drive.google.com/uc?id=1pTCmB9DTSI296H62MVIvV0XsHJSJD-dn"
      , title = "懐かしのブルース(ふるいにっきのぺーじには)"
      , filename = "natsukashinoblues.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1wvU2JWhVd6tLlPT48dE-HFLLh1CnV3GV"
      , mp3Url = "https://drive.google.com/uc?id=1Cb3BnafN8_UZQ9-TTjnCmPQquDIVRCE8"
      , title = "悲しき口笛(おかのほてるのあかいひも)"
      , filename = "kanashikikuchibue.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1TtXPS75SZqz3dkCIHobOD4bLR3SsdXCy"
      , mp3Url = "https://drive.google.com/uc?id=14xcC1aCDj9U5iZGjjtMHfmZhiOXUVsJs"
      , title = "ジングル・ベル(クリスマス。のをこえておかをこえ)"
      , filename = "jinglebell.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1HlhevszRm1pJl8UH-IlIvgFKxBDDXuQB"
      , mp3Url = "https://drive.google.com/uc?id=17lJ_XLyiXrrQfcEgrWm06YSuT9QCEPFt"
      , title = "勇気100パーセント(がっかりしてめそめそしてどうしたんだい)"
      , filename = "yuki100p.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1sfJUZjg2MESyNLjq7PLbO6dicXMJK-kw"
      , mp3Url = "https://drive.google.com/uc?id=1BZXK0i7BXIIiHaobvKnSNmTz6WFilB5i"
      , title = "好きだった(すきだったうそじゃなかったすきだった)"
      , filename = "sukidatta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zyDxoe-DpBTbVDM-EB-d6LeY13G1u4xn"
      , mp3Url = "https://drive.google.com/uc?id=1AxMqUgTfL4NyVsBdLA-FY89c8EL11NJA"
      , title = "四季の歌(はるをあいするひとは)"
      , filename = "shikinouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Oph1R4qvAVvvphHxlZJ4Rpob-ZBnzUpx"
      , mp3Url = "https://drive.google.com/uc?id=18t43GAZWMFEtBX1zaK-Fn1e5sB1ZLrlZ"
      , title = "仲よし小道(なかよしこみちはどこのみち)"
      , filename = "nakayoshikomichi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DoTSkiCA5-qhehIS1_9fwwQwK2k3U1ZC"
      , mp3Url = "https://drive.google.com/uc?id=1YXchgECNKskPYUTPNQtNopALvcSNJ5k8"
      , title = "ドレミの歌(どはどーなつのど)"
      , filename = "doreminouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1EwSgq9rXef_aPn-KNjJR8qw__mz1f2Wl"
      , mp3Url = "https://drive.google.com/uc?id=1nNbubE84_wM-BO4l3C6OQgbBqbcBFY8E"
      , title = "案山子(やまだのなかのいっぽんあしのかかし)"
      , filename = "kakashi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1D_5y_wxLYQeVc7oq_O4nkyLK9DTGaEeR"
      , mp3Url = "https://drive.google.com/uc?id=1Mhwb0IcHhUI376V8PcuqjcknaIBmB_8F"
      , title = "影を慕いて(まぼろしのかげをしたいて)"
      , filename = "kagewoshitaite.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1bf265Ya1sYMbR3Fk8WNJfKHO3Ujlm0ol"
      , mp3Url = "https://drive.google.com/uc?id=10AAQ6JoGnOZKrO_RZhoCGmjy6VYzxd4x"
      , title = "鞠と殿さま(てんてんてんまりてんてまり)"
      , filename = "maritotonosama.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-Yk5FPtggwtSJwLGOfOo66OUhIYTT4gY"
      , mp3Url = "https://drive.google.com/uc?id=1ylKBBuGZmq1Q2XKPLB5H89KvHkByIuqM"
      , title = "真白き富士の嶺(七里ヶ浜の哀歌。ましろきふじのね)"
      , filename = "mashiroki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DsROegZvXPMpuqkr28ptuAjgpz7Mtaf_"
      , mp3Url = "https://drive.google.com/uc?id=1Po48fBznv9MewAAc89pr01muJdAAHhco"
      , title = "学生時代(つたのからまるちゃぺるで)"
      , filename = "gakuseijidai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Luq-ywo6fVTn-PAx0P8Fbm5vW8QIlHcD"
      , mp3Url = "https://drive.google.com/uc?id=1cAUMJMb9AjAjnzEZt5k9LKM9P1IifMMv"
      , title = "三百六十五歩のマーチ(しあわせはあるいてこない)"
      , filename = "sanbyaku65.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=172CKkz1-8tDByGfHyg0ZH9CM3TN0m8hi"
      , mp3Url = "https://drive.google.com/uc?id=1IXzWrvyJIyKLtnMID0kWmtNjY21VOVoa"
      , title = "別れのブルース(まどをあければ)"
      , filename = "wakarenoblues.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14C6WWx8k8OYSs6UU244wgbXCKvXxtjx2"
      , mp3Url = "https://drive.google.com/uc?id=1gx8EPfjmsskIsDBp_WCiIIlZ5gjJG6FK"
      , title = "桑港のチャイナタウン(さんふらんしすこのちゃいなたうん)"
      , filename = "chinatown.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1tPI-ovIXxvbVma7dRDETM4YPRToU_qOh"
      , mp3Url = "https://drive.google.com/uc?id=11m0ZthymUS3WE3sdegBtjIEKETGt-AgA"
      , title = "さんぽ(あるこうあるこうわたしはげんき)"
      , filename = "sanpo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13-I4Y5-EOrZ3asCKG_u-9gjqqys2RJjq"
      , mp3Url = "https://drive.google.com/uc?id=1xL83PTGp8RRd0OCwcRFK52iU-Bv8PVnW"
      , title = "森の小人(もりのこかげでどんじゃらほい)"
      , filename = "morinokobito.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1t2Wv1nPtZ0r9qe1QPKGFvZStGksy-gcU"
      , mp3Url = "https://drive.google.com/uc?id=14NVcygyC4bHevi3L6RrYghDV9z4qI-at"
      , title = "若鷲の歌(わかいちしおのよかれんの)"
      , filename = "wakawashinouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jYMPozc7GJjBxl-Rwryy1GsH1Vld-9ES"
      , mp3Url = "https://drive.google.com/uc?id=1iHY9QxXOt0xTBjP3aIjMI_O9nSqOegKs"
      , title = "冬景色(さぎりきゆるみなとえの)"
      , filename = "fuyugeshiki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1T032yPDEzKObjlSbGFGOXuwTxwZq8YcH"
      , mp3Url = "https://drive.google.com/uc?id=1N3REHPL99O7qyBHhov3xFX8VctUWOKhi"
      , title = "翼をください(いまわたしのねがいごとがかなうならば)"
      , filename = "tsubasa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zEpwec3XOmAqdqneKfnWAHXWmeDrDa-1"
      , mp3Url = "https://drive.google.com/uc?id=1bqQLoa4Fb4YeRTJNRH96djPd5BPP0nnC"
      , title = "青い目の人形(あおいめをしたおにんぎょは)"
      , filename = "aoimewoshita.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=16LMZSt3VBo-Q1czxD4Tg16Qpj2ew2_7b"
      , mp3Url = "https://drive.google.com/uc?id=14oMTiUp9Rga9OG-pNB9UogM4wpNHq1L6"
      , title = "もみじ(あきのゆうひにてるやま)"
      , filename = "momiji.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1mP8wdlTbXjXzwyY4zH2IQYUkJDw-CnUI"
      , mp3Url = "https://drive.google.com/uc?id=1X00S4Op49l2S3WozFl2-t9LqZ_gwCV_G"
      , title = "美しき天然(そらにさえずるとりのこえ)"
      , filename = "utsukushikitennen.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DxCjI9fGPli_2U6MnAz1Fgh4v3fKAthC"
      , mp3Url = "https://drive.google.com/uc?id=1XKERMhIY_LOgW8v3b5AYOJRKqd4FECsM"
      , title = "青い山脈(わかくあかるいうたごえに)"
      , filename = "aoisanmyaku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1srLJLOFrmkGWqDebdaICn5Efjjw-G5BT"
      , mp3Url = "https://drive.google.com/uc?id=1ty_eWfUlyCkYe0OEAngxtI-Fl49ab9Bv"
      , title = "上を向いて歩こう(うえをむいてあるこう)"
      , filename = "uewomuite.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kcL4DhyqlYQfS7eM1KbUmyZIaQQfZ4nw"
      , mp3Url = "https://drive.google.com/uc?id=1zcm6wqdWmkp2Rpuun61ZE4SOJPCbn6wf"
      , title = "ふるさと(うさぎおいしかのやま)"
      , filename = "furusato.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1543rLp3RFm3Ih3UpO83UpgaIZe1QC1R4"
      , mp3Url = "https://drive.google.com/uc?id=1tdgfvcYJbYfPD1HmcnK4DIKxfZ1N-6Js"
      , title = "美しき(うつくしきわがこやいずこ)"
      , filename = "utsukushikiwagako.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1x5bSOD6ImLfX9AeUfw_RQQiY0JJP2S0L"
      , mp3Url = "https://drive.google.com/uc?id=1x1oZX26krFxvopVrc85HV_9i3RQdmYvD"
      , title = "浜辺の歌(あしたはまべをさまよえば)"
      , filename = "hamabe.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1EWvGQAdTt7qi2iQGIqrIqDRgO-6HGbUP"
      , mp3Url = "https://drive.google.com/uc?id=1YJWJN3qfo-M8oAg3kGEzJlm2XR4Kgzep"
      , title = "歌の町（よい子がすんでるよいまちは）"
      , filename = "utanomachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=16mJlcIdAOTn856x2VNCp5LkWybzjeeFf"
      , mp3Url = "https://drive.google.com/uc?id=1j-w1g6Uthw3el-2xvI3PPjf2Q7UAa-nU"
      , title = "叱られて(しかられてあのこはまちまでおつかいに)"
      , filename = "shikararete.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kbATpiDtifPkyCLV_of33XCT1IrJF0ZV"
      , mp3Url = "https://drive.google.com/uc?id=1xiSAG-qNSQ57Uf5LGZ5FpaUXT24nbu8i"
      , title = "少年時代(なつがすぎかぜあざみ)"
      , filename = "shonenjidai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Etn8jnoBUBysLuQL3JjrPeqOi8A-oz3L"
      , mp3Url = "https://drive.google.com/uc?id=1DPaewK8L4fUTAgO27LSZU74LdCVVy0SE"
      , title = "ペチカ(ゆきのふるよはたのしいぺちか)"
      , filename = "pechka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=15GFgLIcsMuXpvrXFeke_-5n_sGuhgyj3"
      , mp3Url = "https://drive.google.com/uc?id=1Zk-mEbKwkAkS1Mv3739Fp39BkyjNNWW8"
      , title = "ハイ・ホー(くちぶえをげんきにふきならし、ディズニー「白雪姫」)"
      , filename = "heighho.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1yNb_hgcUcS2yhL6y-C0IR3RkP14gw5zH"
      , mp3Url = "https://drive.google.com/uc?id=1SKoTRAQEq_AJIMifawTAkLjsuNW3qODE"
      , title = "日の丸の旗（しろじにあかくひのまるそめて）"
      , filename = "hinomaru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=12r_phKOpMKpuuONT-yKQ-sUF7ga8wE9g"
      , mp3Url = "https://drive.google.com/uc?id=1ZQfodN3gM6BZuzSPBgK6kaZj_GJVTRa7"
      , title = "ここに幸あり(あらしもふけばあめもふる)"
      , filename = "kokonisachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1IHQftIQnW50VznxYsMYMFjFhIalkkufu"
      , mp3Url = "https://drive.google.com/uc?id=1GJMpEGadPsX0RXVdRRy89_kv_GGv-NDq"
      , title = "船頭さん(むらのわたしのせんどさんは)"
      , filename = "sendo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11P1bRPGgRe2jpHfyp8hf9YyzDFOhG_Uq"
      , mp3Url = "https://drive.google.com/uc?id=1pBWatBDUqpYCTsYn1QZYN3x8kfaCE7So"
      , title = "すみだ川(いちょうがえしにくろじゅすかけて)"
      , filename = "sumidagawa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xkwyezJS-y8bPioL7ETN1QKcxD56h_sK"
      , mp3Url = "https://drive.google.com/uc?id=1oX8_axx6ICXtSqQANokK8Q9ZUKhtU8u-"
      , title = "誰か故郷を想わざる(はなつむのべにひはおちて)"
      , filename = "darekakokyowo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1EpLVJ7bzYqjPltVv6onWcPOSWS4qkXXs"
      , mp3Url = "https://drive.google.com/uc?id=1hVZr4Wy-Lu-D37R7NlW0-2lDPORKqCt-"
      , title = "人生劇場(やるとおもえばどこまでやるさ)"
      , filename = "jinseigekijo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1iz8929aoeRwTZvK5krR8BXqwmiPRXB69"
      , mp3Url = "https://drive.google.com/uc?id=1liG2KJmpcKPVtNZmsQ2Ad-ItMq9JgQZK"
      , title = "若いお巡りさん(もしもしべんちでささやくおふたりさん)"
      , filename = "wakaiomawari.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1_Nrw6fjI7kzGwfu_kWvlYdn8kETyvc0B"
      , mp3Url = "https://drive.google.com/uc?id=1LM1PubosJqRlZ-pfOmGQDlf4JQU5n0X3"
      , title = "冬の夜(ともしびちかくきぬぬうははは)"
      , filename = "fuyunoyoru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1g6G2B8XsqxI08M9tPC05paFEz4G7s-J1"
      , mp3Url = "https://drive.google.com/uc?id=18AaVTO-KhW8IZz1egNzu1JoWOijt3liQ"
      , title = "軍艦マーチ(まもるもせむるも)"
      , filename = "gunkan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1uQUJJn-PM0HgyRuhoLylhQ927uIZA6A6"
      , mp3Url = "https://drive.google.com/uc?id=1KS4aY0fLc-zgijI_uiXUyJZXbEJ_oiT4"
      , title = "カチューシャ(りんごのはなほころび)"
      , filename = "katyusha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MsEND9XGBH660ijEQ9r5A6l7Bw_GWqOu"
      , mp3Url = "https://drive.google.com/uc?id=1qgAEpjx8F1EmmWmIoItpt0jNK0bRgR7l"
      , title = "世界に一つだけの花(はなやのみせさきにならんだ)"
      , filename = "sekainihitotsu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1q8O5il6q_k2L05yZbbPdyWtWHjc8-lcE"
      , mp3Url = "https://drive.google.com/uc?id=1RaXRO1Wm15RgDb4-SzFcqV_SfzpkI9Ys"
      , title = "春よ来い(はるよこいはやくこいあるきはじめた)"
      , filename = "haruyokoishoka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jY7CaJu4yIUqPHxcjFr9k4UtbakPnxRq"
      , mp3Url = "https://drive.google.com/uc?id=1JKMKdaea6SO5odqucNZhiTd4uKaxQVG1"
      , title = "トロイカ(ゆきのしらかばなみき)"
      , filename = "troika.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=17WuP5n3y6n-5iqswA_PBWmvQfKOZC0_L"
      , mp3Url = "https://drive.google.com/uc?id=11YlAGKXT1eChGaj-C2GCAC8eVeAwlaZZ"
      , title = "同期の桜(きさまとおれとは)"
      , filename = "doukinosakura.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1QsuVPLF3KES2r4HrlPek-tiHUsXdBwgv"
      , mp3Url = "https://drive.google.com/uc?id=1Nr2zhDDDZf3PqgLcn5OW5q0hhx5XRR-q"
      , title = "一週間(にちようびにいちばにでかけ)"
      , filename = "isshukan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1elUHV6YB0WZBuUFpzztZHYqAoCr4lLdL"
      , mp3Url = "https://drive.google.com/uc?id=1sb3nxFRAx9PyEHg1ZmGgtu6Ylna3gX4D"
      , title = "川の流れのように(しらずしらずあるいてきた)"
      , filename = "kawanonagare.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Y562qGRvd-9EtzTxCln2lJ3JibHBvtSo"
      , mp3Url = "https://drive.google.com/uc?id=1tU1Pwv5ZNx9HMF05se3s5q706FIUqosa"
      , title = "夏の思い出(なつがくればおもいだす)"
      , filename = "natsunoomoide.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1X6rWwnDJeB0XnPa7uIELgfJuYMpOAJEP"
      , mp3Url = "https://drive.google.com/uc?id=104FL3RcK0qNFSuB47sc0Gy27UHjm9hIP"
      , title = "線路は続くよどこまでも(せんろはつづくよどこまでも)"
      , filename = "senrowa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1RyCBQT1tLE85K105wqjsUwKrmVEbczVW"
      , mp3Url = "https://drive.google.com/uc?id=1-pa2-bO4FXGjr1XtN5vkeN044LGZPf4t"
      , title = "幸せなら手をたたこう(しあわせならてをたたこう)"
      , filename = "shiawasenara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zTMg2892LhGHQf8KexztjDtiDs9h4YEV"
      , mp3Url = "https://drive.google.com/uc?id=1T3NVl2cE1-2wIr4RcZ0wzmexnsnW-4ny"
      , title = "雪(ゆきやこんこあられやこんこ)"
      , filename = "yukiyakonko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1JNoF-kugRehnmt9aOFsl4AMwyrqP4Hlb"
      , mp3Url = "https://drive.google.com/uc?id=15Dskw1ZfGt9luey8zVQzLfGm4vFY_06o"
      , title = "北国の春(しらかばあおぞらみなみかぜ)"
      , filename = "kitaguninoharu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1mwJeR5_H0KobIRGDVxx4QQfCDSuf6Eap"
      , mp3Url = "https://drive.google.com/uc?id=1842fGkGa84TPaTIv0wY3BJ-B_g0bW725"
      , title = "静かな湖畔(しずかなこはんのもりのかげから)"
      , filename = "shizukanakohan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1CXei_dyBm7HTCZU4jRfKlcbzGQQJx3b7"
      , mp3Url = "https://drive.google.com/uc?id=1S2cSyO2u870rKDCauhm677VTpMBaRhuo"
      , title = "おもちゃのチャチャチャ"
      , filename = "omochanochachacha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1IPmAUz2yVFdoWEdcZS7adnRf-WR7CqBl"
      , mp3Url = "https://drive.google.com/uc?id=1qYT5CvoOyHHBWXxABjOk3rQVPK1H9ud-"
      , title = "こぎつね(こぎつねこんこんやまのなか)"
      , filename = "kogitsune.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xiY44B_PMrLuES0nSlDXMQU7mUbcegjG"
      , mp3Url = "https://drive.google.com/uc?id=18sn4HRldIKMaAq0EPeLCJ4gsmZlMHcVU"
      , title = "茶摘み(ちゃつみ。なつもちかづくはちじゅうはちや)"
      , filename = "chatsumi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=18JU_g7I6ZpdaWjVLDP52YuX35kwqrCgB"
      , mp3Url = "https://drive.google.com/uc?id=1VQY3djnR06RpibM4R_3tZzX5LfmRvtO8"
      , title = "たきび(かきねのかきねのまがりかど)"
      , filename = "takibi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1G8RoXsuV69aFQCFMo9q5edIX6E_Ytk76"
      , mp3Url = "https://drive.google.com/uc?id=1j7cLWnJ0BJQupkOXJhOtHGstO_ELiPOL"
      , title = "かたつむり(でんでんむしむし)"
      , filename = "katatsumuri.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1YYrhvvTdLosl6Zr3oxFzaJKcL7jRNwOh"
      , mp3Url = "https://drive.google.com/uc?id=1cm0S5tGC-yUK7sYuFP_knB9lAXB8IWfh"
      , title = "ほたるこい(ほうほうほたるこい)"
      , filename = "hotarukoi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dGxAqIWZJXOKKlp5lZ59Of_NHum1CPFu"
      , mp3Url = "https://drive.google.com/uc?id=1u5VNeym1x_1TSo8LRKhcN5F4aUX4NMJ0"
      , title = "ぶんぶんぶん(ぶんぶんぶんはちがとぶ)"
      , filename = "bunbunbun.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=12Rj4kg7S7PKdCnXLc2_xyiApjZ82w5Ky"
      , mp3Url = "https://drive.google.com/uc?id=1n4vPS1PVcR09hIeEnngs4YzLw6yMxfEb"
      , title = "とんぼのめがね"
      , filename = "tonbono.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1VQaM6zc6CrP05Vuap5cckvhpp2IXdPVc"
      , mp3Url = "https://drive.google.com/uc?id=186fahMimqSAbgc-24_R_ogjsrerNVfXw"
      , title = "お正月(もういくつねるとおしょうがつ)"
      , filename = "oshogatsu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1LoMlLfeZY6HGMABHn5rfm3ZYJn-Ekbt8"
      , mp3Url = "https://drive.google.com/uc?id=1guwbOZo8bSfw66PyXC2t4OdPViKtadRN"
      , title = "有楽町で逢いましょう(あなたをまてばあめがふる)"
      , filename = "yurakucho.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vqAe0tQMsuIuWLbG2im2O1FDHALBusYT"
      , mp3Url = "https://drive.google.com/uc?id=1W3Uj4G1xupngrcJjI773Nu7wefJXAl7U"
      , title = "だんご３兄弟(くしにささってだんごだんご)"
      , filename = "dango3kyodai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1shul0lHD5ktjmU7T1twXO26P47duc6hi"
      , mp3Url = "https://drive.google.com/uc?id=1jOdhUTybguaIK2O-25NrD7bxqkClKIII"
      , title = "チム・チム・チェリー(ちむちむにーちむちむにー)"
      , filename = "chimchimcheree.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1SmQYnELy7Qf6S-HLHitb1f7_z1hqzwPg"
      , mp3Url = "https://drive.google.com/uc?id=1GcyV-v2HA1z9UZoWV0dE9EHiadxIVk6r"
      , title = "星の流れに(ほしのながれにみをうらなって)"
      , filename = "hoshinonagareni.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1AC_Inh08SIPQcfk3o0dZbCTOvWu6BPEa"
      , mp3Url = "https://drive.google.com/uc?id=1HvoxTFUG58F_TgvbEgCbuReF9UIwtJXO"
      , title = "一月一日(いちがついちじつ、としのはじめのためしとて)"
      , filename = "ichigatsuichijitsu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1VHppJF6lbb08GC-90w6YACugdHqf54b-"
      , mp3Url = "https://drive.google.com/uc?id=1AQXeEqQyRw_IEDCC6fDz-Mo74NcdblLN"
      , title = "こいのぼり(やねよりたかい)"
      , filename = "koinobori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1pbm9b53o5LXPJYBLyIydku6ZxQf1FaYK"
      , mp3Url = "https://drive.google.com/uc?id=11AWOtUPoD3lo9-4_sHG65dILeHb-Xonv"
      , title = "この道(このみちはいつかきたみち)"
      , filename = "konomichi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1plGF2BUy6A1W3q_XkJ_0a89j27Fe2LKy"
      , mp3Url = "https://drive.google.com/uc?id=1dYYIxaHwSF6t4uxZuuT--0INe9A-WC7h"
      , title = "この世の花(このよのはな。あかくさくはなあおいはな)"
      , filename = "konoyonohana.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1d2xnCa8m97RywIk_m5CFyO4V0IluYyx6"
      , mp3Url = "https://drive.google.com/uc?id=1vDroijqShW2tf4bzOc72Zg-XbcvpsgU2"
      , title = "ミッキーマウス・マーチ(ぼくらのくらぶのりーだーは)"
      , filename = "mickeymousemarch.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1oEJxJ_m3wsvDtvSjQRcIUoxN2U4MaItv"
      , mp3Url = "https://drive.google.com/uc?id=1RbdbOoBqc0KBPtph1k1qnE7zG4RCC1OT"
      , title = "みかんの花咲く丘(みかんのはながさいている)"
      , filename = "mikan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1TU2CQlv639ZuRI4zFYAxpLRZ5DGyAg99"
      , mp3Url = "https://drive.google.com/uc?id=1KfcECeAU9dim-g8cb-dB391QiqvZl5b_"
      , title = "虫の声(あれまつむしがないている)"
      , filename = "mushinokoe.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1UbkY__rPUnMs3DPamim-VnN9WJifAwsl"
      , mp3Url = "https://drive.google.com/uc?id=1vCqmeM_3oHcPXc0TfcsbVKzGogqAPSQy"
      , title = "南国土佐を後にして(なんごくとさをあとにして)"
      , filename = "nangoku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1TBF2Et4ahsJ8B-XGZPHtBxO_wRBhAXI5"
      , mp3Url = "https://drive.google.com/uc?id=138icNGZq0dw73cICR9_X3MmRyWfuWASj"
      , title = "ワンツー・ジェンカ(おおきくくちあけて)"
      , filename = "onetwojenkka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1RHOCRbLBCKn-IDvFZagBLAEHt0V6v03d"
      , mp3Url = "https://drive.google.com/uc?id=1Q_6JEtn6ABPsOtznk1FmTzdokxxqpo3x"
      , title = "さくら(さくらさくらやよいのそらはみわたすかぎり)"
      , filename = "sakura.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Y5Ms3PvfN3gsry-AEDDA_3JSx3WXi3Gi"
      , mp3Url = "https://drive.google.com/uc?id=14CB_MNaO7JTM-xlcuqDqLaBeROSLq7qf"
      , title = "酋長の娘(わたしのらばさん)"
      , filename = "shuchou.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xMiC9mJR6ngyx84DBySijai3K4VIyb9i"
      , mp3Url = "https://drive.google.com/uc?id=1qiJokr2ykC7jkHEqugegogZ-3P3ckjP5"
      , title = "野球拳(やきゅうけん。やきゅうするならこういうぐあいにしやしゃんせ)"
      , filename = "yakyuken.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Y77SeoOl_uZWfVvhISSbli7DgPdYBThK"
      , mp3Url = "https://drive.google.com/uc?id=1DSaXADmOrcWTTdBdtG2fZOi61_WLxgPm"
      , title = "赤い靴(あかいくつはいてたおんなのこ)"
      , filename = "akaikutsu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1EkBiVEDhhjDCW1xPszKOPomf4-N6KodE"
      , mp3Url = "https://drive.google.com/uc?id=1OCpdg5cTNQq6CPxfc6NlUvI-dhLioPxD"
      , title = "赤とんぼ(ゆうやけこやけのあかとんぼ)"
      , filename = "akatonbo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Ra8LIM5b7vOJtCX2mlrQQEjqn4lnws9k"
      , mp3Url = "https://drive.google.com/uc?id=1ZYZMk6TYeIA1XR75jObU7ezwTVAbKh85"
      , title = "あの子はたあれ(あのこはたあれたれでしょね)"
      , filename = "anokowatare.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1P9ySIKGandSKjhsAkn2BwiZywtZMhI71"
      , mp3Url = "https://drive.google.com/uc?id=1GsuY-qyz2LdWBYf9BCdEh0hXLefNPCmz"
      , title = "ちょうちょう(ちょうちょうちょうちょうなのはにとまれ)"
      , filename = "chouchou.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1I_317s-Ka8m23IzSgfWFoeRmwHfhYrp4"
      , mp3Url = "https://drive.google.com/uc?id=1F-UY6UZ0gOIiYi57OiBCiD9qXX3jyvP3"
      , title = "どんぐりころころ(どんぐりころころどんぶりこ)"
      , filename = "donguri.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=104tusdlV8_3y7_F3CzkbUENo1ZAqS3GO"
      , mp3Url = "https://drive.google.com/uc?id=1v4lnAnqEICWxqcBeMfVlUZfqc-lqKqlB"
      , title = "富士山(ふじさん。あたまをくものうえにだし)"
      , filename = "fujisan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ZBi_XHt38QO_PKbVuiGYyyF07DQVnP6X"
      , mp3Url = "https://drive.google.com/uc?id=1XqCsNXOgOg6Mc1wPGxIN1gI7KPVVoVw8"
      , title = "春が来た(はるがきた)"
      , filename = "harugakita.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1CMC7aFBRwhJfHYLBxjyaKpyQA9P0r8t6"
      , mp3Url = "https://drive.google.com/uc?id=1xo-mDkeCIKViX5anj8hd-c79M_z6Lu5A"
      , title = "春風(ふけそよそよふけはるかぜよ)"
      , filename = "harukaze.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-lZiAZVjjlgqCAUhS5rk591Dw3Y3j0Kd"
      , mp3Url = "https://drive.google.com/uc?id=1laduIm4xO85JmnB0WLAtdDOCy-vzf1OO"
      , title = "春の小川(はるのおがわはさらさらながる)"
      , filename = "harunoogawa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1G03fvoY0xfEEWUINkXlDKgA12xBIUncs"
      , mp3Url = "https://drive.google.com/uc?id=1yvuyD1w5J-wQieCt_t5T9zNVfgR0fYQJ"
      , title = "椰子の実(やしのみ。なもしらぬとおきしまより)"
      , filename = "yashinomi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1S0IRdq8Fpb1AKhUM5dDvW8oc3Nt2FdCd"
      , mp3Url = "https://drive.google.com/uc?id=1GX2SuZa5O76nWfojFzIssWWClbL7vAD3"
      , title = "旅の夜風(あいぜんかつら。はなもあらしもふみこえて)"
      , filename = "tabinoyokaze.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1v4gqtTSzqe_FgTcfQEYIbdVP_rJgUM9V"
      , mp3Url = "https://drive.google.com/uc?id=1iPP74el1pw9PhNHGSOv1Kq7RcNO8n5ze"
      , title = "大黒様(おおきなふくろをかたにかけ)"
      , filename = "daikokusama.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1e9eW7asaBT-iOV45fxECcXEonDfGjpLy"
      , mp3Url = "https://drive.google.com/uc?id=1euhsfV8pq5wZ991p_ha1Wc4NJx_w6oUi"
      , title = "蘇州夜曲(きみがみむねにだかれてきくは)"
      , filename = "soshuyakyoku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1XDiADwWG0HoxA4cgooIjBLCqYC_lcBi6"
      , mp3Url = "https://drive.google.com/uc?id=12ngqjhnBroT9wyHpiSsdpoIqcP4ZUneM"
      , title = "船頭小唄(おれはかわらのかれすすき)"
      , filename = "sendokouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1WJ5klb6a0RWPLHLc24H1oaSxCc4-Sd-g"
      , mp3Url = "https://drive.google.com/uc?id=1zxcd59at2EHuJRzTURtMCZhD14LAG9DC"
      , title = "瀬戸の花嫁(せとはひぐれてゆうなみこなみ)"
      , filename = "setonohanayome.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1JNqHij4ut4LkkjMKKHxZDdbv9kO7df5T"
      , mp3Url = "https://drive.google.com/uc?id=1DhfVIICpWIUFTaJFTEzeXKg8IZWNaCJW"
      , title = "背くらべ(はしらのきずはおととしの)"
      , filename = "seikurabe.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1iLxCm5V4LdA2RXQLb1SIl_uRy7DDNxry"
      , mp3Url = "https://drive.google.com/uc?id=1K3hKJDnwtdCHVFc7kDxZNJI19uMtugom"
      , title = "人生の並木道(なくないもとよいもとよなくな)"
      , filename = "jinseinonamikimichi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1PSyzEzCLfCPsC_cwM1bspCE8vNoFFGi5"
      , mp3Url = "https://drive.google.com/uc?id=1oBLxfiKUYh6gsA9NE6IOws7gUQbbrfKS"
      , title = "白い花の咲く頃(しろいはながさいてたふるさとの)"
      , filename = "shiroihananosakukoro.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13zAtMMwEKbleK29RbPlRqsjIdcnZ6p0B"
      , mp3Url = "https://drive.google.com/uc?id=1pbfRuM9u4XK5IEvx_BBgIHY726UlEWWr"
      , title = "知床旅情(しれとこのみさきにはまなすのさくころ)"
      , filename = "shiretokoryojo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1IaFraj7CO27F1ov4iHytiuh5fQvvot56"
      , mp3Url = "https://drive.google.com/uc?id=1lF9g-3h5a04CxMRg2jQRxueqH3cJ41l2"
      , title = "証城寺の狸囃子(しょしょしょうじょうじしょうじょうじのにわは)"
      , filename = "shojoji.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=165z1FOy4J_c1yEqW1qpDfNX9WpNsyrV-"
      , mp3Url = "https://drive.google.com/uc?id=13nEvOHwfXqyrGX_HDZ8u0tX3kg3mdOiF"
      , title = "十五夜お月さん"
      , filename = "jugoyaotsukisan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1htmDzI5ZkfVWkFrzNXuca4AMKR7KjGkL"
      , mp3Url = "https://drive.google.com/uc?id=1Af6lAtF9BzUmThNOLUUIraDw7qQBJZGl"
      , title = "しゃぼん玉(しゃぼんだまとんだやねまでとんだ)"
      , filename = "shabondama.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1WYoSzsjIHR4fljRRQ2SRt4dKhiuSBR65"
      , mp3Url = "https://drive.google.com/uc?id=1c0B3feBACg_u5xbyr6M7LRzGi8XsBwbG"
      , title = "里の秋(しずかなしずかなさとのあき)"
      , filename = "satonoaki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=12kZ_kTAhLpxreM49NacoQBPhBCT2bSeO"
      , mp3Url = "https://drive.google.com/uc?id=1sDDo1mBVgKl8CyOFKvgIidapu9d_E2gp"
      , title = "桜井の訣別(あおばしげれるさくらいのさとのわたりのゆうまぐれ)"
      , filename = "sakurainoketsubetsu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dKO5Im19uMszzsHzIpfiWnVKWaeiYUNl"
      , mp3Url = "https://drive.google.com/uc?id=1nWNeetAQvVZ3bVmZesrfZix3v_g8JMl4"
      , title = "ゴンドラの歌(いのちみじかしこいせよおとめ)"
      , filename = "gondola.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Bk_zzvponlDa_mRfHpCX9_6eacfenvG7"
      , mp3Url = "https://drive.google.com/uc?id=1eoPL359sbkVrwMp-jWnz8UF85AiDI_gm"
      , title = "金色夜叉(あたみのかいがんさんぽする)"
      , filename = "konjikiyasha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1k_1d9DkfVoYul0ZkyrQfnzPy3LBO8Lry"
      , mp3Url = "https://drive.google.com/uc?id=19LVjRAlrhKV-eMP1B7G-k6mGMjYnnq27"
      , title = "湖畔の宿(やまのさびしいみずうみにひとりきたのもかなしいこころ)"
      , filename = "kohannoyado.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1iey-uHyD8bAlretxjmKpRl7Cf3Wf8zrE"
      , mp3Url = "https://drive.google.com/uc?id=1YSmZYetjNEf7WKaEhWF9ExmmmmTbde7G"
      , title = "国境の町(そりのすずさえさびしくひびく)"
      , filename = "kokkyonomachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=19U5PO_B1VaEuZ1EfdXCxXxvXJgbOF6sb"
      , mp3Url = "https://drive.google.com/uc?id=1-myodlYd9qLioMsg0fqnVRe4o8tFjND-"
      , title = "故郷の廃家(いくとせふるさときてみれば)"
      , filename = "kokyonohaika.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1G0fB_NyIThB0XkNpv7qB6-H9KyW5fmtr"
      , mp3Url = "https://drive.google.com/uc?id=1VHL9xH9MET1iD0BDlxY8DxTbiVfKKKnp"
      , title = "故郷の空(ゆうぞらはれてあきかぜふき)"
      , filename = "kokyonosora.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1P_rTh5VCCZ1PzFQeFJE46_U_nL9p32nL"
      , mp3Url = "https://drive.google.com/uc?id=13S-KLGkyeQVPedGgxBor7fnQgXIQKndg"
      , title = "黄金むし(こがねむしはかねもちだ)"
      , filename = "koganemushi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=18IIasSsrbViYa8Zt2vSH5KCyfRDPaNmI"
      , mp3Url = "https://drive.google.com/uc?id=1QIKUeWHEyMmICaoTLVqAk-eERaU42oWQ"
      , title = "荒城の月(はるこうろうのはなのえん)"
      , filename = "kojonotsuki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1p8jQC1GlB-Hz4fjFgtiDXPUu-w98v8FV"
      , mp3Url = "https://drive.google.com/uc?id=1kuAe6VDmjA4byUEsx6cmEx8ZURQCV5CI"
      , title = "高原列車(きしゃのまどからはんけちふれば)"
      , filename = "kogenressha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=130ai2SHtgbBkuHASXjMXadb1--pTheUX"
      , mp3Url = "https://drive.google.com/uc?id=15ooBKi4Uh1odq4c8vUQWmLUcD_SqLRvu"
      , title = "鯉のぼり(いらかのなみとくものなみ)"
      , filename = "koinoboriiraka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1iz9cEZ691V3rmYGFfJkkzMcad4dyZFK3"
      , mp3Url = "https://drive.google.com/uc?id=1FU1d-UFnSWvON6uC88NebVddqMzuU0kG"
      , title = "ゲイシャ・ワルツ(あなたのりーどでしまだもゆれる)"
      , filename = "geishawaltz.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hf7hQnIPm8Y_1zwHzGHexnMHsZX_xzuh"
      , mp3Url = "https://drive.google.com/uc?id=1Y8eiQecwi3AYs52DSXY2wpI7AY_8Q6v4"
      , title = "くつがなる(おててつないでのみちをゆけば)"
      , filename = "kutsuganaru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1REh_S18-imgGU2UIkESzUUuxPv3WOma3"
      , mp3Url = "https://drive.google.com/uc?id=1z1XGjfuPRkN4RbGItkbTdYBvjta0GtTm"
      , title = "金太郎(まさかりかついできんたろう)"
      , filename = "kintaro.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jjZ7_MOQ6ZpwZ6IO4dQXebHoVkznoy8M"
      , mp3Url = "https://drive.google.com/uc?id=1ChqwAiZl4P0SG3UV9fRUnLYpPWbNYa8M"
      , title = "銀座カンカン娘(あのこかわいやかんかんむすめ)"
      , filename = "ginzakankan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=15QPZb2o4PjpGQI0ZldF4ZvOGDAaUCVac"
      , mp3Url = "https://drive.google.com/uc?id=1aeGezSmhVHwXVmhIokMgJFYkJafCQR4x"
      , title = "金魚の昼寝(あかいべべきたかわいいきんぎょ)"
      , filename = "kingyonohirune.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MnmIEQ1-arurlh6Hi2FOFRbCZ7G2wprO"
      , mp3Url = "https://drive.google.com/uc?id=1dw88-7e8Xrtcu7MZM74yhQzluo2A6uqh"
      , title = "北上夜曲(においやさしいしらゆりのぬれているよな)"
      , filename = "kitakamiyakyoku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1iCNj7IWaxV2J5R7e4zupjTQcFXJwDJmJ"
      , mp3Url = "https://drive.google.com/uc?id=1Zkqdv8w9AJARbAqOKDksUMk0NDLKgpMk"
      , title = "汽車(いまはやまなかいまははまいまはてっきょうわたるぞと)"
      , filename = "kishaimawa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qCQqXNX57DtqCmwEXJCQszy22eVhHTXt"
      , mp3Url = "https://drive.google.com/uc?id=1IShpuKRu5C8_V0GT_zplJ7io_pZNDuX_"
      , title = "紀元節(くもにそびゆるたかちほの)"
      , filename = "kigensetsu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Xibay5EsE1w9Pzq8OfW7VevVD8dq_WE2"
      , mp3Url = "https://drive.google.com/uc?id=10DbVGduOx95_hzMFrFX0-6Nx9i66NOwt"
      , title = "かわいい魚屋さん(かわいいかわいいさかなやさん)"
      , filename = "kawaiisakanayasan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1SZsYiz-57tnhyIMT22vCz_CoOQitUBIS"
      , mp3Url = "https://drive.google.com/uc?id=1IOFn66cqnH9u3dbIDBaAlQRjsKtqDD3P"
      , title = "こんにちは赤ちゃん(こんにちはあかちゃんあなたのえがお)"
      , filename = "konnichiwaakachan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1FlFQF8gjFwxKuaPO2wKHxdeHdWdT4ElX"
      , mp3Url = "https://drive.google.com/uc?id=1MgSU9ymmwtSoW8SojrUpTjRzmr7YunFH"
      , title = "かもめの水兵さん(かもめのすいへいさんならんだすいへいさん)"
      , filename = "kamomenosuiheisan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11TyPAxzPY7iHALy-EVJzr-25CgUs3-8V"
      , mp3Url = "https://drive.google.com/uc?id=1PUvg749wfLb82qr-bWO6Bj6XoQIu2zR5"
      , title = "鐘の鳴る丘(みどりのおかのあかいやねとんがりぼうしの"
      , filename = "kanenonaruoka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1RHX8jpc9sEYCBo1mxwJzgvIdJJcwX2Z2"
      , mp3Url = "https://drive.google.com/uc?id=1Zv7hEm9jrZQHYzKMN1gRV1x_4d3NmvL_"
      , title = "カチューシャの唄(かちゅーしゃかわいやわかれのつらさ)"
      , filename = "katyushanouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=15R8SdRMiwcEIj9QdBYjdrLXdbCLlvlVr"
      , mp3Url = "https://drive.google.com/uc?id=1TcMfvMTY9POVbeA09hkoytjLmEluIQzn"
      , title = "肩たたき(かあさんおかたをたたきましょうたんとんたんとん)"
      , filename = "katatataki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1UUZmh5A7xe82kN8whcL1zLmng7fxvX5-"
      , mp3Url = "https://drive.google.com/uc?id=1rPAyEXa7SzQ8ybushIt-3O2Ku20UGEWH"
      , title = "かあさんの歌(かあさんはよなべをしててぶくろあんでくれた)"
      , filename = "kasannouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1u4hEkVgI9CAPc92eGOA1O25xBwGHRYHt"
      , mp3Url = "https://drive.google.com/uc?id=1WZ1a8G0pMqicEqozZu7LgOv-NWTfFhnv"
      , title = "お山の杉の子(むかしむかしそのむかししいのきばやしのすぐそばに)"
      , filename = "oyamanosuginoko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1o38_onW0uEwFVrBgzkaeRKfuvox6JiuT"
      , mp3Url = "https://drive.google.com/uc?id=15RKITznXD2-m8vn1CYJ0A4Hij_OmhgBZ"
      , title = "おぼろ月夜(なのはなばたけにいりひうすれ)"
      , filename = "oborodukiyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1YEJxnFIT4LwLacC93WWoDvim9E28jynw"
      , mp3Url = "https://drive.google.com/uc?id=1F6QvGSdN6R_3NwE4XS2rE6Vo-TIbmNt7"
      , title = "おさるのかごや(えっさえっさえっさほいさっさ)"
      , filename = "osarunokagoya.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ljT7FsW7XvrUc2DWtmBCT1Md9fnyoR5N"
      , mp3Url = "https://drive.google.com/uc?id=180YFa5HUPmWq5NR2UfzgnYfq0diwUAP6"
      , title = "うれしいひなまつり(あかりをつけましょぼんぼりに)"
      , filename = "ureshiihinamatsuri.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1NRWlM1iH7o42xau8LoaNbycrRO0FhIYT"
      , mp3Url = "https://drive.google.com/uc?id=1woharqIFKKeV3_9XOStdZuZQMwjm8V17"
      , title = "浦島太郎(むかしむかしうらしまはたすけたかめに)"
      , filename = "urashimataro.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ho9NJwlB9kw33MKMIITI7yzwGwWUW2Cg"
      , mp3Url = "https://drive.google.com/uc?id=17-lJUxiJ4CyOuF_ajd04yMFYWw-XmsGj"
      , title = "海(うみはひろいなおおきいなつきがのぼるしひがしずむ)"
      , filename = "umiwahiroina.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zw4tPQUsDVTIbtOr0cX6e02Tc6PbPo2S"
      , mp3Url = "https://drive.google.com/uc?id=1DZdFqhx8LQE9SDxCgYQR3RB0xp3xJnaH"
      , title = "うさぎとかめ(もしもしかめよかめさんよせかいのうちにおまえほど)"
      , filename = "usagitokame.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ZiedUht1x1ujGdyyfrTnbB18LvmOcXvL"
      , mp3Url = "https://drive.google.com/uc?id=1N52rGKrN2c7cD19Mnn-1OVF4zaNzpLF-"
      , title = "異国の丘(きょうもくれゆくいこくのおかに)"
      , filename = "ikokunooka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1YmRyVBV-SmNOwe7maDsPgGK23HslVxwt"
      , mp3Url = "https://drive.google.com/uc?id=1VM7N7bgxMDqR1WyRoR5xkLEgu8ivFBPi"
      , title = "あめふり(あめあめふれふれかあさんがじゃのめでおむかえ)"
      , filename = "amefuriameame.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14O-ukSjNukQuAylNeZO_NPzkEDG-pn0Y"
      , mp3Url = "https://drive.google.com/uc?id=1nSoXSZXaK_RnZ1I0h-H1yZSm4LPlPW6j"
      , title = "憧れのハワイ航路(はれたそらそよぐかぜみなとでふねのどらのねたのし)"
      , filename = "akogarenohawaii.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1beirmZmXh_9rjT_O4GyfyzzCGlGj--wO"
      , mp3Url = "https://drive.google.com/uc?id=1fMYne82dyHOo6BJDPE4qmpII5YzmrVeQ"
      , title = "銀色の道(とおいとおいはるかなみちはふゆのあらしがふいてるが)"
      , filename = "ginironomichi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ZYTqsNGLviA135EolnNHV08XmHrQUoPN"
      , mp3Url = "https://drive.google.com/uc?id=1JNYF8m0U_Zp-AFs_gPA5A1Gr5v5DM4a5"
      , title = "月の砂漠(つきのさばくをはるばるとたびのらくだがゆきました)"
      , filename = "tsukinosabaku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1wSGd9a4sx1HPsIfGzipnYG6ifemflGhX"
      , mp3Url = "https://drive.google.com/uc?id=1MK4PwPBzo49oFym9nnFSdrtIrcCaCTFX"
      , title = "てるてる坊主(てるてるぼうずてるぼうずあしたてんきにしておくれ)"
      , filename = "teruterubozu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1YUI4h0qkEqmUSckXJfbPJrXofz59eUAt"
      , mp3Url = "https://drive.google.com/uc?id=15mo8ZG4zoda6VCPgpisRtY11EOdoDFdd"
      , title = "東京行進曲(むかしこいしいぎんざのやなぎあだなとしまをだれがしろ)"
      , filename = "tokyokoshinkyoku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1LdysiHHFbFfNz9U94pmfHkqZ4GpNFhif"
      , mp3Url = "https://drive.google.com/uc?id=1_biMwXxDe39zicm0cWc-8kvx93OjJLpC"
      , title = "東京のバスガール(わかいきぼうもこいもあるびるのまちから)"
      , filename = "tokyobusgirl.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Z9UibiGGcY8be0FswbQb5bnehK1t0DBQ"
      , mp3Url = "https://drive.google.com/uc?id=1hBwIAt_eae5tetYR6zqK5M7Smfv5tw4R"
      , title = "東京ラプソディー(はなさきはなちるよいもぎんざのやなぎのしたで)"
      , filename = "tokyorhapsody.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1plvD4w-Qa6RJpCg2Wx96ukZzeH_y3UHp"
      , mp3Url = "https://drive.google.com/uc?id=1XX1qhmx5rwq0yqMz6_zCLwcg_TVIrKZl"
      , title = "夏は来ぬ(うのはなのにおうかきねにほととぎすはやもきなきて)"
      , filename = "natsuwakinu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Mpa-CXJ1wbUWHbYXnIFqvNI8luN5iYL7"
      , mp3Url = "https://drive.google.com/uc?id=1XXDVOxOjwJx8Jlo5TfPP3VplEG9E_z2W"
      , title = "七つの子(からすなぜなくのからすはやまに)"
      , filename = "nanatsunoko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1tnGNE-90-68hR9FCPo1cIoj4qtRjQhVv"
      , mp3Url = "https://drive.google.com/uc?id=17YUEm8udxwQLszb8p6pvjjIG4CmGyl20"
      , title = "庭の千草(にわのちぐさもむしのねもかれてさびしく)"
      , filename = "niwanochigusa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ZS92cko3tOkc7aD8VUG8XXtwr72oWpCQ"
      , mp3Url = "https://drive.google.com/uc?id=1aFlknVbWI-TR02LJdsvji9WNSHhq5vTD"
      , title = "野ばら(うぇるなー。わらべはみたりのなかのばら)"
      , filename = "nobarawerner.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vBAxw0B8SPhouT1BNV3YoGokEXUIPXGq"
      , mp3Url = "https://drive.google.com/uc?id=1aZP5GPf_Vc4IC-yBdGw6LmbQzyqcyJig"
      , title = "箱根八里(はこねのやまはてんかのけんかんこくかんもものならず)"
      , filename = "hakonehachiri.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1QmJxO8qcYL7IXBaEwnl91UJ98pRlUUcP"
      , mp3Url = "https://drive.google.com/uc?id=1A2AjeYIqGHwL8EecgcH9aBH0K0Ubt8OD"
      , title = "鳩(ぽっぽっぽはとぽっぽまめがほしいかそらやるぞ)"
      , filename = "hatopoppo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11ONvwRy2sJGYT9VET9VQ0ASv_oyCt8_b"
      , mp3Url = "https://drive.google.com/uc?id=1ncCzmSJ-eAuxSAitQb3fy31pS9kJdKid"
      , title = "花火(どんとなったはなびだきれいだな)"
      , filename = "hanabidonto.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1veCPFkXoIWAVYXIUNe6K7RoJZhF_ZgvW"
      , mp3Url = "https://drive.google.com/uc?id=186III6EFbYBnGkqJfd5UTcmrCPPpyZQI"
      , title = "花嫁人形(きんらんどんすのおびしめながらはなよめごりょうは)"
      , filename = "hanayomeningyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kENhXP8eR-juPn_sJxPWgHBiBq67Lk_8"
      , mp3Url = "https://drive.google.com/uc?id=1nNQO_nNOiwidknr1Byw_KIoJO5zXGmYV"
      , title = "埴生の宿(はにゅうのやどもわがやどたまのよそいうらやまじ)"
      , filename = "hanyunoyado.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1sivsVLpwLZvtRfz716XVxLljCrQ2UGMB"
      , mp3Url = "https://drive.google.com/uc?id=1lpVO-NjFe0k82tPfuPQe7_1bvRd_qGW0"
      , title = "浜千鳥(あおいつきよのはまべにはおやをさがしてなくとりが)"
      , filename = "hamachidori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1HR5GouLe2kQtyki7kP9RZ1U608UKeNNU"
      , mp3Url = "https://drive.google.com/uc?id=1VCSiD_-2s1yMyn1C9vdB6U6sViuzOzs5"
      , title = "バラが咲いた(ばらがさいたばらがさいたまっかなばらが)"
      , filename = "baragasaita.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1_EjumZCFj7QoeSOq5kIUEl74xg218yvR"
      , mp3Url = "https://drive.google.com/uc?id=10VNaKvpqSiSuJm79dxnwrTTddRXM7bvC"
      , title = "星影のワルツ(わかれることはつらいけどしかたがないんだ)"
      , filename = "hoshikagenowaltz.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1q3SLIhD8MKbHLiLEIzU-o_LHozaHbyNb"
      , mp3Url = "https://drive.google.com/uc?id=1JlNsl9rZYly1njOtn8EdjTHuQs8Z9TRr"
      , title = "星の界(ほしのよ。いつくしみふかき。つきなきみそらに)"
      , filename = "hoshinoyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13IIPqSRgeEx1pIUqEv3U0hGjfaL0LZD1"
      , mp3Url = "https://drive.google.com/uc?id=119hDBEA3s3KN8WTD8G_j1QJTNxrIvzPK"
      , title = "蛍(ほたるのやどはかわばたやなぎ)"
      , filename = "hotarunoyadowa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DMliARW6wZ8oT-flB_QEyqWT385yZVpx"
      , mp3Url = "https://drive.google.com/uc?id=10-SA6WssKxAYtdczzBZZvH6225Efq6iG"
      , title = "牧場の朝(ただいちめんにたちこめた)"
      , filename = "makibanoasa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1N9t8nrtAQWDxBomfDvpov7TmU3PKXqfq"
      , mp3Url = "https://drive.google.com/uc?id=1DhQ1SDECCzFSKxccAdYdebEGuQGH-0vQ"
      , title = "港(そらもみなともよははれてつきにかずますふねのかげ)"
      , filename = "minato.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vMtHG1K0RFf4RF4Xm3IDNHhmlW5W4CDw"
      , mp3Url = "https://drive.google.com/uc?id=1WH2YwKJNyWUAuVEgsBBJlx4nQWYaYAJV"
      , title = "港が見える丘(あなたとふたりできたおかは)"
      , filename = "minatogamieruoka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Bbn46bb3ot9ab_d-6cKtuHmo3NryZj2i"
      , mp3Url = "https://drive.google.com/uc?id=1ajr7on_vMVZxx6_7OmLE4KmVxPGQGhHh"
      , title = "村まつり(むらのちんじゅのかみさまのきょうはめでたいおまつりび)"
      , filename = "muramatsuri.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1LH-l6ssopa-e-aJFctxjnfhB_YDsINQc"
      , mp3Url = "https://drive.google.com/uc?id=1B7TLH1Pay6oaEXh2_aNJpR0NOpTEpxJ-"
      , title = "山小舎の灯(やまごやのともしび。たそがれのともしびはほのかにともりて)"
      , filename = "yamagoyanotomoshibi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kre1odVBMZE36Twc54JMsdp7kZmQrH0i"
      , mp3Url = "https://drive.google.com/uc?id=1lVaKZ7oT1Ui_9CBbzl7iegTEZxdLlANK"
      , title = "夕焼小焼(ゆうやけこやけでひがくれてやまのおてらのかねがなる)"
      , filename = "yuyakekoyake.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=104vaPRKGqTJdvuboxXvmaneToJZ2PT_w"
      , mp3Url = "https://drive.google.com/uc?id=197HPT5qLTXQPE5HXVyupT2UpC_uBISyQ"
      , title = "湯島の白梅(ゆしまとおればおもいだすおつたちからのこころいき)"
      , filename = "yushimanoshiraume.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=17wYfeU0y_SwrkRWY4TQ3tx0T1nP65DgX"
      , mp3Url = "https://drive.google.com/uc?id=189ZzWnxspFAEj7XrR42cSK-S4C4Db4WC"
      , title = "揺籃のうた(ゆりかごのうたをかなりやがうたうよねんねこ)"
      , filename = "yurikagonouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1nJd9kHxHLLbhOhdtdnh-BO_81jUdqGUZ"
      , mp3Url = "https://drive.google.com/uc?id=1dE9ce3ZJ27L7wHhOdg-xAt8una8_8q1m"
      , title = "喜びも悲しみも幾歳月(いくとしつき。おいらみさきのとうだいもりは)"
      , filename = "yorokobimokanashimimo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1cQogqvWVPWrRcs4J0pcFwCXu3RuzY7RE"
      , mp3Url = "https://drive.google.com/uc?id=11_6yNO6XU4TldolPlTE_1Ho5eBuOrflt"
      , title = "ラバウル小唄(さらばらばうるよまたくるまでは)"
      , filename = "rabaul.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1HhOB5vingHhvlq8ZZsoUr41DTKcCzBCc"
      , mp3Url = "https://drive.google.com/uc?id=1M_UZe1NdXQf5dR5ynEIsEksEnDtXDJgc"
      , title = "青葉の笛(敦盛と忠度。いちのたにのいくさやぶれうたれしへいけの)"
      , filename = "aobanofue.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1pEXPbO-ihBf_QmK9N2G35Md5KL4e0OD9"
      , mp3Url = "https://drive.google.com/uc?id=17hwUFloRepzaes3iogqzU5_oIHqrkd99"
      , title = "赤い鳥小鳥(あかいとりことりなぜなぜあかい)"
      , filename = "akaotorikotori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1OqGk8Ye8sta4_R07ZqiNRX6UZ1UV324t"
      , mp3Url = "https://drive.google.com/uc?id=1tmGJ6tb2sw7GXlgN1EkAecLTnWVk_ZpJ"
      , title = "赤い帽子白い帽子(あかいぼうししろいぼうしなかよしさん)"
      , filename = "akaiboshishiroiboshi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1d3L0beie7s6LLI7n1iCMOMmyJkGJ0C1J"
      , mp3Url = "https://drive.google.com/uc?id=1wu89LYgDGnwRe_jVPkNEPMlpP2bKhY-U"
      , title = "あざみの歌(やまにはやまのうれいありうみにはうみのかなしみや)"
      , filename = "azaminouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1fGvN3eJwQ3lMYmOUkmLe_IrpLowJKdpP"
      , mp3Url = "https://drive.google.com/uc?id=110JhI0POZgzJsuLcSddC9m3CDluFeDDD"
      , title = "雨に咲く花(およばぬこととあきらめました)"
      , filename = "amenisakuhana.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1etmxwVpFIE9gr2i3TyNq6tyRS7eaFlkB"
      , mp3Url = "https://drive.google.com/uc?id=1cXXO-4T_xVXj85i7h-JjxJRp0IYAZkGC"
      , title = "雨降りお月(あめふりおつきさんくものかげおよめにゆくときゃ)"
      , filename = "amefuriotsuki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hUxNgMgd8z2b604QDeIAbHcj4_dYj6pY"
      , mp3Url = "https://drive.google.com/uc?id=1fCAPY2GF4_9gdkt9mdv7NxhE0vmT4caB"
      , title = "池の鯉(でてこいでてこいいけのこい)"
      , filename = "ikenokoi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xeGS1NSybMBDWxZ7JCPmqCTD9dQeqiQb"
      , mp3Url = "https://drive.google.com/uc?id=1b8TPaShHj4PTY2ZvCbfX1RzVs5zo0FKE"
      , title = "うぐいす(うめのこえだでうぐいすは)"
      , filename = "uguisu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1fmkYjX_hwVW72PyyekESvcOpCInNGMX-"
      , mp3Url = "https://drive.google.com/uc?id=1Sl9l6Dxp8-asGFfYI6c-C8wwcG2TJZJA"
      , title = "牛若丸(きょうのごじょうのはしのうえだいのおとこのべんけいは)"
      , filename = "ushiwakamaru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zCbEzEy3Nuhh0ukOLwA_YEldffBS2ebI"
      , mp3Url = "https://drive.google.com/uc?id=1ftMt-m4yLEdydkZ6hRwCjIyPjFL_TA7T"
      , title = "うちの女房にゃ髭がある(なにかいおうとおもっても)"
      , filename = "uchinonyobonya.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1k3s6hMhlI-xk8HxV8FdA4diz7h8ANnkl"
      , mp3Url = "https://drive.google.com/uc?id=1KPnkqHkvQXz89jvXP4jAnbM2rBCaAv-V"
      , title = "海(まつばらとおくみゆるところしらほのかげはうかぶ)"
      , filename = "umimatsubara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=19d7me2PkE_fzWny0LPm5U8_8LnwJkm9n"
      , mp3Url = "https://drive.google.com/uc?id=19Rq9mNURvGuhMx7-5XMgXgxd200PMUkW"
      , title = "大江戸出世小唄(どてのやなぎはかぜまかせ)"
      , filename = "ooedoshussekouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vDo9ltig-Rrc0Cb2RDG1v9ph0-TuhU8J"
      , mp3Url = "https://drive.google.com/uc?id=1TsNsTCxoC4Ms3pdcYhqQRS882bPzXSh2"
      , title = "大利根月夜(あれをごらんとゆびさすかたに)"
      , filename = "ootonedukiyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1a3CFkgamdx5Z-aF7RDoH02TD5XqNpa-o"
      , mp3Url = "https://drive.google.com/uc?id=1V-jef6Eby3dg9h2GKSi0iMiIjWqDUw6t"
      , title = "丘は花ざかり(わかいいのちのかれんだーを)"
      , filename = "okawahanazakari.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1h_djXXPo-XDT5dWXc4_ENraSVkFjtalJ"
      , mp3Url = "https://drive.google.com/uc?id=1muHb_6uhUpGuUdyvFckuQCy-CwiIxFEa"
      , title = "丘を越えて(おかをこえていこうよますみのそらはほがらかに)"
      , filename = "okawokoete.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=16x_5frvqxmXBaw42URLjhlQOubmr_q1f"
      , mp3Url = "https://drive.google.com/uc?id=1QGXcHjxzrCqROGyJn6tzZX1srN0d026B"
      , title = "落葉しぐれ(たびのおちばがしぐれにぬれて)"
      , filename = "ochibashigure.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vOrp7dTGZY7p_MJuGZPabChRMVqYz67b"
      , mp3Url = "https://drive.google.com/uc?id=18rcOisREFKSI4VRPTiVDqB6CPHXjC3d3"
      , title = "かえり船(なみのせのせにゆられてゆれて)"
      , filename = "kaeribune.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1eoW684ZpGCNdyFKcJ1JUCwoOz6vH0OOi"
      , mp3Url = "https://drive.google.com/uc?id=13iZQebg642ql_UxdSCZBsW2notfdCuxU"
      , title = "勘太郎月夜唄(かげかやなぎかかんたろうさんが)"
      , filename = "kantarotsukiyouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1e4oXWHP3bHDasdx3sXvIBSlpr5vYSP-t"
      , mp3Url = "https://drive.google.com/uc?id=1mrKCMbF4VANuVCNKVtp2hV-bW-mwxNfF"
      , title = "菊の花(きれいなはなよきくのはな)"
      , filename = "kikunohana.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1H30-Q6dTi0FbqX8_EQbFOaCqlggu59Zg"
      , mp3Url = "https://drive.google.com/uc?id=1mlwLrZM9TibPxR-7WXWdpNpFROrEG13b"
      , title = "紀元二千六百年(きんしかがやくにっぽんのはえあるひかり)"
      , filename = "kigen2600.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1IRNq4Kox5HQGBK_ccR-ShpI3b5W00L77"
      , mp3Url = "https://drive.google.com/uc?id=1cyEwfcynNYdmSe9_c0_c3jvHwPF-d8rj"
      , title = "汽車ポッポ(きしゃきしゃぽっぽぽっぽしゅっぽしゅっぽ)"
      , filename = "kishapoppo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ZKjzar11-a4s0Sk_F3_h_yoHefzVjsS5"
      , mp3Url = "https://drive.google.com/uc?id=17rqRo68j_Ph7VKpeBUKPEOLwJ-A0mjhK"
      , title = "ギッチョンチョン(たかいやまからたにそこみれば)"
      , filename = "gicchonchon.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1k1J851GndcsYgt5MvmUz-bbgL4HXkZ48"
      , mp3Url = "https://drive.google.com/uc?id=1bKow4_2EpJGg2bzoGEdTwv0fmxwraGaU"
      , title = "君恋し(よいやみせまればなやみははてなし)"
      , filename = "kimikoishi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xz6E_h25OkTpjPkKE_SuqwP0NyXfuezo"
      , mp3Url = "https://drive.google.com/uc?id=1IfMRrnSwQvFoIevOcRyWLZfDF9XuNIiE"
      , title = "黒百合の唄(くろゆりはこいのはなあいするひとにささげれば)"
      , filename = "kuroyurinouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1wU6OjsRzIWJGDytkCjyKjKf660fMehUs"
      , mp3Url = "https://drive.google.com/uc?id=1r1Ah707-j4D_k4bmi6aAyc-mEeMIuxXn"
      , title = "月月火水木金金(あさだよあけだうしおのいぶき)"
      , filename = "getsugetsukasui.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1WuKBsJ64GovAiv7P7kXBccoh4Middkne"
      , mp3Url = "https://drive.google.com/uc?id=1C9frzQGX7VqYikx49NjYFLuKH1ZnjQn-"
      , title = "高原の駅よさようなら(しばしわかれのよぎしゃのまどよ)"
      , filename = "kogennoeki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qrSIaIgBTzrI7H9Xb3bHfd-bnKFp0ys1"
      , mp3Url = "https://drive.google.com/uc?id=1wlB13a-Nyhxnm-9-79GDgPdSq3hds_HT"
      , title = "子鹿のバンビ(こじかのばんびはかわいいなおはながにおうはるのあさ)"
      , filename = "kojikanobambi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1JNhCCyseH5IUWectD_Q5FTzIp8yFWr8N"
      , mp3Url = "https://drive.google.com/uc?id=1vs5wkoiw8h0x8NSjc5lCn2BnEsHmHKMc"
      , title = "サーカスの唄(たびのつばくろさみしかないか)"
      , filename = "circusnouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1IY8MHtySltelELHTlQL5dy4ydg0AkHSG"
      , mp3Url = "https://drive.google.com/uc?id=1qxoRLpHasQrOlSn4iJkllExIjjQ4OAYO"
      , title = "さくら貝のうた(うるわしきさくらいがいひとつ)"
      , filename = ".ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1APYF-04_YGuGHuUXqOhy3hnP6bop51QZ"
      , mp3Url = "https://drive.google.com/uc?id=1aCW20SLwvOJnKBtVaHlrCEooD5X5VSJv"
      , title = "サンタ・ルチア(さんたるちあ。ほしかげしろくうみをてらし)"
      , filename = "santalucia.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1epcFU7bB4aYlnaDZvSPi8bsrZdxRu80s"
      , mp3Url = "https://drive.google.com/uc?id=1zvJNTSViESt5kSMRqPbwfWg6P1HC3yqD"
      , title = "四季の雨(ふるともみえじはるのあめ)"
      , filename = "shikinoame.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1521sMAm3TH7VczT640Yihu-h6Kawy3vn"
      , mp3Url = "https://drive.google.com/uc?id=1ehT4OLPMVYBBYL-YRandAA2JVe2vNgWP"
      , title = "出征兵士を送る歌(わがおおきみにめされたる)"
      , filename = "shusseiheishi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ExNGm8z4RN0cAUooHvOl-G1pCtIYwBX5"
      , mp3Url = "https://drive.google.com/uc?id=1ZAfJQY3X4C1hhznYy3Y8Tno0d5dkci17"
      , title = "純情二重奏(もりのあおばのかげにきて)"
      , filename = "junjo2juso.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1o1yyExT3Q9FqveAZS4jr-J4Ql31suBOB"
      , mp3Url = "https://drive.google.com/uc?id=1uNJ1DfN7I22LOvbnYWlwl4nAEn4NKizd"
      , title = "新雪(むらさきけむるしんせつの)"
      , filename = "shinsetsu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1E-PdXCCvcFRdpwfNQJPa_qssz4xYLGR9"
      , mp3Url = "https://drive.google.com/uc?id=1cUfjozjgYEJ7z6DLfC_6YrcZlpGNvCpz"
      , title = "スキー(やまはしろがねあさひをあびて)"
      , filename = "skiingyama.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1JGamPaR99tD7OsGznD2M8GGXLVVXbnm4"
      , mp3Url = "https://drive.google.com/uc?id=1NrslmuLPQxcFp79R-CstcwYNPoXgQuCh"
      , title = "ひこうき雲(しろいさかみちがそらまでつづいている)"
      , filename = "hikokigumo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11YNpS3wV32U4GGOdcF0xIwGcZtrk5vdH"
      , mp3Url = "https://drive.google.com/uc?id=1yrcbI0IalXWrpwj-ZC4_xk_51-8pEqF9"
      , title = "スキーの歌(かがやくひのかげはゆるのやま)"
      , filename = "skiinouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1VXOjG6I_YQ6bZil73O9sQvbp1PplAZbq"
      , mp3Url = "https://drive.google.com/uc?id=1Pal6rnAQYp7bSwO4b_tmY2bAHMNTclhI"
      , title = "雀の学校(ちいちいぱっぱちいぱっぱすずめのがっこうのせんせいは)"
      , filename = "suzumenogakko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vaTJnJuZ2VV4C2CWYbN1p1LOHdFKAqEY"
      , mp3Url = "https://drive.google.com/uc?id=1g-Weyxs5lPPJzgp3nJsl0e5QOW5PSXcA"
      , title = "ストトン節(すととんすととんとかよわせていまさらいやとは)"
      , filename = "sutotonbushi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=18R8hxAFsrxI2n6c5WsNHskX-N34fEOyo"
      , mp3Url = "https://drive.google.com/uc?id=1F1cSJN9qR4XzfsBnj_ezK09JpckhCeIc"
      , title = "砂山(うみはあらうみむこうはさどよ)"
      , filename = "sunayama.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1aZ0Pbs3bUu9IykV0sLZVTXevMUjUEShx"
      , mp3Url = "https://drive.google.com/uc?id=194UDAlNOFfHn17cNdpA1hHGFrU2Ultxc"
      , title = "田植(そろたでそろたさなえがそろた)"
      , filename = "taue.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13J6VqznA82c8BQ4isSTet-AxkhFcmj3M"
      , mp3Url = "https://drive.google.com/uc?id=1SIT6xjxmpPp2TZxU2CYy4S0MA3k9pCYM"
      , title = "旅姿三人男(しみずみなとのめいぶつはおちゃのかおりと)"
      , filename = "tabisugata.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=16zecnkFxb-u_yQLySUOs9ElYWmgalFed"
      , mp3Url = "https://drive.google.com/uc?id=1M4YmkqI5A4ocpPQ0Kxi-pwCl7ao9EpHJ"
      , title = "ちんから峠(ちんからほいちんからほいちんからとうげの)"
      , filename = "chinkaratoge.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qsF-6FzK5BZPLxVDX09Gn0ibC2sVN_oT"
      , mp3Url = "https://drive.google.com/uc?id=1cFF9XlKxOkCEhwCVfSytwDf0U3zae1EI"
      , title = "並木の雨(なみきのみちにあめがふるどこのひとやら)"
      , filename = "namikinoame.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Ki5bFdVJSLwDMB_hYFv7KqswXZELUZbh"
      , mp3Url = "https://drive.google.com/uc?id=1m8I6r1nR3I4vYiCbG0soVo1xw6ByETlJ"
      , title = "二宮金次郎(しばかりなわないわらじをつくりおやのてをすけ)"
      , filename = "ninomiyakinjiro.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1buwF-mjDDVG4g_YO62eudHvgj2eCJLc6"
      , mp3Url = "https://drive.google.com/uc?id=1wrxMZ8SiF8F1SJaJrJ7iOhyrG75fFeeC"
      , title = "野菊(とおいやまからふいてくるこさむいかぜに)"
      , filename = "nogiku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1KwL97GqA-kQa4DQahAFd2vryIwMuq54z"
      , mp3Url = "https://drive.google.com/uc?id=18Ndkrj6XVQ67AcSl2n9SYJn6yV5DkZnM"
      , title = "野崎小唄(のざきまいりはやかたぶねでまいろどこをむいても)"
      , filename = "nozakikouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1BvTLtD6Iz44HskZzPjM6jhyDDW9YK9zB"
      , mp3Url = "https://drive.google.com/uc?id=15R9xK3W4mcpDu8aJQsrWMgO2WoRf79z8"
      , title = "羽衣(しろいはまべのまつばらになみがよせたりかえしたり)"
      , filename = "hagoromo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1mN6daKRb9kduTszvQYvt-h4rXXoahbn6"
      , mp3Url = "https://drive.google.com/uc?id=1kJ3IYCQOqUIZ3wBAodlwMwI5o_Y9CSA6"
      , title = "芭蕉布(うみのあおさにそらのあおみなみのかぜに)"
      , filename = "bashofu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1aeg6Ll2B57M6ag10jPGroDZzRhHTrMFc"
      , mp3Url = "https://drive.google.com/uc?id=1EMWNtz8QLaUG02lkrsxy0HFobPoOaf7E"
      , title = "花(はるのうららのすみだがわのぼりくだりのふなびとが)"
      , filename = "hanaharunourara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1BMb0cRh3H4sHqCVewB-sZ9NOAEygNdmn"
      , mp3Url = "https://drive.google.com/uc?id=1WaontXzrCqo4dQ-Ua6k6geQ1smadLLkS"
      , title = "花かげ(じゅうごやおつきさまひとりぼちさくらふぶきのはなかげに)"
      , filename = "hanakage.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1nuwLX9xO_dml3JPCWz87xaGY4mLJR696"
      , mp3Url = "https://drive.google.com/uc?id=1M4L-86VjaHmq08lx4ckSQGcJApdXuA0E"
      , title = "はなさかじじい(うらのはたけでぽちがなくしょうじきじいさんほったれば)"
      , filename = "hanasakajijii.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Q8yZ1RnhquwoA6PN4jVouSvgKPfnIp4e"
      , mp3Url = "https://drive.google.com/uc?id=1fcNftuccgCoFKySzlcHCaNOOct2mZauX"
      , title = "春の唄(さくらのはなのさくころはうららうららとひはうらら)"
      , filename = "harunoutasakura.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xn56YSrra6_IC63byninnVvwxZTCGb7T"
      , mp3Url = "https://drive.google.com/uc?id=1PZThrpI2MQFK_oUyoAJmV6uSVUs0PYBS"
      , title = "広瀬中佐(とどろくつつおととびくるだんがん)"
      , filename = "hirosechusa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1yGy9rfEKnDv9HBs2QSp_snt3OjFbquZ1"
      , mp3Url = "https://drive.google.com/uc?id=1KQCnlm9eTly_MzW8mI2PA_BXFzOEpDX9"
      , title = "二人は若い(あなたとよべばあなたとこたえるやまのこだまのうれしさよ)"
      , filename = "futariwawakai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1P8d1R6Yum6eV68ah-TcDhBnaBGY3f9ue"
      , mp3Url = "https://drive.google.com/uc?id=1YtamT6pp9GSt3Iu2HCYwLbmRXJ9vzzWB"
      , title = "冬の星座(こがらしとだえてさゆるそらより)"
      , filename = "fuyunoseiza.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1E4wzhudr63Xl55m_D63RPy7gxnfwIvZ9"
      , mp3Url = "https://drive.google.com/uc?id=1epeWXrDJQEzZrWuwj9mCe6NULNEBH_Yb"
      , title = "冬の野(つゆじものおきわつふゆののべぞさびしき)"
      , filename = "fuyunono.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1LmDj4JpvszPDy6qOgfNDrNAcaurw40ot"
      , mp3Url = "https://drive.google.com/uc?id=1HNjuYk1TwJxxSDvZ8rhfhQHrTjliarY3"
      , title = "紅屋の娘(べにやのむすめのいうことにゃさのいうことにゃ)"
      , filename = "beniyanomusume.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1BshkVW3Zyuco-7i6VOoQnmsQ4Uwlq_vT"
      , mp3Url = "https://drive.google.com/uc?id=1bx_MZOE4C9B7S0ItpYE6fCVIL5o69y1u"
      , title = "満州娘(わたしじゅうろくまんしゅうむすめはるよさんがつゆきどけに)"
      , filename = "manshumusume.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1NOnRe3wux9O6bfoDvsOwAt8dhHGsGrPl"
      , mp3Url = "https://drive.google.com/uc?id=1P-TyLwx26LFoRJGau_twz2pbOkewRaOU"
      , title = "南から南から(みなみからみなみからとんできたきたわたりどり)"
      , filename = "minamikara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1C6pwVNYPaiIA0mHH5WKSvYbviXIspwP6"
      , mp3Url = "https://drive.google.com/uc?id=1XDbsIhW0p2E2-fwcJLh3NYix3pioGJvo"
      , title = "南の花嫁さん(ねむのなみきをおうまのせなにゆらゆらゆらと)"
      , filename = "minaminohanayomesan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DfzQhyLpJFCV_9QgnWXFkcApkIM246i8"
      , mp3Url = "https://drive.google.com/uc?id=1gQlf0NTFvqGCKTRLNLqK9HNUkxhocz8n"
      , title = "名月赤城山(おとこごころにおとこがほれて)"
      , filename = "meigetsuakagiyama.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11Y16Qe2dBALGvvLp55auX5sDJeqSgLx7"
      , mp3Url = "https://drive.google.com/uc?id=1YAy4ZqU5nZb_idmKp8ixyv1NO0KBNR2o"
      , title = "めだかの学校(めだかのがっこうはかわのなかそっとのぞいてみてごらん)"
      , filename = "medakanogakko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1rqeoX0jtDBItVwYGgZGNfSF8DjZ8GmDq"
      , mp3Url = "https://drive.google.com/uc?id=1-7GKTN2GEvTCmLvyZuT5dISgvTERoIzB"
      , title = "めんこい仔馬(ぬれたこうまのたてがみをなでりゃりょうてにあさのつゆ)"
      , filename = "menkoikouma.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xIQXsYHI29teWlQMpwjIkQ2M-ApojW32"
      , mp3Url = "https://drive.google.com/uc?id=1WA-UT-iyUgkodZUB_CK-BNxrTeqMSys1"
      , title = "もしも月給が上がったら(もしもげっきゅうがあがったら)"
      , filename = "moshimogekkyu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Il-iaEBb3PUcaJ051-Mcjy3sVfenb9WI"
      , mp3Url = "https://drive.google.com/uc?id=19PadJFpwyrIGrdvF6VrkeRH7PW5sRUM6"
      , title = "ヤットン節(おさけのむなさけのむなのごいけんなれどよいよい)"
      , filename = "yattonbushi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MHVjWA4uUpDM09SJuVv5IFCXvo4mzXDA"
      , mp3Url = "https://drive.google.com/uc?id=1a2Wzdn_tKRXXf_Fx6vMHmoR3xIIk5yS9"
      , title = "朝だ元気で(あさだあさだよあさひがのぼる)"
      , filename = "asadagenkide.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-GWUevcCLstjy500ypKC-DqIPLWcry8W"
      , mp3Url = "https://drive.google.com/uc?id=1vZWYt2wWePO_XZDLmNQXgqrcvTPHCKvS"
      , title = "朝はどこから(あさはどこからくるかしらあのそらこえてくもこえて)"
      , filename = "asawadokokara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hVC3GPmExEyk1FqCIflNL0Grs5qGl_DX"
      , mp3Url = "https://drive.google.com/uc?id=1v_CR8XOeJf3EwPmh5xMLnLbX3VYsx3KH"
      , title = "明日があるさ(いつものえきでいつもあうせーらーふくのおさげがみ)"
      , filename = "ashitagaarusa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1A-JjFub_fZnhm_kmRpHSh16SrS2ngKtL"
      , mp3Url = "https://drive.google.com/uc?id=1YMI84p-Bsdfz39PLD9XGp-X2azC_ZvAP"
      , title = "あなたと共に(あなたとともにゆきましょうこいのあまさとせつなさを)"
      , filename = "anatatotomoni.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Pwx4J5PcqXMDNKnbW3bMyAeF4A43B_ww"
      , mp3Url = "https://drive.google.com/uc?id=1N4xWta0guFcT6YnSouHM94y-OAw61loy"
      , title = "あの丘越えて(やまのまきばのゆうぐれにかりがとんでるただいちわ)"
      , filename = "anookakoete.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Vk0CnglxPOdmRx4JuR7YJ7MoFueLOhC5"
      , mp3Url = "https://drive.google.com/uc?id=1FKlC813qr12dZZgnsRHs7j_mdql4V_q9"
      , title = "アンパンマンのマーチ(そうだうれしいんだいきるよろこびたとえむねのきずがいたんでも)"
      , filename = "anpanmannomarch.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14vqGkjpvCzbwzXkqCZEFy7q6iqZg34ca"
      , mp3Url = "https://drive.google.com/uc?id=1FNQRBd7sh3l5tlmf8phC5Z3lB0NXsNbj"
      , title = "急げ幌馬車(ひぐれかなしやあれのははるかいそげほろばしゃすずのねだより)"
      , filename = "isogehorobasha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1fl93mWG8JV2peZUL50hALBkdcQxmh-jh"
      , mp3Url = "https://drive.google.com/uc?id=169_LPOMfYRxqvVgQpdc8_ADvXgJTZB92"
      , title = "潮来笠(いたこのいたろうちょっとみなればはくじょうそうなわたりどり)"
      , filename = "itakogasa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1amYTWIaVCEKZwVJyysXFA2qZxXtXRME3"
      , mp3Url = "https://drive.google.com/uc?id=1qcMXjUH3DnBhyNCdzLmJakgNYdI1TbWs"
      , title = "いつでも夢を(ゆめよりひそかにあめよりやさしく)"
      , filename = "itsudemoyumewo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ERyZrxG6L1M_HGi5HXzItITo4sjnERBV"
      , mp3Url = "https://drive.google.com/uc?id=1Eizx51QLS-iwL_w2CD9tm4GOu41mWckT"
      , title = "一杯のコーヒーから(いっぱいのこーひーからゆめのはなさくこともある)"
      , filename = "ippainocoffee.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xHbI3Bilbl6pY3ui35rhE9EswNZML4hf"
      , mp3Url = "https://drive.google.com/uc?id=1VDHv5taWemQjXok1-HkCHoqOc_ZjUhM4"
      , title = "いぬのおまわりさｎ(まいごのまいごのこねこちゃんあなたのおうちはどこですか)"
      , filename = "inunoomawarisan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vlCfa8zW_VfX5bWtj6ig4H1K1Pt7QR2B"
      , mp3Url = "https://drive.google.com/uc?id=1xSxdCheLKWN9EK-JAGiUkfC76VYD_CNB"
      , title = "王将(ふけばとぶようなしょうぎのこまに)"
      , filename = "ousho.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zM6STuAyc3-dua1REeJK7b6CE2Y6hG9B"
      , mp3Url = "https://drive.google.com/uc?id=1d-J4IR9ec3nsCqtegC5HF74k7KsbX5M5"
      , title = "お座敷小唄(ふじのたかねにふるゆきもきょうとぽんとちょうにふるゆきも)"
      , filename = "ozashikikouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ugUNS5b8WkyVjWTGNi5J7OFQUxwrhSEf"
      , mp3Url = "https://drive.google.com/uc?id=16Cq48x6K5NbJhJVgMxbiTaBLQHLT6rwA"
      , title = "おつかいありさん(あんまりいそいでごっつんこ)"
      , filename = "otsukaiarisan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MWj-haou11rWMLCU8KkS8NegV6hv23D9"
      , mp3Url = "https://drive.google.com/uc?id=1DNmMX2LsaxBnA7nDQ1CC8fX4ivqNcx1U"
      , title = "踊子(さよならもいぜずないているわたしのおどりこよああふねがでる)"
      , filename = "odoriko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1VdKP6dhtBT9qKAdsHnS9PYPDz_5FF3-n"
      , mp3Url = "https://drive.google.com/uc?id=16-qzOzoJ708YEioXDFDsLTPcY3xMjBv-"
      , title = "おどるポンポコリン(なんでもかんでもみんなおどりをおどっているよ)"
      , filename = "odoruponpokolin.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1R-2MfI9rlfUK8tcOeSNj1wUI_XEMIkB_"
      , mp3Url = "https://drive.google.com/uc?id=13kOsfS1xhiXqXOVfGnJB4gN_PENNWev2"
      , title = "おなかのへるうた(どうしておなかがへるのかなけんかをするとへるのかな)"
      , filename = "onakanoheruuta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1k8F6O53M-Fc1rOdVuc67FazlT6znhu5X"
      , mp3Url = "https://drive.google.com/uc?id=1gTew-4rDwIOqfs2bMEkmym41GRJOrJvw"
      , title = "思い出(久しき昔。かきにあかいはなさくいつかのあのいえ)"
      , filename = "omoidehisashikimukashi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1LUp20EYnPxO5V9Nn2hyt2MpF3fmIP5Uv"
      , mp3Url = "https://drive.google.com/uc?id=1rXNSh_mdYsLCqyuwrFOVzVXxUd4x1Z-O"
      , title = "おもちゃのマーチ(やっとこやっとこくりだしたおもちゃのまーちがらったった)"
      , filename = "omochanomarch.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1FRyVq8OlvVEviROKsuNh0lr-0FFfQsE2"
      , mp3Url = "https://drive.google.com/uc?id=1IfPVJ7RLaWHH6Wt3jatqjZt-se-3bErI"
      , title = "およげ！たいやきくん(まいにちまいにちぼくらはてっぱんのうえでやかれて)"
      , filename = "oyogetaiyaki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11x1ZcVCjEyN6_spbaxBz20u92xiyEica"
      , mp3Url = "https://drive.google.com/uc?id=1tORun5QbN5CTRtC59N9mE1LXOcwSpc2T"
      , title = "蛙の笛(つきよのたんぼでころろころろころろころころなるふえは)"
      , filename = "kaerunofue.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1H4H5rUpatgt1bVOkIPL7smqTQ74CD9Ha"
      , mp3Url = "https://drive.google.com/uc?id=1GZhzJ98hF5qoC8qP1g4yQnL3KVngW0EA"
      , title = "からすの赤ちゃん(からすのあかちゃんなぜなくのこけこっこのおばさんに)"
      , filename = "karasunoakachan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vT88WA2hXC3fNPotIvF8Tj_h8gnd57nC"
      , mp3Url = "https://drive.google.com/uc?id=1LOGGXDXXDOTPavjjQ5bArflBHs9PsjYp"
      , title = "岸壁の母(はははきましたきょうもきた)"
      , filename = "ganpekinohaha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1HsptCaVyFdz12fDMJ6xFat-q4XfrTyZ2"
      , mp3Url = "https://drive.google.com/uc?id=1XH0X3-kdKtBLBpZYpSjtUJnD_63OSc2U"
      , title = "菊の花(みごとにさいたかきねのこぎく)"
      , filename = "kikunohanamigoto.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dvWukpJ9bg8h5yr7j1wTrTChebvMdU6b"
      , mp3Url = "https://drive.google.com/uc?id=1BvfSF7flIwnCUpJvKBiwk5IonDE_3dNH"
      , title = "北風小僧の寒太郎(きたかぜこぞうのかんたろうことしもまちまでやってきた)"
      , filename = "kitakazekozo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1VsvxpIEq69PMI0xzrjpFZjhO8_oN_JZp"
      , mp3Url = "https://drive.google.com/uc?id=10OM60Au2tCwajRVD6VwLg9oJfry-SOBd"
      , title = "銀座の恋の物語(こころのそこまでしびれるような)"
      , filename = "ginzanokoi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1YD1WrrHXcweF6N9ga_r2KpsArb3R0CG5"
      , mp3Url = "https://drive.google.com/uc?id=1AaazqCUyWRwGJdsMWmz5yJnSdz60X3W6"
      , title = "銀座の柳(うえてうれしいぎんざのやなぎえどのなごりのうすみどり)"
      , filename = "ginzanoyanagi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1gtmtZW3T8zF7ed03Rjhzp1TxmQHveBDE"
      , mp3Url = "https://drive.google.com/uc?id=1-Zq8l5meNVc4tB2XL1uUTAwvmaTryS76"
      , title = "古城(まつかぜさわぐおかのうえこじょうよひとりなにしのぶ)"
      , filename = "kojomatsukaze.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1NvTghRz9ZG3UAVsdzxtX0Ip3rxRihlCJ"
      , mp3Url = "https://drive.google.com/uc?id=1W-AbkVU63n1ljFHDIqglp1Ay7zYy1C-X"
      , title = "金剛石(こんごうせきもみがかずばたまのひかりはそわざらん)"
      , filename = "kongoseki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1likk46ULJFq7wwgf_EU200B0LmPYWRrK"
      , mp3Url = "https://drive.google.com/uc?id=1otq8zxqht0nHisCbb9TJeGVUTsr1LsoA"
      , title = "こんなベッピン見たことない(とかなんとかおっしゃって)"
      , filename = "konnabeppin.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10PjNsDKRJM9yKxFtXLZ9e3C9PC9ghuYm"
      , mp3Url = "https://drive.google.com/uc?id=1Cb1Qkw0z1nbIUKh4bc2GEnt-pPwITUMm"
      , title = "酒は涙か溜息か(さけはなみだかためいきかこころのうさのすてどころ)"
      , filename = "sakewanamidaka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1B1qy-Fx3As7rBStil6UedkOWeHmSBjos"
      , mp3Url = "https://drive.google.com/uc?id=15_gEz9U8KJVVlSvwWxXfvk_ZbfTzaqme"
      , title = "サザエさん(おさかなくわえたどらねこおっかけて)"
      , filename = "sazaesan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1YU5UzOsy4btPB2IE125JWDMXZj9zkTYR"
      , mp3Url = "https://drive.google.com/uc?id=1vWZKIGzUjpWHUEj6H5R0LG_-523zeH_M"
      , title = "支那の夜(しなのよるしなのよるよみなとのあかりむらさきのよに)"
      , filename = "shinanoyoru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1oH59TUvsT3knxtCqfiYXw74IJ5vPa7CS"
      , mp3Url = "https://drive.google.com/uc?id=1atS4IL6klemsIDrBTYnzHKGy32aq_kPX"
      , title = "島育ち(あかいそてつのみもうれるころかなもとしごろ)"
      , filename = "shimasodachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Osoi7iji9KpNwEfHzOtRe_UvLSuGSgf2"
      , mp3Url = "https://drive.google.com/uc?id=1ZyJMHNfNWxs1lVjQc1gWm_FLFwWzgloT"
      , title = "十人のインディアン(ひとりふたりさんにんいるよ)"
      , filename = "juninnoindian.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zhlTQYwkeYRaqANA5mh4vS0D5saPePvw"
      , mp3Url = "https://drive.google.com/uc?id=1UfywMJBtHMymfThVohUfv0y7GvuotD1_"
      , title = "鈴懸の径(ともとかたらんすずかけのみち)"
      , filename = "suzukakenomichi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Q0qH_0p1MR6UUW1QBvdYz6642lhH75P0"
      , mp3Url = "https://drive.google.com/uc?id=1zoeWt3vNzE8i7PjOoNrZKbBS1xOtE8Qi"
      , title = "すずめのおやど(すずめすずめおやどはどこだ)"
      , filename = "suzumenooyado.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kQPf5zZfvnux8K_t4Kmsu9CQqJb5ocC-"
      , mp3Url = "https://drive.google.com/uc?id=16BqXu8U5B6fI1lWqU07N7KS5ZW7h6C1f"
      , title = "スワニー河(はるかなるすわにーがわきしべに)"
      , filename = "swaneeeriver.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ZUv2tOtgWXdsAuiqjsUqZeItumJmCBpE"
      , mp3Url = "https://drive.google.com/uc?id=15Qk-sIBGBKQWyWJfeudHHM6RLaBDyoUB"
      , title = "ズンドコ節(きしゃのまどからてをにぎりおくってくれたひとよりも)"
      , filename = "zundokobushi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1EG2nfViJHp1AtKfQzmtf8D6x12VXhKcB"
      , mp3Url = "https://drive.google.com/uc?id=1-M21VTcmF33yFbyaBWw_kqgF6s7ZP7-f"
      , title = "世界の国からこんにちは(日本万国博覧会テーマソング)"
      , filename = "sekainokunikara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1fsbkrj60p7YmP1bOpLGwZx0Ji54TW0_w"
      , mp3Url = "https://drive.google.com/uc?id=1-FVDpRyUsuYNUOrHflIyEupMlYokKYO1"
      , title = "早春賦(はるはなのみのかぜのさむさやたにのうぐいすうたはおもえど)"
      , filename = "soshunfu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1SytM-xPldwAyAwNqVzU9xw2X-gjsoFMJ"
      , mp3Url = "https://drive.google.com/uc?id=1Ib1GyXhDHrtXzo2w8nC9kxfZooIqTDzF"
      , title = "旅笠道中(よるがつめたいこころがさむい)"
      , filename = "tabigasadochu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dKDWiLxyszzCNp1rJ2iHPIfzJvZGTOpa"
      , mp3Url = "https://drive.google.com/uc?id=1NOg3BTkpvvHlgVJwqzrpHhrhve0BO0fO"
      , title = "ちいさい秋みつけた(だれかさんがだれかさんがみつけたちいさいあき)"
      , filename = "chiisaiaki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zIb5hbeyywQ9JkxF4zRfamDYw9-ns1SN"
      , mp3Url = "https://drive.google.com/uc?id=1yYGOUVkXXFmgsX1OEUqiMHKIULC1NgOz"
      , title = "チャンチキおけさ(つきがわびしいろじうらのやたいのさけのほろにがさ)"
      , filename = "chanchikiokesa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=12k0hRcfHaNGw_QRrgjRbcC4I274g5-Kb"
      , mp3Url = "https://drive.google.com/uc?id=1T2llU8_4nUKfAEAq3A4ZW_WxJ-_lYR4r"
      , title = "ちんちん千鳥(ちんちんちどりのなくよさは)"
      , filename = "chinchinchidori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1t2z-Vcp0py1WseAXOhWGZlJPawhUBAoR"
      , mp3Url = "https://drive.google.com/uc?id=15jUCVSC1yfT0N8ZsbQJVDV21dgM8DdeB"
      , title = "月がとっても青いから(つきがとってもあおいからとおまわりしてかえろう)"
      , filename = "tsukigatottemoaoikara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1NxCJFZ_3fOpJ9hsdOVpNauk6jeCIa93B"
      , mp3Url = "https://drive.google.com/uc?id=1vNh-4kTyubzJhrKk7neD9FXT1hWVvNpW"
      , title = "手のひらを太陽に(ぼくらはみんないきているいきているからうたうんだ)"
      , filename = "tenohirawotaiyoni.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11BHZJGzaBzOdzWywRczeDqIg1LLI1X_q"
      , mp3Url = "https://drive.google.com/uc?id=1sIvUq3e91GNFMCViPVrJijl0W4f81xfX"
      , title = "出船(こよいでふねかおなごりおしや)"
      , filename = "defune.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1I7GFqRf8IfMnKL0CEbldbTi4oXodLsFw"
      , mp3Url = "https://drive.google.com/uc?id=1q99n_0QBUYdPNTdyHQ9gJwyUM34Pajlx"
      , title = "電車ごっこ(うんてんしゅはきみだしゃしょうはぼくだ)"
      , filename = "denshagokko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1QpimiLb5O2YB-1EnyOuYL8VFbNRcw2XK"
      , mp3Url = "https://drive.google.com/uc?id=1rIO-H89u5uUL1QiSpubw0c6w9fGSqfgd"
      , title = "電車唱歌(たまのみやいはまるのうちちかきひびやにあつまれる)"
      , filename = "denshashoka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1UY2f3o0mdMUABi5IGJAlZeG0HIqhIYHY"
      , mp3Url = "https://drive.google.com/uc?id=1GW17ibcgrE-BmWLzqyFxM67UR6NhMjWd"
      , title = "東京五輪音頭(はあーあのひろーまでながめたつきが)"
      , filename = "tokyogorinondo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1YfkxKSBOMqwKz0xYSQ9ErJtMy6zGjHWa"
      , mp3Url = "https://drive.google.com/uc?id=1c01TkCmYlaxyhh44rYVkyn13ehX-kGNi"
      , title = "東京ドドンパ娘(すきになったらはなれられない)"
      , filename = "tokyododonpamusume.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=149Lgkk-WlqgUw9tjCyq71dLYtiVCkXV5"
      , mp3Url = "https://drive.google.com/uc?id=13QxLFqAoz3ON6QPb7UQHBkyTK9_B-UIA"
      , title = "東京ナイト・クラブ(なぜなくのまつげがぬれてる)"
      , filename = "tokyonightclub.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DP-029YRN1nPvWbfhPHH6Exw-Iy9s0Mn"
      , mp3Url = "https://drive.google.com/uc?id=1Sfe-rbmE8bI9ODkAj7FeP9GEdY833keE"
      , title = "東京の花売り娘(あおいめをふくやなぎのつじにはなをめしませ)"
      , filename = "tokyonohanaurimusume.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1t9w4qH69fSxo2nwgxTsbNScGC6ko1laE"
      , mp3Url = "https://drive.google.com/uc?id=1QZEYwPq04AOaAwK0uYcbBRcCCRYZD4hS"
      , title = "東京ブギウギ(とうきょうぶぎうぎりずむうきうきこころずきずきわくわく)"
      , filename = "tokyouboogie.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kuOIChq2d3mHiKEXr8gCQl8HvdaKppJV"
      , mp3Url = "https://drive.google.com/uc?id=1UQKXazVk_YrgdC201b25xAHZtpFas4Kz"
      , title = "鉄道唱歌(きてきいっせいしんばしをはやわがきしゃははなれたり)"
      , filename = "tetsudoshoka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1V8uaqsZwfnPKvZKPOElf7htbSYzOKY7r"
      , mp3Url = "https://drive.google.com/uc?id=1G3kfBDQApHjHd5SWsUb0FhHjOYqXVJXn"
      , title = "灯台守(とうだいもり。こおれるつきかげそらにさえて)"
      , filename = "todaimori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1psLWnJ6aIpN6TfGt-hw2FWWpYiFLYGMx"
      , mp3Url = "https://drive.google.com/uc?id=1uOkBK2FjkTPORzRRboiI_6nJg7aFViTd"
      , title = "どじょっこふなっこ(はるになればすがこもとけて)"
      , filename = "dojokkofunakko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1d8DwVJn3lPRUTfp7fRpfN9NMjP4Hqi3O"
      , mp3Url = "https://drive.google.com/uc?id=1quQ562FctloYK-8DlaKVwQ3qjOhEaAYN"
      , title = "ともしび(よぎりのかなたへわかれをつげおおしきますらおいでてゆく)"
      , filename = "tomoshibi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=18aeQgO1Xh5yickWCOmEZYDUot_SuOtXW"
      , mp3Url = "https://drive.google.com/uc?id=1sdUEUfge7sFda4nLMNuumlSrql7RHZ4Q"
      , title = "ドラえもんのうた(こんなこといいなできたらいいなあんなゆめこんなゆめ)"
      , filename = "doraemonnouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1RataNI2M6tBzyMMhAoZRAuHyDaNjg-VU"
      , mp3Url = "https://drive.google.com/uc?id=18CBPhCOg-WC1bC7_WhUb-GichrGmZ0z0"
      , title = "とんでったバナナ(ばなながいっぽんありましたあおいみなみのそらのした)"
      , filename = "tondettabanana.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=17xwtKTv8r9J-DgZiyMr7ryvjTzA_hIF7"
      , mp3Url = "https://drive.google.com/uc?id=1_TR8IzwLmpJUDFpib7Y-yoGQfQZYGSiv"
      , title = "長崎の女(こいのなみだかそてつのはながかぜにこぼれるいしだたみ)"
      , filename = "nagasakinohito.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Yz5GrFUIXuHCN6vihtQLf9mR2EzGGHYr"
      , mp3Url = "https://drive.google.com/uc?id=1mNAraXiEhauX8srJ9OrWhBSAkGpc7ok2"
      , title = "箱根八里の半次郎(まわしがっぱもさんねんがらす)"
      , filename = "hakonehanjiro.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13dJTLAO8F8z7YPy75AOT2JDlkYCjxYKb"
      , mp3Url = "https://drive.google.com/uc?id=1P6AB-LfyhKfpqcelnAbrx4oswcVl15-4"
      , title = "波浮の港(はぶのみなと。いそのうのとりゃひぐれにゃかえる)"
      , filename = "habunominato.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1mBQp_MaMFHhgM1drzi2MBqrunNprJPgj"
      , mp3Url = "https://drive.google.com/uc?id=1Yz38_eSeTYvGSXirRp5TgRwpiPo7VI1V"
      , title = "春の風(るるるるーるる、ルルルルールル)"
      , filename = "harunokaze.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ykPexfa15ZePlt9QzyZeQibOUdod9tJA"
      , mp3Url = "https://drive.google.com/uc?id=1Ettr4jhF6g3YfgmF-e0DB4N9TP6hS9yJ"
      , title = "瓢箪ブギ(のめやうたえやよのなかはさけださけだよひょうたんぶぎ)"
      , filename = "hyotanboogie.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1X2x5KBHwxeobEQAVGB-KG9mg-M68sLvH"
      , mp3Url = "https://drive.google.com/uc?id=1XyCX5aTPYk907EzmoelseT1eGyQfI-WU"
      , title = "琵琶湖周航の歌(われはうみのこさすらいのたびにしあればしみじみと)"
      , filename = "biwakoshukonouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=18laaM8twLWg4tX_ED3cuU1H0LZNpLsJo"
      , mp3Url = "https://drive.google.com/uc?id=1Aza1bIhIsb-a8tPLu536Yr4eMfgRdM1N"
      , title = "婦人従軍歌(ほづつのひびことおざかるあとにはむしもこえたてず)"
      , filename = "fujinjugunka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zzlEqMW8mSKV88GXV7WX8PX0DK62H6Jy"
      , mp3Url = "https://drive.google.com/uc?id=1Q_6c0sojHQBvXjHXye5vu_yXc-TG-GcP"
      , title = "星に願いを(ほしにねがいを。ディズニー。かがやくほしにこころのゆめを)"
      , filename = "hoshininegaiwo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1_2JhApHIZTvo9l8SGm9R7jVxsOk0_hnl"
      , mp3Url = "https://drive.google.com/uc?id=1PN0XWNwyz-orvg5l7IjpYoF0saCexAni"
      , title = "北帰行(まどはよつゆにぬれてみやこすでにとおのく)"
      , filename = "hokkikou.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jaXTRwCDY3p9j4bWiAlmGu3IN8fRSbek"
      , mp3Url = "https://drive.google.com/uc?id=1EE4Y_oeYhdtIquMp78qMOA6GObJKD6tX"
      , title = "街のサンドイッチマン(ろいどめがねにえんびふく)"
      , filename = "machinosandwichman.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14z3L_4MQitDF4cQxxS2_eBXTWefGvF3A"
      , mp3Url = "https://drive.google.com/uc?id=1sqp1rQCdMiuhWqKEdAxp01z6aFJ4fhhI"
      , title = "まつの木小唄(まつのきばかりがまつじゃない)"
      , filename = "matsunokikouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qiT3eRO0g02Vf3GbGKMydkX4k5Q81_Nj"
      , mp3Url = "https://drive.google.com/uc?id=1Up6WfNHxj4ByH8Adqd-UQS8xt8rKGyPT"
      , title = "見上げてごらん夜の星を(みあげてごらんよるのほしを)"
      , filename = "miagetegoranyorunohoshiwo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13-c9arClb6QFamTLvcCAYSJw2DZHpl4C"
      , mp3Url = "https://drive.google.com/uc?id=1u4G4R-Bi4FqPS2Z44ht2V8TpaNiqUZ8S"
      , title = "緑のラララ(部分。やわらかいみどりのすずしそうなこかげ)"
      , filename = "midorinolalala.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1p-QAlRuuB4MRxnihbv5GY02Ar1a4lgqO"
      , mp3Url = "https://drive.google.com/uc?id=1wWhh3k91vGC9H2fP7Z0tnZXY3odUT8w6"
      , title = "皆の衆(みなのしゅうみなのしゅううれしかったらはらからわらえ)"
      , filename = "minanoshu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1FLeafv0rojMnZIaaUeZmzuGtBoeFh8JZ"
      , mp3Url = "https://drive.google.com/uc?id=1fYtlPit_MfyeDLa2Nh36JY26RWsroZiz"
      , title = "南の島のハメハメハ大王(みなみのしまのだいおうはそのなもいだいな)"
      , filename = "minaminoshimanohamehameha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Z65dM8KfBmELaptoUQAKA8OP1f3mwbKO"
      , mp3Url = "https://drive.google.com/uc?id=1K-05i9GtdnX0EXuiPy9VXNt0myLD2ynI"
      , title = "めざせポケモンマスター(たとえひのなかみずのなかくさのなかもりのなか)"
      , filename = "mezasepokemonmaster.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1EDociRsT8FfPt2Tr4-oVxRM3cldWjmwK"
      , mp3Url = "https://drive.google.com/uc?id=1SAwr7wkV7BAQJcWhxA6XXok3rA5JPtIm"
      , title = "山男の歌(むすめさんよくきけよやまおとこにゃほれるなよ)"
      , filename = "yamaotoko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1x1Y5v8MQyJMrAXbIWigRdSwwVJoJaQ5Y"
      , mp3Url = "https://drive.google.com/uc?id=1hcWpHdbxPCzVIEDyvDTg7MBmMHcG8jfy"
      , title = "山のかなたに(やまのかなたにあこがれて)"
      , filename = "yamanokanatani.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1nCZ7HvP9h_OIAzIS4_4eCVlyYS-qCI0S"
      , mp3Url = "https://drive.google.com/uc?id=1yCOzw40_9dRSAJ_TxNP5naYm-QpmWXRw"
      , title = "山の煙(やまのけむりのほのぼのとたゆとうもりよあのみちよ)"
      , filename = "yamanokemuri.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MrrQdT__ZnMn8MtuMOuiM0mQAyCG1TZB"
      , mp3Url = "https://drive.google.com/uc?id=1jMJCj2EyYfn27aeIHKL5Pw3lZHj1FWv5"
      , title = "夕焼けとんび(ゆうやけぞらがまっかっかとんびがぐるりとわをかいた)"
      , filename = "yuyaketonbi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-BOmLZ1EacwXes2Ypa5xsGPG_jwnWO38"
      , mp3Url = "https://drive.google.com/uc?id=1ZJJAgQmBs90hzbftoka_7aOsc7M3TbEE"
      , title = "雪の降るまちを(ゆきのふるまちをおもいでだけがとおりすぎてゆく)"
      , filename = "yukinofurumachiwo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1RExYyz0efwWl53w6UjTC0iUCekp6BZLz"
      , mp3Url = "https://drive.google.com/uc?id=1fCIJqWWSOQYIIsRc0oRNiLN4mlVnZ2Fn"
      , title = "夢のお馬車(きんのおくらにぎんのすず)"
      , filename = "yumenoobasha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=140dwbYUx-5qGlPsZOGrHbfg6EkiFdLFd"
      , mp3Url = "https://drive.google.com/uc?id=1qdBqMmRvsXIgue9bo8u-4REXpfkn3mRK"
      , title = "夜汽車(いつもいつもとおるよぎしゃしずかなひびききけば)"
      , filename = "yogisha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1PjcFkuTLhtk1BnjdtHwL56Dlh2gT6n7h"
      , mp3Url = "https://drive.google.com/uc?id=1Pp3P6h765Me0xrpapuhBCa47eHJXFh3h"
      , title = "与作(よさくはきをきるへいへいほーへいへいほーこだまはかえるよ)"
      , filename = "yosaku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ovtSeVpM7RzZjDC7oOXAYh7RwTAUZtqm"
      , mp3Url = "https://drive.google.com/uc?id=1T9D3p5uDV-8CaOGwfOkbfQGWJLP9FRMp"
      , title = "若葉(あざやかなみどりよあかるいみどりよ)"
      , filename = "wakaba.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1FIqVVQ0FReNVxwJhkK4u7EisH_ax-NRU"
      , mp3Url = "https://drive.google.com/uc?id=1HBhrTDZ1D0a4knowd5we0yUvpIcJaYUl"
      , title = "若者たち(きみのゆくみちははてしなくとおい)"
      , filename = "wakamonotachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1d9-P8324JXfDDBJjrEAsGSIM6rSrMyA0"
      , mp3Url = "https://drive.google.com/uc?id=1DT9yyJ1tViQJmxT__xi5Hl03V3w6LA3o"
      , title = "別れの一本杉(わかれのいっぽんすぎ。なけたなけたこれえきれずになけたっけ)"
      , filename = "wakarenoipponsugi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1n2kt6Ude-KAuYz5xmfn-bLxRJFmhZJn_"
      , mp3Url = "https://drive.google.com/uc?id=1KYZsyIGh5xvLZIIfAHJsvVkBCb76e9xv"
      , title = "クラリネットをこわしちゃった(ぼくのだいすきなくらりねっとぱぱからもらった)"
      , filename = "clarinet.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1F9NG31NL3lDR4vncZoKmT-r1uoSgtSam"
      , mp3Url = "https://drive.google.com/uc?id=1J-HpZ5iLAhbofQ2MsdF8Qnh8ysLYkDqE"
      , title = "サッちゃん(さっちゃんはねさちこってゆうんだほんとはね)"
      , filename = "sacchan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1F5hGANBZOuobWLrsuWU507raox_nnbCv"
      , mp3Url = "https://drive.google.com/uc?id=1TiJqLkoIl-GP1CnICH_Cz6QTo1wBCKh8"
      , title = "ねこふんじゃった(ねこふんじゃったねこふんづけちゃったらひっかいた)"
      , filename = "nekofunjatta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Mbu9aHQzy7pFgF77tinmxkjRrNdfWVCU"
      , mp3Url = "https://drive.google.com/uc?id=1J3lbVsYnqIqu1DcUBb3gYqGeHM1jhD6W"
      , title = "酸模の咲く頃(すかんぽのさくころ。どてのすかんぽじゃわさらさ)"
      , filename = "sukanpo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kpmALsspWi00RoVFfsjC_zuscrisivtl"
      , mp3Url = "https://drive.google.com/uc?id=1uTI82AJsTqL_hB9hgSq4dU_T_11Ijir4"
      , title = "からたちの花(からたちのはながさいたよしろいしろいはながさいたよ)"
      , filename = "karatachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1QClrbNzb2JwQ_oe_PwH_ku_F6GwaXMHA"
      , mp3Url = "https://drive.google.com/uc?id=1N5VHD9jjx5xLBBdsXAGXvmwJiisnZRDj"
      , title = "あわて床屋(はるははようからかわべのあしにかにがみせだしとこやでござる)"
      , filename = "awatedokoya.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DZzek4Bzxawaslnh_inmlqvgxMmys85z"
      , mp3Url = "https://drive.google.com/uc?id=1haMTc2hfXORPordu43P9np36igcbjNTb"
      , title = "待ちぼうけ(まちぼうけあるひせっせとのらかせぎそこへうさぎがとんででて)"
      , filename = "machiboke.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1WYGGeJlFYvp4mBmLhNhQITf4y8HktJkJ"
      , mp3Url = "https://drive.google.com/uc?id=1VoI1_ZLkNbD4QerbJCMuQj89TBAf1Ebx"
      , title = "平城山(ならやま。ひとこうはかなしきものとならやまに)"
      , filename = "narayama.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13-pP6mK_PG0qeH_QQzaYnDuxs2_XXq-X"
      , mp3Url = "https://drive.google.com/uc?id=1Xo12Aq8VE8Mmk8DjtNED8ReGcO5qz2QA"
      , title = "いい湯だな(いいゆだなゆげがてんじょうからぽたりとせなかに)"
      , filename = "iiyudana.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=15ZLUZJJfHr7n_QYexKlGzIel3URbH5-e"
      , mp3Url = "https://drive.google.com/uc?id=1EC9giv_loKt9I4FdVTh0E8eATj6Mg-HA"
      , title = "女ひとり(きょうとおおはらさんぜんいんこいにつかれたおんながひとり)"
      , filename = "onnahitori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ZWqRJNkJ4wbiNNiQ6o22FVaFUXtTPHjs"
      , mp3Url = "https://drive.google.com/uc?id=1_zDbhALoG79Dcwd6N4g-rT896I8Z_t4k"
      , title = "ああ上野駅(どこかにこきょうのかおりをのせてはいるれっしゃのなつかしさ)"
      , filename = "aauenoeki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ktg-vuPnOLwsXmJ17IyAJ4cOiesm9HwT"
      , mp3Url = "https://drive.google.com/uc?id=1n5f1dXa6ww-y9kYEmzpeF_HGtZ5AFt_u"
      , title = "おーい中村くん(おーいなかむらくんちょいとまちたまえ)"
      , filename = "ooinakamurakun.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=168G6DSHnkm5OuBEOLEoQ44tvZDNwfPiX"
      , mp3Url = "https://drive.google.com/uc?id=1b_4-3s-e5tFVGVtPB0e_dNuZsQNtUorn"
      , title = "さざんかの宿(くもりがらすをてでふいてあなたあしたがみえますか)"
      , filename = "sazankanoyado.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1eDaAs_rEDb2Djp2je7ZtQawjhHXfF4qf"
      , mp3Url = "https://drive.google.com/uc?id=1ZlSA2lqbu-EW0dUklOc1y7iXgN8tf6tA"
      , title = "月の法善寺横丁(ほうちょういっぽんさらしにまいて)"
      , filename = "tsukinohozenjiyokocho.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kBjHydGIevVt-5kFh6xSihxzoIQPmj64"
      , mp3Url = "https://drive.google.com/uc?id=1pmxadKCT3OA4QIuHpNmZJD9LnG4sbquF"
      , title = "もずが枯木で(もずがかれきにないている)"
      , filename = "mozugakarekide.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1oXkCVtUekuBQuYIEFearLA8sriKVX_dG"
      , mp3Url = "https://drive.google.com/uc?id=1N60WpURXqFvH2QYejt-4BwFYdSkyhVtt"
      , title = "花の街(なないろのたにをこえてながれていくかぜのりぼん)"
      , filename = "hananomachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Le6bvwyQhohlfkIybTCQzsSRHJ1s_bxz"
      , mp3Url = "https://drive.google.com/uc?id=1qRqhI9N3i1HzVN09KCMWyl0CrnUeYZkm"
      , title = "さとうきび畑(ざわわざわわざわわひろいさとうきびばたけは)"
      , filename = "satokibibatake.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1gqJyYzLQyGSQidIz3-p78Vr4uCFSKqrm"
      , mp3Url = "https://drive.google.com/uc?id=1ukvRO7AYKbWgcI6DaFlVhiJXzgIaMg2i"
      , title = "未来へ(Kiroro。ほらあしもとをみてごらんこれがあなたのあゆむみち)"
      , filename = "miraie.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1d9cWCGVRCRPwYFTL3ml4gXkH-tSjE-xG"
      , mp3Url = "https://drive.google.com/uc?id=1Qb38xN5cHuvtCQy9_67U4dYI9RMA20Vw"
      , title = "武田節(かいのやまやまひにはえてわれしゅつじんにうれいなし)"
      , filename = "takedabushi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qmSiomS4zJV96WVclKHeoNlGEwpAyfs8"
      , mp3Url = "https://drive.google.com/uc?id=1qWnszRLv1TKXtBWz-e0AI1D51oGw3Vkl"
      , title = "昔の名前で出ています(きょうとにいるときゃしのぶとよばれたの)"
      , filename = "mukashinonamae.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xsPLMzmCyNHtJJmUh1M6I_ZLXuhxhHAg"
      , mp3Url = "https://drive.google.com/uc?id=1_Gtb5Mrz5gcaZO5M_yLeVjM4rhE2b2M7"
      , title = "矢切の渡し(つれてにげてよついておいでよゆうぐれのあめががふる)"
      , filename = "yagirinowatashi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1H20aFW6GcKuqqBbEXxnf29lkOWGuQYM0"
      , mp3Url = "https://drive.google.com/uc?id=1bZyq6SdmCGeTKWXex0b3Pr2duDkUfr4o"
      , title = "夢淡き東京(やなぎあおめるひつばめがぎんざにとぶひ)"
      , filename = "yumeawakitokyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1FOoTgOuA9Po9hTUxjbPEubo7obVsXiAV"
      , mp3Url = "https://drive.google.com/uc?id=1TYmf50LclTnG0N8RbsPYMs4ep5yH_b_3"
      , title = "愛燦燦(あめさんさんとこのみにおちてわずかばかりのうんのわるさを)"
      , filename = "aisansan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Np71eqZtxEvomnTJeYPo4JP2YiWb2xxs"
      , mp3Url = "https://drive.google.com/uc?id=1QRjMQhU1UoGkWallA1TSxOOnLLbgyMm1"
      , title = "北の宿から(あなたかわりはないですかひごとさむさがつのります)"
      , filename = "kitanoyadokara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1P8ntyZP7-CN3VOswaX3Jscu37boEOUMg"
      , mp3Url = "https://drive.google.com/uc?id=1a4DVQucEaMYo8PuFZoCgdUUkySwItnfa"
      , title = "九段の母(うえのえきからくだんまでかってしらないじれったさ)"
      , filename = "kudannohaha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1j8JHmclvwTlK6V00CoNTP09OLrCs76KJ"
      , mp3Url = "https://drive.google.com/uc?id=1TD7P6IPDsfHtgMbuNNZ-aq0-ea9cdYzG"
      , title = "心の窓に灯火を(いじわるこがらしふきつけるふるいせーたーあぼろしゅーず)"
      , filename = "kokoronomado.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1SVn8suS5uc0J5k4cyuRB0_8hOdG0czZd"
      , mp3Url = "https://drive.google.com/uc?id=1HEz0Bmkl9ZwhlD55uIsJ__0QX0f0PhZv"
      , title = "寒い朝(きたかぜふきぬくさむいあさもこころひとつであたたかくなる)"
      , filename = "samuiasa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1_KzOwnhccCne-WkYWrbxAXvknpHTYx7l"
      , mp3Url = "https://drive.google.com/uc?id=1wZW1_QzVAPi1xF5tDF8c1WLcH-7VJPab"
      , title = "誰よりも君を愛す(だれにもいわれずたがいにちかったかりそめのこいなら)"
      , filename = "dareyorimokimiwoaisu.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-Q2rixbBx-EujgLu8r1nC-LIj2MKbZkI"
      , mp3Url = "https://drive.google.com/uc?id=1hfiXIk1Sz1qfLSUrsR2Df-AR6VOhcHlh"
      , title = "時の流れに身をまかせ(もしもあなたとあえずにいたらわたしはなにをしてたでしょうか)"
      , filename = "tokinonagareni.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1im4pT5CvLGCRrvzX-3viEtZrhfhusbgI"
      , mp3Url = "https://drive.google.com/uc?id=12v75APPGDkwgvKVN-c97bus2RH0tALOj"
      , title = "せんせい(あわいはつこいきえたひはあめがしとしとふっていた)"
      , filename = "sensei.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qIj01WNFpUczZ3LiapqbNoicdurZj5pW"
      , mp3Url = "https://drive.google.com/uc?id=157cYs-AaQqYss2WRLJXAhULds6gbHbPq"
      , title = "水あそび(みずをたくさんくんできてみずでっぽうであそびましょ)"
      , filename = "mizuasobi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dWy2LToNLjSYRSpKW7GxEVUGqEQxkSK9"
      , mp3Url = "https://drive.google.com/uc?id=1OWNLPlejNxCNZf6rP5xYnk0xOGBwSuod"
      , title = "めえめえ児山羊(めえめえもりのこやぎこやぎはしればこいしにあたる)"
      , filename = "memekoyagi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=17OFTQ-qnlxePM8ezby0GY1-5wVBbmXiq"
      , mp3Url = "https://drive.google.com/uc?id=1w7YyZMyUhu89Pn6K-2BrFzdXUyOMKBj1"
      , title = "ぞうさん(ぞうさんおはながながいのねそうよかあさんもながいのよ)"
      , filename = "zosan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1fRKpKFf1Hz4b5fVFAJSuFP8HX283u-Mu"
      , mp3Url = "https://drive.google.com/uc?id=11ApI-0Uv5E28MAb9J4KqleslS6cn62_T"
      , title = "かわいいかくれんぼ(ひよこがねひよこがおにわでぴょこぴょこかくれんぼ)"
      , filename = "kawaiikakurenbo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1p4ItKHsJGoJCuBB7YQRqOFh23-Ejn7Uo"
      , mp3Url = "https://drive.google.com/uc?id=17_DE1Fm9kW3mqqM5lK_bS-TUvOydZXOR"
      , title = "なごり雪(きしゃをまつきみのよこでぼくはとけいをきにしてる)"
      , filename = "nagoriyuki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=19bZSEYQopL-r9bSNuaIsJ1Q9twz2qtFj"
      , mp3Url = "https://drive.google.com/uc?id=1b98QO-szIJJ1ucU3JIcg0p5d025fC7dz"
      , title = "新妻に捧げる歌(しあわせをもとめてふたりのこころはよりそいむすびあう)"
      , filename = "niidumanisasageru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1H0fp-TJi_yJbSGz-5ujVz7UFGeeEEuRE"
      , mp3Url = "https://drive.google.com/uc?id=1y5Fpxl86VPqVYwb2hZj9Ak7i2g0m1AuL"
      , title = "忘れな草をあなたに(わかれてもわかれてもこころのおくに)"
      , filename = "wasurenagusa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1q7LR9NRym_hLjBUp0myujgtIEeCdVbiY"
      , mp3Url = "https://drive.google.com/uc?id=1TKoeSDUjgbh7OjbH7tt0NUAghG1HfhKG"
      , title = "長崎は今日も雨だった(あなたひとりにかけたこいあいのことばをしんじたの)"
      , filename = "nagasakiwakyomoame.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14hK9n81-N7rtXR3ycga8XydzY8roIHnf"
      , mp3Url = "https://drive.google.com/uc?id=12ZgK8kQukUTCyKFZsTIs8uP3ZMuRVCy6"
      , title = "なみだの操(あなたのためにまもりとおしたおんなのみさお)"
      , filename = "namidanomisao.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1HXLzObOGG7MZ4jiBBgu3ONkuMUiqzv1F"
      , mp3Url = "https://drive.google.com/uc?id=1KQDAUieMkLmRfUoWbA90iUh2lS0p2noz"
      , title = "釜山港に帰れ(つばきさくはるなのにあなたはかえらない)"
      , filename = "fuzankoekaere.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Mj8H_z34-fvo-CuzMIsxcS2vAi6obONC"
      , mp3Url = "https://drive.google.com/uc?id=1YHjW0Dxt_JklI9B8rQ7G9tkBByZ5TyzV"
      , title = "雪国(すきよあなたいまでもいまでもこよみはもうすこしでことしもおわりですね)"
      , filename = "yukiguni.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1KcoYf679XJphD2HhiiWJPylPY0zinLWm"
      , mp3Url = "https://drive.google.com/uc?id=19NoxePXCt668HeGXBbmlVhxQYRReCH1L"
      , title = "たわらはごろごろ(おくらにどっさりこおこめはざっくりこでちゅちゅねずみは)"
      , filename = "tawarawagorogoro.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14TjNClzIuXLbzG6vGHxaZ7-ueAKhDTA_"
      , mp3Url = "https://drive.google.com/uc?id=1xK76vPJCZV8qFNv6cdNjC4uFuazgZcKJ"
      , title = "ひらいたひらいた(なんのはながひらいたれんげのはながひらいたとおもったら)"
      , filename = "hiraitahiraita.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Txchs-BO_nzG-fbv_2fs9LwZ5JvsBBEx"
      , mp3Url = "https://drive.google.com/uc?id=1yhaMMO09V51gz6QhYncIBjxEEHvkcCOF"
      , title = "島のブルース(あまみなちかしゃそてつのかげで)"
      , filename = "shimanoblues.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1CFiF6u39QHxgH2Ss68JTj1d5BKXP1jeC"
      , mp3Url = "https://drive.google.com/uc?id=1Cpmq9e6APinfOUwdLzx_CMrmsPbkjHrO"
      , title = "かぞえうた(ひとつとやーひとよあければにぎやかで)"
      , filename = "kazoeuta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1GEvdC4OKFgjIGxW1ueVvHjGQ_fPu5xVI"
      , mp3Url = "https://drive.google.com/uc?id=1gpsrhhgdfkGBo495Pyz6X6t0LVnNBNwb"
      , title = "青葉城恋唄(ひろせがわながれるきしべおもいではかえらず)"
      , filename = "aobajokoiuta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1U1wFHyb0OsxyR7pfJ5CehM2YClqYrsUa"
      , mp3Url = "https://drive.google.com/uc?id=1doelHvAKw9uBDPvnGmXX9RXVfG_t2_5O"
      , title = "雪椿(やさしさとかいしょのなさがうらとおもてについている)"
      , filename = "yukitsubaki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1e6GNpOaKdL2vfUASm82z_a9GijUPsQ6-"
      , mp3Url = "https://drive.google.com/uc?id=1FTNJRcHMExh9SNTiawD_KC_Ko8aR0iln"
      , title = "岬めぐり(あなたがいつかはなしてくれたみさきをぼくはたずねてきた)"
      , filename = "misakimeguri.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dV87sr49V6CBNBUxQ9xapvCnOM8Bb5Dh"
      , mp3Url = "https://drive.google.com/uc?id=1_buYtFUHvua23mPqpAU6lv5weEM1WYfZ"
      , title = "わたしの城下町(こうしどをくぐりぬけみあげるゆうやけのそらに)"
      , filename = "watashinojokamachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1slaAbuDC5FDpPA4uPt3eiAGpP89cjF8q"
      , mp3Url = "https://drive.google.com/uc?id=1WpQnEA8JI4BGBGz2GYSMDrRCxTx14AEY"
      , title = "赤いハンカチ(あかしやのはなのしたであのこがそっとまぶたをふいた)"
      , filename = "akaihankachi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1X4yvoXw-7skGPKdHx6SxWOBWZ8i-Bkgp"
      , mp3Url = "https://drive.google.com/uc?id=1U1xnLMGbVpqqMs52Fncf9KwJuvM_8kAH"
      , title = "小樽のひとよ(あいたいきもちがままならぬきたぐにのまちはつめたくとおい)"
      , filename = "otarunohitoyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ykFFz_CuhNbuqYzmtAFLpqOLqY_J95bO"
      , mp3Url = "https://drive.google.com/uc?id=1VNYKtNG3GxZqHLps3fM-tSKDcpAfxmoi"
      , title = "遠くへ行きたい(しらないまちをあるいてみたいどこかとおくへいきたい)"
      , filename = "tokueikitai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1o7DocZFn6wquf-8yKPzdQ6sbsOS4JstO"
      , mp3Url = "https://drive.google.com/uc?id=1FI3zYpS2_o5vy35QDK2ig18_MzeurGZL"
      , title = "昴(すばる。めをとじてなにもみえずかなしくてめをあければ)"
      , filename = "subaru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1PfPJsYDuhLFBELj41qsnPz-vgmfTLoYL"
      , mp3Url = "https://drive.google.com/uc?id=1Bv9XJuv2u6q4bMiaaqlnqx1Mf-nhh3gK"
      , title = "ラブユー東京(なないろのにじがきえてしまったのしゃぼんだまのようなわたしのなみだ)"
      , filename = "loveyoutokyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10Xo_WwZrgee2a1HYoXoD6PbOEZaiJKhF"
      , mp3Url = "https://drive.google.com/uc?id=1sf_fnMm0MqM4DAVQhUXFNCpCYtI_Gn9N"
      , title = "贈る言葉(くれなずむまちのひかりとかげのなかさりゆくあなたへ)"
      , filename = "okurukotoba.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1p2Vjqf57-P-2OgNeuhIUSX42YYSAAwEi"
      , mp3Url = "https://drive.google.com/uc?id=1D5XMEIYVaOZIoRhu4eg5h9nrH4-rWwA7"
      , title = "おさななじみ(おさななじみのおもいではあおいれもんのあじがする)"
      , filename = "osananajimi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DNDBoOuB2F9B_KonRGpcznA9wNg1p80o"
      , mp3Url = "https://drive.google.com/uc?id=1B8bXoVj4RKyEVMKWbOJwgo-qlMcla6cf"
      , title = "山のロザリア(やまのむすめろざりあいつもひとりうたうよ)"
      , filename = "yamanorosalia.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1OMF0rz5jRqUbVaL9BYzNIzRaef2o-dKq"
      , mp3Url = "https://drive.google.com/uc?id=1QbbfQG25edePvuzzDHrJERiZcFA9FBBV"
      , title = "好きになったひと(さようならさようならげんきでいてね)"
      , filename = "sukininattahito.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1WkHQems7RXMcN5LdRAfqgyzJ9yQDMFUs"
      , mp3Url = "https://drive.google.com/uc?id=1NAdFW_xN7yIiVbJwzFO_bBAsz5K4g8b5"
      , title = "明治チョコレート(ちょっこれーとちょっこれーとちょこれーとはめいじ)"
      , filename = "meijichocolate.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Zuzerf-roX1yARGVTZafgnHMc1tDMBZ1"
      , mp3Url = "https://drive.google.com/uc?id=1j0IeIu-nDKDqGhkDto3fhhfMytB-edBd"
      , title = "この木なんの木(日立。このきなんのききになるきなまえもしらないきですから)"
      , filename = "hitachikonokinannoki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1p4oUKju2keeua6UAgWG6hjhZgR9KS6NF"
      , mp3Url = "https://drive.google.com/uc?id=1tC4KDvRYFTuWVdWTRr0j9bJfPnACA927"
      , title = "武田薬品(たけだたけだたけだたけだたけだ)"
      , filename = "takedayakuhin.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1AXyLHnKZLj0Oiy5MToc2bjUWfwXnl1LR"
      , mp3Url = "https://drive.google.com/uc?id=1txDEp-P6yt3ylS62d-HkQ67drVEeU4dr"
      , title = "ファミリーマート(あなたとこんびにふぁみりーまーと)"
      , filename = "familymart.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1VYBO6zDMVvwvuhRzlGBd-O6HV36f-fdh"
      , mp3Url = "https://drive.google.com/uc?id=1PBW3AakfTL7TG4x-DCQsDMoT_BtVnluN"
      , title = "セブン・イレブン(せぶんいれぶんいいきぶん)"
      , filename = "seveneleven.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=18G4bG19G59G_W0H5IeZC8Yvpumemgro3"
      , mp3Url = "https://drive.google.com/uc?id=1bwnpYzVo41-aab3D0D_hsaugVLfHVndJ"
      , title = "お正月を写そう(フジカラー。おしょうがつをうつそう)"
      , filename = "fujicolor.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Hos1fcqtW3MuYdg47yuuebWuWjqt0yzH"
      , mp3Url = "https://drive.google.com/uc?id=1z8enMQJR4TeQcE09iixTaYiDcvqkcOwj"
      , title = "サッポロ一番(さっぽろいちばんしおらーめん)"
      , filename = "sapporoichiban.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1waOQMmLj4AxgIybxWePC5IgrLnFM7u4G"
      , mp3Url = "https://drive.google.com/uc?id=1_gnWqobd9JSidPJWqd2VNMZUCCdWAxeP"
      , title = "山寺の和尚さん(やまでらのおしょうさんがまりはけりたしまりはなし)"
      , filename = "yamaderanooshosan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1NgBI3ipFIdkJdb6DQGkQB85Flsuvi4ty"
      , mp3Url = "https://drive.google.com/uc?id=1KLGWsVi-apx-_lHd_Kf9uopgtfGFqCYd"
      , title = "文明堂(天国と地獄。かすてらいちばんでんわはにばん)"
      , filename = "bunmeido.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1bBpdaZ8QZr4t6ntMmJJNBgvgrDMxBtoM"
      , mp3Url = "https://drive.google.com/uc?id=1X8UOtrBxI0-TdxIbUBLT0y_7Pt16m3-A"
      , title = "新日本ハウス(すみなれたわがやにはなのかおりをそえて)"
      , filename = "shinnihonhouse.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1J9ZscFQXgwWVz6p3fiZKxHUD_wap7Vz8"
      , mp3Url = "https://drive.google.com/uc?id=1qJMqKg_PpswCjmYS-JN-SzM-bSnBvEuR"
      , title = "呼び込みくん(スーパーでよく聞く曲)"
      , filename = "yobikomikun.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1AOvM4oLZfSfXhLKOPhFWhFZJZOxLtMZ-"
      , mp3Url = "https://drive.google.com/uc?id=1f57eBYLrZvJOu2xrkLwgHk2Z563gdP2Z"
      , title = "ノーベルのどあめ(なめたらあかんなめたらあかんじんせいなめずに)"
      , filename = "nobelnodoame.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1aW14ta_VZ7kZw7oUrFfiOof0q5PJPgld"
      , mp3Url = "https://drive.google.com/uc?id=1astV97WAe0PbD1GYFGdTUsUNRqNde_CJ"
      , title = "サントリーオールド(ざらんらんりらんじゅびだでぃーがおーでぃええーおー)"
      , filename = "suntoryold.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qIjfzc3afuM3Y-9LG31G1_hol9fQioFq"
      , mp3Url = "https://drive.google.com/uc?id=1QK7igIjNGoQ1pdcF9CIE6t1HZZqDYcoh"
      , title = "若き血(慶応大学応援歌。わかきちにもゆるものこうきみてるわれら)"
      , filename = "wakakichi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=12M2t70GgfRTF6JxdAufntREyuwyPJM9N"
      , mp3Url = "https://drive.google.com/uc?id=1wqZUH5Y4hUsz_jvC5FLBNNmFbobtsSSM"
      , title = "都の西北(早稲田大学校歌。みやこのせいほくわせだのもりにそびゆるいらかは)"
      , filename = "miyakonoseihoku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Yrwb5n5Q5iJjsm1c-noAX_eZtFUFQUuh"
      , mp3Url = "https://drive.google.com/uc?id=1OfwLDeH979lFY4qkoM4lLYh63leP4tnb"
      , title = "中国地方の子守歌(ねんねこさっしゃりませねたこのかわいさ)"
      , filename = "nennekosassharimase.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1L9YBj8Wi-bWwo4G2efYqcMMG02bjB3qf"
      , mp3Url = "https://drive.google.com/uc?id=1529iDwwme_MjzKjpuF7pvYFSdpJGGLhe"
      , title = "風(ひとはだれもただひとりたびにでてひとはだれもふるさとをふりかえる)"
      , filename = "kazehitowadaremo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1QS9cj4-K63TnkPA7uxXlvrWaKzStRrm8"
      , mp3Url = "https://drive.google.com/uc?id=1pYUJQl28GhjTws_Q6x2OcjQUbWH9snXI"
      , title = "夜明けのうた(よあけのうたよわたしのこころのきのうのかなしみを)"
      , filename = "yoakenouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1sSVINT3VuWszWpCjjnaHNF1at9vAh_f1"
      , mp3Url = "https://drive.google.com/uc?id=1G1bHc6cOsL8MpjaO30q7HFaJLUKDiJDM"
      , title = "お嫁においで(もしもこのふねできみのしあわせみつけたらすぐにかえるから)"
      , filename = "oyomenioide.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Cbv2wlcX9E5VncaOskaoao4xiv3QBz-m"
      , mp3Url = "https://drive.google.com/uc?id=1VZid1yCbG4mjLfpArADQfLi31oICW6Ne"
      , title = "花嫁(はなよめはよぎしゃにのってとついでゆくの)"
      , filename = "hanayomewayogisha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=15iw6Kc2StXcsPiXX7sQkZx6G9OCgK2cy"
      , mp3Url = "https://drive.google.com/uc?id=1xabfgRmjGkfdTjkfajzL41-GEVCrU-gs"
      , title = "世界は二人のために(あいあなたとふたりはなあなたとふたり)"
      , filename = "sekaiwafutarinotameni.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ROF-KKJFPHkAdwA8aXqnXxrU7wB9NPtd"
      , mp3Url = "https://drive.google.com/uc?id=1IxLpcjewm3H3y59gn-pSnfZ6ZWRomKrY"
      , title = "あの素晴らしい愛をもう一度(いのちかけてとちかったひから)"
      , filename = "anosubarashiiai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1cPCMiFi6abOyjBiBBP1-XKth9VUNstDI"
      , mp3Url = "https://drive.google.com/uc?id=19vGxrCgsGjS7dptdGlicZdJsOUn1BlDc"
      , title = "白いブランコ(きみはおぼえているかしらあのしろいぶらんこ)"
      , filename = "shiroiburanko.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1JvLLZHmijsRemlDpyQYKHB3a03LUTToi"
      , mp3Url = "https://drive.google.com/uc?id=1WDmwy6oN6BBKCu0-8fjPEg7qi7mJqWCD"
      , title = "誰もいない海(いまはもうあきだれもいないうみ)"
      , filename = "daremoinaiumi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-uLCTFeps04I36K_i0YhKyCQqWWBw7nR"
      , mp3Url = "https://drive.google.com/uc?id=1U5yK5tV4MvuAQt5dBDrls52MmMdmtL4Q"
      , title = "今日の日はさようなら(いつまでもたえることなくともだちでいよう)"
      , filename = "kyonohiwasayonara.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=17gajYXsa7Sr_usEEoJ5YSwJt7-ZHP2st"
      , mp3Url = "https://drive.google.com/uc?id=1LSQRBZJ5PZ2bMX2Ni3KcB7_ufRKNeniK"
      , title = "ロンドンデリーの歌(オーダニーボーイ)"
      , filename = "londonderryair.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1eaR7Vq36bXlAlm1muX16EkBCHGmo7WWU"
      , mp3Url = "https://drive.google.com/uc?id=1YyaEQo22p5H_PAeKGzvD2IZVuQSwq9_W"
      , title = "イヨマンテの夜(熊祭りの夜。いよまんてもえろかがりびああまんげつよ)"
      , filename = "iyomante.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1lHrzbxyLwCgzNNvqQZEw7Ff0TaLSET2d"
      , mp3Url = "https://drive.google.com/uc?id=1JK2Eu02HGj5VReW4KO3aARhSYu2wyzO-"
      , title = "さらばナポリ(Addio a Napoli わかれのときよいざいざさらば)"
      , filename = "sarabanapoli.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1B5SUF50EQOVKXFT-H-6037JklfF2-fU_"
      , mp3Url = "https://drive.google.com/uc?id=1XNrd_2cKZWoo5Umyz3crHUfj_5W2VgMU"
      , title = "フニクリフニクラ(あかいひをふくあのやまへのぼろうのぼろう)"
      , filename = "funiculifunicula.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1r0YQIUQQdwrWlU-4TatWrDEeTAJ6k8Yv"
      , mp3Url = "https://drive.google.com/uc?id=1Kqs1lg2EvYyUK5TcKA30ziyFLlR2JbtL"
      , title = "インターナショナル(たてうえたるものよいまぞひはちかし)"
      , filename = "international.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1fFVGr5oLZV_UVSmRvdJgqri9WrlpF4uE"
      , mp3Url = "https://drive.google.com/uc?id=1y28eQXnLDf6PPvSO1VnSNaB0RXsv5yBV"
      , title = "海行かば(うみゆかばみづくかばねやまゆかばくさむすかばね)"
      , filename = "umiyukaba.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1np5Q3TKAzEJxT1hXpi2xPpcxzocioKH7"
      , mp3Url = "https://drive.google.com/uc?id=1JPbmkcvns7zXoy5yy8IBdcFsYYUROMWl"
      , title = "乙女の願い(ショパン)"
      , filename = "otomechopin.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jO51Xr3SoOc8zzEeQ-Y4yBrBDtfTOuq7"
      , mp3Url = "https://drive.google.com/uc?id=1TgZYGgqyg3SbVB-v2iSoLdoaZxIQwLbu"
      , title = "秋の夜半(ウェーバー。あきのよわのみそらすみて)"
      , filename = "akinoyowa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ryydE7wmUYzV1H7OFevrp6shVi-cTc6W"
      , mp3Url = "https://drive.google.com/uc?id=1QEKVcwGT-aztsv32Lmr6NbeV3mv0AIBr"
      , title = "柳ケ瀬ブルース(あめのふるよるはこころもぬれるましてひとりじゃなおさみし)"
      , filename = "yanagaseblues.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1un172Ji39mpXakoUbgGa8KBGS9ISG4ZN"
      , mp3Url = "https://drive.google.com/uc?id=1HLFkzn0x7TG2Wvf3Edtj2ewC2V71o2ZK"
      , title = "アカシアの雨が止む時(あかしあのあめにうたれてこのまましんでしまいたい)"
      , filename = "acacianoame.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1D3EVIidwoOXwwd3Ib9TIAlGBRaTbB4bA"
      , mp3Url = "https://drive.google.com/uc?id=1oFqwmRg3ti5YjttCp_W_IegkcncphkHs"
      , title = "アイルランドの子守歌(トゥラルーラルラー)"
      , filename = "irishlullaby.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10CjRrcs_tK7gGMlnrAI_st134LjFDWWo"
      , mp3Url = "https://drive.google.com/uc?id=1Bey9iq999smFh7FR8yyWC_Lmm45TH63z"
      , title = "愛の讃歌(あなたのもえるてであたしをだきしめてただふたりだけで)"
      , filename = "ainosanka.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1y7jFUqsUTHRcQNdyY3VoIFKU05osi8jH"
      , mp3Url = "https://drive.google.com/uc?id=107AGR5Jh0bIdvp3KsbqyUwl3PgbRVA9v"
      , title = "黒ねこのタンゴ(きみはかわいいぼくのくろねこあかいりぼんがよくにあうよ)"
      , filename = "kuronekonotango.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1uymt124kVmwH9USl1FQMs5El_ZpVQA6H"
      , mp3Url = "https://drive.google.com/uc?id=1lBUsJvIESVPmVJHVrjSrggjEWmSeAK4h"
      , title = "すうじのうた(すうじのいちはなあにこうばのえんとつ)"
      , filename = "sujinouta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1-gSSylgqrGNds7SBgGbghwUTMuXxSrau"
      , mp3Url = "https://drive.google.com/uc?id=13p1Ou717Y8IMk9l1cIN3xWca2blLTx7X"
      , title = "コーヒールンバ(むかしあらぶのえらいおぼうさんがこいをわすれたあわれなおとこに)"
      , filename = "moliendocafe.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1cC9K1o2dKejNjglwaWzuR0hqtCW6y-QC"
      , mp3Url = "https://drive.google.com/uc?id=1_-jM0-IX_FBYY5eDhHeFghLF1j82ImHr"
      , title = "暗路(やみじ。おぐらきよわをひとりゆけばくもよりしばしつくはもれて)"
      , filename = "yamiji.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xEiSYgUoyshoByt5EeKanQx5MFz2PtfW"
      , mp3Url = "https://drive.google.com/uc?id=1JpzKHUhLn3A-1qyvTXkqDtKJ9tE7B_ab"
      , title = "たゆとう小舟(たゆとうおぶねにみちからたよりてなみのえうらうら)"
      , filename = "tayutouobune.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Ypda2vkWpyxypcp9LCHq793D5sEmXIKt"
      , mp3Url = "https://drive.google.com/uc?id=1VFJ23Fs--xRDr2QFzZO3fQAm8tUjQBx8"
      , title = "バイカル湖のほとり(ゆたかなるざばいかるのはてしなきのやまを)"
      , filename = "baikal.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=19ggxypl3wxYDJ8WqLrJ0Qar_UkZsuOED"
      , mp3Url = "https://drive.google.com/uc?id=18Sg6sJW0FGknraAgWs6Kww6GBPIGW3at"
      , title = "黒い瞳の(くろいひとみのわかものがわたしのこころをとりこにした)"
      , filename = "kuroihitomino.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11ozB77q4b_QQ3BM_ei4K19O8261poK19"
      , mp3Url = "https://drive.google.com/uc?id=1opNIueNZUu6pOfLMkFxJilCCauGhwD7Z"
      , title = "モスクワ郊外の夕べ(ざわめきもいまははなくものみなまどろむ)"
      , filename = "moskvakogai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1k2cTLrgKBy6TIlyhaNlr4zhL_t9k0tvK"
      , mp3Url = "https://drive.google.com/uc?id=1RzlU_1s6EZ5T74IWD-gAMK1aqP-Mn7T5"
      , title = "バルカンの星の下に(くろきひとみいずこわがふるさといずこ)"
      , filename = "balkannohoshinomotoni.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1xweATaymqblsKlPjIh6mUUaoHfL5PUuF"
      , mp3Url = "https://drive.google.com/uc?id=1x9scIH4CD1bBlilUBmNR9-_wt_PNbD2h"
      , title = "禁じられた遊び(愛のロマンス)"
      , filename = "kinjiraretaasobi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jEI7POa16b3ydWpEakR7-q4JFKA9g7Ok"
      , mp3Url = "https://drive.google.com/uc?id=1bntUwHc5vNiCLg6Nnrorx5agr6UvGD6l"
      , title = "追憶(ほしかげやさしくまたたくみそらをあおぎてさまよい)"
      , filename = "tsuioku.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1eGk4xSKbPRN8GYl-rTKOyxa53j-ZCfWq"
      , mp3Url = "https://drive.google.com/uc?id=1CJuDUT0tiUbuZ5_z0p1eBiv2YG7Ttfn7"
      , title = "おお牧場はみどり(おおまきばはみどりくさのうみかぜがふく)"
      , filename = "omakibawamidori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=184Hoc1OgrIO44Cz6An2U2HFXkYaMTNRh"
      , mp3Url = "https://drive.google.com/uc?id=1ReZJImrbxUVLkbxoGy8VBh9D72xozu6y"
      , title = "ラ・パロマ(らぱろま。わがふねはばなたつときさびしきなみだあふれぬ)"
      , filename = "lapaloma.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1X1XjjmLlpDcIa9j-P_I38rjh4wqgTNBQ"
      , mp3Url = "https://drive.google.com/uc?id=12vSdRkkzlXCfvLhAxBYNe4RyPcpDIJ-a"
      , title = "海に来たれ(めざめとくこよつきはなみまにかがやく)"
      , filename = "uminikitare.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1HvGV8mo7qmtKNVMFeA2Ud0P5sx7PuU50"
      , mp3Url = "https://drive.google.com/uc?id=1zBrkFVq8NnHS2ledadcq1-pENxWCK0Ps"
      , title = "オー・ソレ・ミオ(おーそれみお。ひるのひのかがやくようなはれたひとみ)"
      , filename = "osolemio.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14zyiUvygJTx5ZzKJgnfzS0XD5VCYeB1L"
      , mp3Url = "https://drive.google.com/uc?id=16yUaGudJl2QfGk-d1NsemK-Y_36EN0AJ"
      , title = "麦打ち歌(サデロ。ちょいとねえさんどこへいくわたしゃゆうげのみずくみに)"
      , filename = "mugiuchiuta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1gARrAI75p3aEp6PM-u8dQUkmJWHMw0DM"
      , mp3Url = "https://drive.google.com/uc?id=13O4t_vUFE_UqsjGqpwRv0hwaDBExnwed"
      , title = "村の娘(あけゆくやまやまをこがねいろにそめ)"
      , filename = "muranomusume.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1luseppApOTAGqf2HHC8xiTH88An8Z0vn"
      , mp3Url = "https://drive.google.com/uc?id=1Rcpj3Rd_JUB6OjbV2XjzM0_PSM5XvGQT"
      , title = "山の人気者(やまのにんきものそれはみるくやあさからよるまでうたをふりまく)"
      , filename = "yamanoninkimono.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=19OQCufvHJCm6OYA4x4LnwIDktuzrENEG"
      , mp3Url = "https://drive.google.com/uc?id=1xrnmD2nwFjW3vILTkJFHja4blDakguFp"
      , title = "気のいいあひる(むかしあひるはからだがおおきくてうみもわたればさかなもたべたよ)"
      , filename = "kinoiiahiru.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dVcMPoEwN_m0rb-AtrX-ry1vTUqjsz0V"
      , mp3Url = "https://drive.google.com/uc?id=1UcoxjT_owQ5L8u4WGomlxdJAJgV3xWKR"
      , title = "花まつり(ぬるんだみずにはるのひはうかびこぶねははなたばをつんではしる)"
      , filename = "hanamatsuri.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ReBCpLmqYZnBfac_eg8gz3Aj4VGFjl-k"
      , mp3Url = "https://drive.google.com/uc?id=1rQyBnbFhyL8MTjMFG2nQ1PAgUWVKjZoO"
      , title = "ラ・クカラチャ(らくからちゃ。ラクカラーチャ。くるまにゆられて)"
      , filename = "lacucaracha.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=15HRF6sciCl2kdSNlX2NdE5UEYMGJU-IO"
      , mp3Url = "https://drive.google.com/uc?id=1NCf4KCdpCJ0Nl3aLau2VsYn-aZcLrhel"
      , title = "シェリト・リンド(しえりとりんど。うつくしいそら)"
      , filename = "cielitolindo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1d48lkwTqNfNRsNmq8vw7ca4yj6EhBj8u"
      , mp3Url = "https://drive.google.com/uc?id=1UaWWSrw-9Jxk0anw0uVAGZ0hlwU9uwID"
      , title = "アイ・アイ・アイ(あいあいあい。ちりゆくはなにayayay)"
      , filename = "ayayay.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1nLA27hZWWiUL4Va9MyYAxGNq8yF_EhuS"
      , mp3Url = "https://drive.google.com/uc?id=15fpfNmEnWYIoaWghwWN6pcrc3GmyGh6t"
      , title = "樅の木(たんねんばうむ。もみのきもみのきおいやしげれる)"
      , filename = "mominoki.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1wCDk7d-VadedV5pXzKRbmmECI3VOQBpd"
      , mp3Url = "https://drive.google.com/uc?id=1h5RpWEOKkKiVHpnQ03dYPvHHP7yJHbcO"
      , title = "グノーのアヴェ・マリア(クリスマス。あべまりあ。Gounod Ave Maria)"
      , filename = "gounodavemaria.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1WxXMG8WlKQdc7Gk0YJJxMWC_90AfndZF"
      , mp3Url = "https://drive.google.com/uc?id=1mXEhJfvEPSTQvHiWQra9EfF-vZJa9lFk"
      , title = "神の御子は(クリスマス。かみのみこはこよいしもべつれへむに)"
      , filename = "kaminomikowa.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1nJ8_c1YiwPtOjdZaLtkNSAYGvCBdr6hC"
      , mp3Url = "https://drive.google.com/uc?id=1lcrBwq9xN1uR78PfSakTYbI-QiD1gM5k"
      , title = "TOMORROW(トゥモロー。なみだのかずだけつよくなれるよ)"
      , filename = "tomorrow.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14E4R0Xv43MMma3OAESiSxeSQU4OAz5mC"
      , mp3Url = "https://drive.google.com/uc?id=1IAg6JgGIUcmuT2S2uMC4dHCnAT1YPdfE"
      , title = "千の風になって(わたしのおはかのまえでなかないでください)"
      , filename = "sennokazeninatte.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1rpfywnMzfqdgDMGo1m3rE5tWRjS7gaGQ"
      , mp3Url = "https://drive.google.com/uc?id=1xCXb_kjKZkJqv_ZjmoDBy4SrWN3pq3R8"
      , title = "崖の上のポニョ(ぽーにょぽにょぽにょぽにょさかなのこ)"
      , filename = "gakenouenoponyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1s_6lVTr0d078pdd1uuEMnY4U8M2RWpsJ"
      , mp3Url = "https://drive.google.com/uc?id=1zXMl3xW8aUp6FP2CFrkcpnPpTenhwlLV"
      , title = "赤いサラファン(あかいさらふぁんぬうてみても)"
      , filename = "akaisarafan.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1c1bbnWvAru3z2ydq0Dt_TDgyOSjrCwIV"
      , mp3Url = "https://drive.google.com/uc?id=18ZMNM5Z9LuPCj6RTeYXHFMGlhRh7Xv1B"
      , title = "ドナウ川の漣(どなうがわのさざなみ)"
      , filename = "donaugawanosazanami.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1UwthoPXRuj-kUnEjMBzmAOeKiRCRBeXt"
      , mp3Url = "https://drive.google.com/uc?id=1uHIiwMQ1nZAPHPJlxSjn901VoSKgru05"
      , title = "ヴォルガの舟歌(ゔぉるがのふなうた。ええこーらええこーらもひとつええこーら)"
      , filename = "volganofunauta.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=14JiPlH7lX3x8HPowqJZm6l4f3OHIDBhd"
      , mp3Url = "https://drive.google.com/uc?id=163ycpP68MDt1VzCXQG-97WIIaiOkppoW"
      , title = "眠りの精(つきのひかりにはなもくさも)"
      , filename = "nemurinosei.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1OrJZlzsqoPs_Z6xveREmnLL6YssEeWjm"
      , mp3Url = "https://drive.google.com/uc?id=1Vj3e3DDaFzg7VLq2RLvJG0EMAO0WnV1L"
      , title = "ジョスランの子守歌(Berceuse de Jocelyn)"
      , filename = "berceusedejocelyn.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1lwl76rTbOA6bd6W-MRKbwXVisO0pZ10Y"
      , mp3Url = "https://drive.google.com/uc?id=1UzbHPakxBC4tc_fMHV15G3SgAEWEfqs2"
      , title = "コサックの子守歌(ねむれやこさっくのいとしごよ)"
      , filename = "cossackkomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1_MqhIKDXzsuZtvZdeRUDgWEZwHTErig_"
      , mp3Url = "https://drive.google.com/uc?id=11nwMXklcRnogtuRFHKrTNedehJCr-IN8"
      , title = "チロルの子守歌(すずのひびことおくやまのまきばくれて)"
      , filename = "tirolkomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1aBHl8GZWvIRVEFqoz7y0CcxaS8SqfQxk"
      , mp3Url = "https://drive.google.com/uc?id=1K6vWruAS6OYCDe3hiOL3WskzW5bgHaR6"
      , title = "五木の子守歌(おどまぼんぎりぼんぎりぼんからさきゃおらんど)"
      , filename = "itsukinokomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DrcaHPsvdzv3sg6JV_u5kynxpQMk17TL"
      , mp3Url = "https://drive.google.com/uc?id=1BpX3ylp5haqA42uGMEPzeIQAi-qB12j2"
      , title = "島原の子守歌(おどみゃしまばらのおどみゃしまばらのなしのきそだちよ)"
      , filename = "shimabarakomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1hgrEoRWFgHgrytifY1rmE5x5VgpIe_oD"
      , mp3Url = "https://drive.google.com/uc?id=125_MzEaLP4_3dXA77cKDBBHGgsJapAuV"
      , title = "春の日の花と輝く(はるのひのはなとかがやく)"
      , filename = "harunohino.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MSvGy3vXEOHGwZM-Wr_l5SoSJ8XKpRcg"
      , mp3Url = "https://drive.google.com/uc?id=1Q4Q9HHspm94seD4WFvd1XLlrVkrfnYcu"
      , title = "ロッホ・ローモンド(スコットランドの湖)"
      , filename = "lochlomond.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Jt-kfPLASlxVxQmwli_proW2xz9ra0LZ"
      , mp3Url = "https://drive.google.com/uc?id=1yuj6KsFvi8NkBuCfUvKZ--ZMgWM5XGqx"
      , title = "アニー・ローリー(あにーろーりー。あしたつゆおくののしじまに)"
      , filename = "annielaurie.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=19CFWPW4qs4htw1cobHtzko0V_3Gpqgpz"
      , mp3Url = "https://drive.google.com/uc?id=1MNqWREfWjGUl-q_xnTPWs_Er9snK2pw8"
      , title = "グリーン・スリーブス(ぐりーんすりーぶす。Greensleeves)"
      , filename = "greensleeves.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1lmKrFM_XnobJrdLlYZTZxNGh2RnWZZF2"
      , mp3Url = "https://drive.google.com/uc?id=1ZEhTjL8HBiD08-QB_WgnriUXMG5SkRMZ"
      , title = "ピクニック(おかをこえゆこうよくちぶえふきつつ)"
      , filename = "picnic.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1WQBubeu0cjGmYapSzlX0GBu-riFTrzhZ"
      , mp3Url = "https://drive.google.com/uc?id=1glTZnJqW_Pfsh64Q826oCyUkURe_Rr9C"
      , title = "アフトン川の流れ(Flow Gently, Sweet Afton)"
      , filename = "afton.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1HyGn9dsLSzQ4-ntLVvcynMuY1UZsIyRm"
      , mp3Url = "https://drive.google.com/uc?id=1oPcFIFx6zRYEp_3_ByslA9jr8NG7VRvS"
      , title = "山の一日(あかるくたのしいやまのいちにちあさひといっしょにあるきだし)"
      , filename = "yamanoichinichi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1So_JF5Du1zoYDi7yXGY1GHJDIufRx7ow"
      , mp3Url = "https://drive.google.com/uc?id=1B5Yh0RqjooTSz8i--p1Nn1Z45KtL3-Yf"
      , title = "おおブレネリ(おおぶれねりあなたのおうちはどこわたしのおうちはすいっつらんどよ)"
      , filename = "ohvreneli.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1vI2vbrxffvCoDepHs_8tKXH4rcqVFhoH"
      , mp3Url = "https://drive.google.com/uc?id=1q6XDcc1HjJDsyNqb0myPqxb3A7IZxkKL"
      , title = "いつかある日(いつかあるひやまでしんだらふるいやまのともよつたえてくれ)"
      , filename = "itsukaaruhi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1KY-Qi1R32bwlURxNTvE7_-DTktTTQRZB"
      , mp3Url = "https://drive.google.com/uc?id=1u-JzLd2cTRw4XKgbEO_ZTlcknwRA2wlA"
      , title = "森へ行きましょう(もりへゆきましょうむすめさんあはは)"
      , filename = "morieyukimasho.ly"
    }
    , { jpgUrl = "https://drive.google.com/uc?id=1IWOW200LXTT-WyRIqlT3XPO58WwvUZhw"
      , mp3Url = "https://drive.google.com/uc?id=1f_onz6tyBFzMnd_3qsEZB2Y4PKURSPGZ"
      , title = "この広い野原いっぱい(このひろいのはらいっぱいさくはなをひとつのこらず)"
      , filename = "konohiroinoharaippai.ly"
    }
      , { jpgUrl = "https://drive.google.com/uc?id=1oNXyV3LKHyWRbWP27LetScaOwDZ28ele"
        , mp3Url = "https://drive.google.com/uc?id=1VBrJl-goRUiC8q0zvVNOVLxpo1981Xm2"
        , title = "やさしき愛の歌(モロイ。Love's Old Sweet Song)"
        , filename = "yasashikiainouta.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1Cfh91cGp6sMQy3FQSZ_hzm57__a7rlrj"
        , mp3Url = "https://drive.google.com/uc?id=1UlR4THwWKheJOI_tMMsFDZPKhyMQvJ2_"
        , title = "峠のわが家(Home on the Range つのぶえはこだまするやまのおかなたに)"
        , filename = "togenowagaya.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1bDAXPwrsyv6uTZaqUhGOOU0bprjyhbao"
        , mp3Url = "https://drive.google.com/uc?id=1XwWiKdPQMvWXAJFouJQ4N1YkiXk2YOhG"
        , title = "家路(Going home。とおきやまにひはおちてほしはそらをちりばめぬ)"
        , filename = "goinghome.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1iSN_nhD59jSV1fDss-g_MlqmvmBj0wPf"
        , mp3Url = "https://drive.google.com/uc?id=1huDMk_Jv3FmoayuXSuPXhih_l-L1abY8"
        , title = "漕げよマイケル(Michael Row the Boat Ashore Hallelujah)"
        , filename = "michaelrow.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1IcbwZXmPk28RA6FXKL4BysVx7CFNk--l"
        , mp3Url = "https://drive.google.com/uc?id=1Kyy3zreFL79O08ioCaf1H6na0K7siYrA"
        , title = "わが悩み知り給う(Nobody Know de Trouble I See。わがなやみしりたもう)"
        , filename = "waganayami.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1ZGJs2WxykkMeSjbrEGvhbx7A7ZrQ4MPt"
        , mp3Url = "https://drive.google.com/uc?id=1fxrhFFNwF_aM7J_nldVb8sbHDx8fLvGE"
        , title = "藁の中の七面鳥(わらのなかのしちめんちょう。さあたいへんださあたいへんだ)"
        , filename = "turkeyinthestraw.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1iKgsb66xBwDl8p9JQFh-U2IM3IC6HQ81"
        , mp3Url = "https://drive.google.com/uc?id=1n7RlzZtlg79GUMKhF01NnLALncOL2cJJ"
        , title = "アロハ・オエ(あろはおえ。やさしくかなずるはゆかしうくれれよ)"
        , filename = "alohaoe.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1kLUxtpX1uOwGcikToMVKctp9Rp07HU7r"
        , mp3Url = "https://drive.google.com/uc?id=1uccvX6G8UJ8XYWZ2uGYMVNW2jCgSz8Pm"
        , title = "ステンカ・ラージン(すてんからーじん。くおんにとどろくゔぉるがのながれ)"
        , filename = "stenkarazin.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1azkvO16mykHktNaGONsSScCDbbm39akU"
        , mp3Url = "https://drive.google.com/uc?id=1BOQn85juVF9IKNv_HfYE-N4KhGfJdgQM"
        , title = "ブンガワン・ソロ(ぶんがわんそろはてしなききよきながれに)"
        , filename = "bengawnasolo.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=17Tdaj04ab5uGT4sf15yaYh0ILPFqPqWn"
        , mp3Url = "https://drive.google.com/uc?id=1Q-omJiecO1J5t5AQW92UJ4zepI9aN_7q"
        , title = "トラン・ブーラン(とらんぶーらんやしのはかげあかるくてりかがやき)"
        , filename = "terangbulan.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=15BZWyw62j3LwNMIgBj6Q4JKo-mXRz7bq"
        , mp3Url = "https://drive.google.com/uc?id=1t4xq5dGrOIMuQmC82mkLLpTUQ7ZTn4YZ"
        , title = "シューベルトのセレナーデ(Schubert Serenade(Staendchen))"
        , filename = "schubertseranade.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1vNCwtRoNS4_t1x7mjpE_RwGkA7EwTK_A"
        , mp3Url = "https://drive.google.com/uc?id=13edzce2LS0FWYNWWP1uGRhOQfjbFIdDc"
        , title = "別れの曲(ショパン。はるのひそよかざはなちるみどりのおか)"
        , filename = "chopinwakarenokyoku.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1WOZTy3KDhXRQPxElgo2uApt6zyd1UCYh"
        , mp3Url = "https://drive.google.com/uc?id=1iAPYygJQpmExOzQqUp9Agz1_lT958rEN"
        , title = "真実の愛(Treue Liebe。ドイツ民謡)"
        , filename = "treueliebe.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1uUSlCFOsbQ2j7maCqiBTzxBDKz7LS4TU"
        , mp3Url = "https://drive.google.com/uc?id=1Tm1XVHzz3U5ojdX2ZKVbSCxxRsRmQGAX"
        , title = "帰れソレントへ(うるわしのうみはうつつにもゆめむ)"
        , filename = "sorrento.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1FILDwAvJ_AItxqXXIxJ4uAhUephafkCh"
        , mp3Url = "https://drive.google.com/uc?id=1f578olVVBGbEbv6IGQ1XrvfkwwhxullT"
        , title = "マギー若き日の歌を(When you and I were young, Maggie)"
        , filename = "maggie.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1Sb8UEccL--D-HfpjlYPf0xaFzGbOl5LR"
        , mp3Url = "https://drive.google.com/uc?id=1OGX_brVDae0VkH9yZjm-Mur0E3H5VZnp"
        , title = "カロ・ミオ・ベン(Caro Mio Ben。ジョルダーニ)"
        , filename = "caromioben.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1dZSKtdEGwtMq044-Zc7axPXDl398f3Iy"
        , mp3Url = "https://drive.google.com/uc?id=1-p8GCqxvVNvzvgORdhvgY_8F6huwjsiw"
        , title = "マリア・マリ(カプア。まどをひらきてわがうたききてよ)"
        , filename = "mariamari.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1_QwyQyA0gYrMdTbDEqiukmAoPQ5cg17C"
        , mp3Url = "https://drive.google.com/uc?id=1IUfKEMKDtKc9mx-MoAd5pbEPSPxZHz0d"
        , title = "女心の歌(おんなごころのうた。ヴェルディ「リゴレット」より)"
        , filename = "onnagokoronouta.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=13FQOrbRDie0sEQlJZIV6dPprsGsznyl_"
        , mp3Url = "https://drive.google.com/uc?id=1l1Q6dbrbho2u7f6CbhHwZt1kgm0jWvjO"
        , title = "エレジー(マスネー「悲歌」)"
        , filename = "masenetelegie.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1jWPsJQF26wszI_hX7fK7QsgypmOVi6_8"
        , mp3Url = "https://drive.google.com/uc?id=1qfjShcHECLQkwOxYt1617KFV-UTCQw4Z"
        , title = "楽しき農夫(シューマン)"
        , filename = "schumantanoshikinofu.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1PtwETXAdtZtwEmkKEoP013lRPNhX5ijT"
        , mp3Url = "https://drive.google.com/uc?id=1iclF4WjcDQikMnSId2Do7iKI3TiJihF4"
        , title = "歌声ひびく(うるわしはるよみどりにはえてうたごえひびくのにやまに)"
        , filename = "utagoehibiku.ly"
      }
      , { jpgUrl = "https://drive.google.com/uc?id=1G5RVD315sVlJ4nYWwAlsk-UAWRK2GVmJ"
        , mp3Url = "https://drive.google.com/uc?id=1Cht48MpzossmjEZUfPPC3pG4Rgm8xdSA"
        , title = "希望のささやき(あまつみつかいのこえもかくやと)"
        , filename = "kibonosasayaki.ly"
      }
--, { jpgUrl = ""
--   , mp3Url = ""
--   , title = "ニーナ(Tre giorni son che Nina by Ciampi/Pergolesi。ふつかふれどもにーなはめざめず)"
--   , filename = "ninatregiorni.ly"
-- }
--, { jpgUrl = ""
--   , mp3Url = ""
--   , title = "シューベルトのアヴェ・マリア(クリスマス。あべまりあ)"
--   , filename = "schubertavemaria.ly"
-- }


    ]
-- ソルベーグの歌(グリーグ「ペールギュント」より)
