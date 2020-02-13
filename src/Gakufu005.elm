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
    , { jpgUrl = "https://drive.google.com/uc?id=1w1LhB8aOftp1A3zOmlSQGjMye7GsowJI"
      , mp3Url = "https://drive.google.com/uc?id=1jvYKa16U5WI-Yo1sWxKkVgFXlxRWWupv"
      , title = "もろびとこぞりて(クリスマス)"
      , filename = "morobito.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1uhrOl8NYnOogep1FKU6BvOu67rrM_WC4"
      , mp3Url = "https://drive.google.com/uc?id=1KH0cab55b9HdFkbuz7XnLZvyhm6qgvKd"
      , title = "テネシーワルツ"
      , filename = "tennessee.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1cs8EtDp7rspgab-wc2SRypaDA_BtrLsW"
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
    , { jpgUrl = "https://drive.google.com/uc?id=167ShNKUA5n2FmUB5k5IhMu02XRZvmuJY"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1zYnzkMg3wuTLmr7LjskscLGsO1EQou3l"
      , mp3Url = "https://drive.google.com/uc?id=1Zj84PnbjxCJ6stycApbUUpRVexGJKl_U"
      , title = "ます(シューベルト)"
      , filename = "masu.ly"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1VIRoFEuz4isusxWFeA7VzdVwNFbs25sV"
      , mp3Url = "https://drive.google.com/uc?id=1oFARTSCKkwL-DXduZ6C25IgH5bunpmeR"
      , title = "モーツァルトの子守歌"
      , filename = "mozartkomori.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1KabE7PO1-SUgXNgCP8GOL2xPaDXC8kPh"
      , mp3Url = "https://drive.google.com/uc?id=1xoFNN2tJ1cd-OXrbqIoWJuT2CnJdT9eP"
      , title = "ブラームスの子守歌"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1R-_oBgN-uo9Umt58dj_bDt98TJZuIi4I"
      , mp3Url = "https://drive.google.com/uc?id=1HkbtqUxqnNhFHY7rCznAyJHiC2jxvfjp"
      , title = "乾杯の歌(ヴェルディ)"
      , filename = "kanpai.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1u2eLbZdoFMFo6OT9R9k_sHXq5OoLXJTc"
      , mp3Url = "https://drive.google.com/uc?id=1qwtV9HR-AsPfNeM-jLgUs-1_rmGjtxlr"
      , title = "ラデツキー行進曲(ヨハン・シュトラウス1世)"
      , filename = "radetzky.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1tMfPasJu9scYLlyg7QE0wajJESRX0bXv"
      , mp3Url = "https://drive.google.com/uc?id=1GpNrRtmi-y9lzmGYTl36PkP2Oy-_1nXT"
      , title = "ずいずいずっころばし"
      , filename = "zuizui.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DW8gcnWRffG6ZE2adEEq7wF0Q-8INVWv"
      , mp3Url = "https://drive.google.com/uc?id=1BHOn481oLb5q-dC8iYRnqDr4gE-fhFJ1"
      , title = "燃えろよ燃えろよ"
      , filename = "moeroyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1lbz-a988jDc9GXe0SVgdOJnT0D4T-its"
      , mp3Url = "https://drive.google.com/uc?id=1GHAmUg3ZsKvC8O5mAip9wqeZAB9-d3G9"
      , title = "マイボニー(My Bonnie Lies Over the Ocean)"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1-n4psZwGJAq-Sxx58WwoRISq3quJALOL"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1JqZYLTvd1346IF69lemTFe1I6HCtHhcg"
      , mp3Url = "https://drive.google.com/uc?id=1NWEYaFtt2Imu-JxfwxwtO4bVamtJLJOc"
      , title = "愛の喜び(マルティーニ)"
      , filename = "ainoyorokobi.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1mH5GBbbKVGVN0hLOLzg-94ultqiN8a50"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1qpcJisVQ030gQ29Oh0kozDhj78P7ZYm4"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1J4V9tUKuVL6Q3y_a7hHL0CXldoyrv5q3"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1RtMAoXrtO4K09fjrzaKucixS-KzNVZ_k"
      , mp3Url = "https://drive.google.com/uc?id=17lUw9X8oWnMtrOV9iP_NcFOCjT2JEpzL"
      , title = "大きな古時計(おおきなのっぽのふるどけい)"
      , filename = "okinafurudokei.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qTEnCelZoycCd69i4OlKD_fZdXlVtBGP"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1w758ucrQ8iOGBNe58Su4I-thIUkbk5lr"
      , mp3Url = "https://drive.google.com/uc?id=1wQvReBXq6S9yNk0qGrTqSjsERIFraU1T"
      , title = "秋桜(うすべにのこすもすがあきのひの)"
      , filename = "cosmos.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1JYXpUnLFgTyht62TFMCq-JePJJEPSWCS"
      , mp3Url = "https://drive.google.com/uc?id=1XpVxzqAUwjglsqW_3s-_b1gn4LL_pPss"
      , title = "夜霧よ今夜もありがとう(しのびあうこいをつつむよぎりよ)"
      , filename = "yogiriyo.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1inlv7kc1MX-dbb8CruQOreyXcVzc5-9E"
      , mp3Url = "https://drive.google.com/uc?id=1ztUG1OikJ7JeqvHFf-UaVnNfMm07B7XQ"
      , title = "かっこう"
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
    , { jpgUrl = "https://drive.google.com/uc?id=18RwmTsJvYcsyfmNdLjrZbYaQQZ4DYuJ8"
      , mp3Url = "https://drive.google.com/uc?id=1jxeYCnXQ7CZMpEIrn_OJ-hm9dGtPiND9"
      , title = "小さな世界(ちいさなせかい、It's a small world、せかいじゅうどこだって)"
      , filename = "smallworld.ly"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1QRcYDpmk4Q5tF6K6RdeRef3AMOBQ_ynn"
      , mp3Url = "https://drive.google.com/uc?id=10uRPITMWRgop4qzQS_E5EHuc6Y7-GD0D"
      , title = "竹田の子もりうた(もりもいやがるぼんから)"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1eS-Wjq7M7YO0M6YnFHp_YLkFHtl_WkkE"
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
      , title = "たなばたさま"
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
      , title = "アルプス一万尺"
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
      , title = "通りゃんせ"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1Cvhc7m2Nk246-YQaRpFOgQYLf-CyTnDC"
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
      , title = "うつくしき(うつくしきわがこやいずこ)"
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
    , { jpgUrl = "https://drive.google.com/uc?id=1wuYPF84MpyFmL5Mrd5DMbjPu8k6qma4s"
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
          , title = "箱根八里(はこねんのやまはてんかのけんかんこうかんもものならず)"
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
-- , { jpgUrl = ""
--   , mp3Url = ""
--   , title = "紅屋の娘(べにやのむすめのいうことにゃさのいうことにゃ)"
--   , filename = "beniyanomusume.ly"
--   }



    ]
-- , { jpgUrl = ""
--   , mp3Url = ""
--   , title = ""
--   , filename = ".ly"
--   }

