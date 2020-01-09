module Gakufu002 exposing (main)

-- Gakufu001で、pdfを表示、mp3を鳴らすのができた。
-- randomボタンとplay controlをつける。
-- 数曲のファイルにする。

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Random



-- main : Program () Model Msg


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
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { jpgUrl = "https://drive.google.com/uc?id=1yYAaH3a9SZ2FdkRWXIeCqc6G3u9_awL2"
      , mp3Url = "https://drive.google.com/uc?id=10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY"
      , title = "湯の町エレジー"
      , filename = ""
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
            case List.drop (n - 1) dict of
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
            [ HA.src model.jpgUrl
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
                    [ HA.src model.mp3Url
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



-- https://drive.google.com/open?id=1ZzawaIrOD2BXREfQhCO2rMjOE400FdNV
-- https://drive.google.com/open?id=11HlPI27tt8UU5N5dR8O-xC_EPiTR4O5j


dict : List Model
dict =
    [ { jpgUrl = "https://drive.google.com/uc?id=1UZyUrTOKp0dQFRZpMOtBoC-5SOkRWjLN"
      , mp3Url = "https://drive.google.com/uc?id=1kdzpk4PUE7DmWo_CPmJw5NlcYZetNILL"
      , title = "クリスマス・イブ(きっとあなたはこない、山下達郎)"
      , filename = "christmaseve_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1IRp2uhDtP0y3-Vi8mQ3lD2H1goca5FIG"
      , mp3Url = "https://drive.google.com/uc?id=1877DcOpz7rhRQ7XhpV7I34MQf018IDYt"
      , title = "水戸黄門(じんせいらくありゃくもあるさ)"
      , filename = "mitokomon_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1yYAaH3a9SZ2FdkRWXIeCqc6G3u9_awL2"
      , mp3Url = "https://drive.google.com/uc?id=10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY"
      , title = "湯の町エレジー(いずのやまやまつきあわく)"
      , filename = "yunomachieleby_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1aDQQwqhKEd7Pp119WgththIX5xCReZJA"
      , mp3Url = "https://drive.google.com/uc?id=1EYX9vEimFxmheBcfSW6yYeKeWn3wr7tF"
      , title = "別れ船(なごりつきないはてしない)"
      , filename = "wakarebune_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1EVnM-OK2qhU9_dfhzo1duk-pkFc7xq4U"
      , mp3Url = "https://drive.google.com/uc?id=1ukG2ddTIjNxixk3wFcxuHa6LoaERkOZ9"
      , title = "水色のワルツ(きみにあううれしさの)"
      , filename = "mizuironowaltz_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13qvBdUW2hUmj8K8YQq3NYGplrIQEz1-8"
      , mp3Url = "https://drive.google.com/uc?id=1HpWU1ALfTSgFY-j6L6q5UbK2fU7Lqs0v"
      , title = "村の鍛冶屋(しばしもやすまずつちうつひびき)"
      , filename = "muranokajiya_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1LA2tJNHcDnLULcFeZlgrebxIfpBRldoc"
      , mp3Url = "https://drive.google.com/uc?id=12DqY7QpcHmTPmOKR9e2qisWw3nXj3bDW"
      , title = "ないしょ話(ないしょないしょないしょのはなしはあのねのね)"
      , filename = "naishobanashi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=173YBD3K4i38Jwp86tITt8HLP6meH95EF"
      , mp3Url = "https://drive.google.com/uc?id=1I67md4E3xmihAW4NUtkpxMSBhuFFiwSj"
      , title = "啼くな小鳩よ(なくなこばとよこころのつまよ)"
      , filename = "nakunakobato_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1p0WE_D-BQflLSFKCb-zBdrf5-JP9rpXK"
      , mp3Url = "https://drive.google.com/uc?id=1KPPux4R0iWYFLmgXkT3nlp7S0ARO4gsm"
      , title = "人形(わたしのにんぎょうはよいにんぎょう)"
      , filename = "ningyou_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1GkAovEn1RX0octtij3RhEFRVP909RVkj"
      , mp3Url = "https://drive.google.com/uc?id=1-EnDUJAs3H2mXxAuQUNTThOwEqwr2aeZ"
      , title = "おうま(おうまのおやこはなかよしこよし)"
      , filename = "ouma_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1NUhjyN1RA7hHIdgehT_t8c3a-lmtwfOi"
      , mp3Url = "https://drive.google.com/uc?id=1fJlzuVAvv8HlLFnfEAZAYFKlzrcCrm_w"
      , title = "お江戸日本橋(おえどにほんばしななつだち)"
      , filename = "oedonihonbashi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Ypf-qHMJpCNGCQaM9z-S6HrD52WxuYd4"
      , mp3Url = "https://drive.google.com/uc?id=https://drive.google.com/file/d/1zGxhzgyQzCioWc2q-ndPsngTc31B62Wl/view?usp=sharing"
      , title = "男の純情(おとこいのちのじゅんじょうは)"
      , filename = "otokonojunjo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kbZWYmbmey3nIiqmOXTOtRkTe9CaBy96"
      , mp3Url = "https://drive.google.com/uc?id=https://drive.google.com/file/d/1zYbflXUGPh9uanDKb0fUtFgBKess3CED/view?usp=sharing"
      , title = "籠の鳥(あいたさみたさにこわさをわすれ)"
      , filename = "kagonotori_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1IvBImRmycyz6DjPcYSKtjePifjl-Qzr8"
      , mp3Url = "https://drive.google.com/uc?id=https://drive.google.com/file/d/1W3TCfx2EcpHzwAZoTjEx8-Pd_9VUg7BO/view?usp=sharing"
      , title = "霞か雲か(かすみかくもか)"
      , filename = "kasumikakumoka_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1DlCptEvaC8hgi2PQ4x8WMDClzqhgQ_Ya"
      , mp3Url = "https://drive.google.com/uc?id=https://drive.google.com/file/d/1K4TQFXgt53K93O0hQARD4Ness4BKWMQL/view?usp=sharing"
      , title = "青い背広で(あおいせびろでこころもかるく)"
      , filename = "aoisebirode_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1rjPPTolAs6n9WqmR99YH0ZRqhWxKbxD8"
      , mp3Url = "https://drive.google.com/uc?id=https://drive.google.com/file/d/1htBCrCocgK3yEJUEMIcuiPw80Y0vj6NJ/view?usp=sharing"
      , title = "愛国行進曲(みよとうかいのそらあけて)"
      , filename = "aikokukoushinkyoku_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=12UvRWM8rLQ-Hw6esfhAWzxbtOQjVjLi_"
      , mp3Url = "https://drive.google.com/uc?id=https://drive.google.com/file/d/1RZD7C6eRljOnZJDszAw2kNW4h6z9XjCO/view?usp=sharing"
      , title = "お富さん(いきなくろべいみこしのまつに)"
      , filename = "otomisan_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1wbK42EmR7xXUeQSheWgWM5T9AGGqto4f"
      , mp3Url = "https://drive.google.com/uc?id=https://drive.google.com/file/d/1tfd7nMuibpLTtRt16BVpk_RHjXoBtd_s/view?usp=sharing"
      , title = "かなりや(うたをわすれたかなりやは)"
      , filename = "canary_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1NuSnmhtLx6Qvz4J81ZAq055q5zmii-Nv"
      , mp3Url = "https://drive.google.com/uc?id=https://drive.google.com/file/d/1aN36sgqSVuMOc1RQJsjMtzs6B2xmFVmE/view?usp=sharing"
      , title = "鎌倉(しちりがはまのいそづたい)"
      , filename = "kamakura_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1HwuZutXc5NfkfpSZ6ICPPeclzBRvsqgX"
      , mp3Url = "https://drive.google.com/uc?id=https://drive.google.com/file/d/1e3PqIRk1uLk0ykS9S2htaLznGfnIKDrU/view?usp=sharing"
      , title = "祇園小唄(つきはおぼろにひがしやま)"
      , filename = "gionkouta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1liXkLE-Z4S8DKtXm_nO5jTlsf0ROOzeX"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "こうま(はいしいはいしいあゆめよこうま)"
      , filename = "kouma_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13KV-EiwvQKWRWorJeS1WicxqVcuhzp65"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "いい日旅立ち(ゆきどけまじかの)"
      , filename = "iihitabidachi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1BNWJa26phih8CrpppZGfG9UeD-otw4Vp"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "アラビアの唄(さばくにひがおちて)"
      , filename = "arabianouta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1fSXhNugAfnQSHWFJWP23niQpiYHYIPnl"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ハバロフスク小唄"
      , filename = "khabarovsk_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1FMZml7mjGJNA7XF_-48Wm6HRRyQ5dK0h"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "人を恋うる歌(つまをめとらばさいたけて)"
      , filename = "hitowokouruuta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1A1WQWvBdvtq-2HG3866E829in4feFhxB"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "蛍の光(ほたるのひかりまどのゆき)"
      , filename = "hotarunohikari_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1V3PZkn6E93JZ9JJUwsq5NWiw34QczT7R"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "麦と兵隊(じょしゅうじょしゅうとじんばはすすむ)"
      , filename = "mugitoheitai_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1uCHqo0azmYAlA_uXPSbIDqONPcCCsktO"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "スーダラ節(植木等、ちょいといっぱいのつもりでのんで)"
      , filename = "sudarabushi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1tVmfz3faOwEveDWJApQG9xweRfMgwvFg"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "たばこやの娘(むこうよこちょうのたばこやの)"
      , filename = "tabakoya_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1kxOYfelkCWJWdqdzQwGLunk5b3Eyj-il"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "戦友(ここはおくにをなんびゃくり)"
      , filename = "senyu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1H9x-T6fjb_sjkHl-s52H46G1fuUyTZVl"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "聖夜(きよしこのよる)"
      , filename = "kiyoshi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1LhI4p3-y43yjRTsunZmdrWHBaHL-12O3"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "水師営の会見(りょじゅんかいじょうやくなりて)"
      , filename = "suishiei_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1yt6gggdFlWJAC7Ea1VFynNudMgexw3hD"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ああモンテンルパの夜は更けて(モンテンルパの夜は更けて。Muntinlupa, フィリピン)"
      , filename = "muntinlupa_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1HCKDyKe26zXilVRcnlHUxH_-tpljznqh"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ああそれなのに(そらにゃきょうもあどばるん)"
      , filename = "aasorenanoni_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1TyXh_lLKgQBWLw_6d1Bpj1qChC_Fmii1"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "君の名は(きみのなはとたずねしひとあり)"
      , filename = "kiminonawa_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1dbuMVmgM8cXyYChsqnbCZwykPl4YWLqM"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "燦めく星座(おとこじゅんじょうのあいのほしのいろ)"
      , filename = "kirameku_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Mk3bjG4Ovg71peIc8u9j9Ixf_Yxm6y_-"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "トンコ節(あなたのくれたおびどめの)"
      , filename = "tonkobushi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=12WHCh3bSgfcROcH5vhs3-rLOEiwXFQj1"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "宵待草(まてどくらせどこぬひとを)"
      , filename = "yoimachigusa_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1J5oT1Lr4cFefIQxVziArMJONFHIc9YVs"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "懐かしのブルース(ふるいにっきのぺーじには)"
      , filename = "natsukashinoblues_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1wX8u-bRNe2-iGncvahYANZTX0bylkQvm"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "悲しき口笛(おかのほてるのあかいひも)"
      , filename = "kanashikikuchibue_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10SE8IKAjQPKPDmWpMk2jJpCUF0-mCEli"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ジングル・ベル(クリスマス。のをこえておかをこえ)"
      , filename = "jinglebell_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Z2Qxq8UoHBDMv6wXuRmNMJWwryg2EN0z"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ママがサンタにキスをした(クリスマス。I Saw Mommy Kissing Santa Claus)"
      , filename = "mommykisssanta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1qXQbr3mQNF3S-v4DhMvkiKLo5jKEnxFk"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ラスト・クリスマス(ワム！)"
      , filename = "lastchristmas_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ldi4WgfnPKqNFh1ZnpOh4GLHoIKNCXed"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ジョニーが凱旋するとき(When Johnny Comes Marching Home)"
      , filename = "whenjohnny_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=13H_NvIKtfeFW_fRM21rU0LV5VS2K970w"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ホワイト・クリスマス"
      , filename = "whitechristmas_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10ZhxQ5_NiHQT9tAn7PHhqiNQ7AtzWxq8"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "おめでとうクリスマス(We Wish You a Merry Christmas)"
      , filename = "omedetouchristmas_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1ouKwNK7a8O1SbxiNA6754Mekw4wqbq9r"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "そりすべり(リロイ・アンダーソン。クリスマス)"
      , filename = "sorisuberi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1h0xYFiUwo3frFS1nyEaJc6pjrOFZjMc4"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "好きだった(すきだったうそじゃなかったすきだった)"
      , filename = "sukidatta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1w1LhB8aOftp1A3zOmlSQGjMye7GsowJI"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "もろびとこぞりて(クリスマス)"
      , filename = "morobito_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Rn_NdO_TVfUzQSEz5hzfyiDWzpV0POo0"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "仲よし小道(なかよしこみちはどこのみち)"
      , filename = "nakayoshikomichi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1IacrrSmODZqEb8SLBJM9oMx3HzWCn9aU"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ドレミの歌(どはどーなつのど)"
      , filename = "doreminouta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1GVv_r_eSmVHEJj6taKeADSWvF9yZ2z0Z"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "チューリップ(さいたさいたちゅーりっぷのはなが)"
      , filename = "tulip_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1Rj5vA2sE-XqwPHlLHsnLYhLnXXqj9fiN"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "案山子(やまだのなかのいっぽんあしの)"
      , filename = "kakashi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=11bHak0tzxDlND1TNEspcwXXQuKbC4ach"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "影を慕いて(まぼろしのかげをしたいて)"
      , filename = "kagewoshitaite_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1zEp_VHoJXF1bH0cthqkJiQcvbbuGGU9h"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "鞠と殿さま(てんてんてんまりてんてまり)"
      , filename = "maritotonosama_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1yqt87jCmOvXvJcKUP7dCYDfVnKQWgDAS"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "真白き富士の嶺(七里ヶ浜の哀歌。ましろきふじのね)"
      , filename = "mashiroki_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1uhrOl8NYnOogep1FKU6BvOu67rrM_WC4"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "テネシーワルツ"
      , filename = "tennessee_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1cs8EtDp7rspgab-wc2SRypaDA_BtrLsW"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "津軽海峡・冬景色(うえのはつのやこうれっしゃおりたときから)"
      , filename = "tsugaru_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1v4uTA1-Jt49kVvW5vbe9sz53SwAcMhkK"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "三百六十五歩のマーチ(しあわせはあるいてこない)"
      , filename = "sanbyaku65_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1sU5bD3t5INqd-8fqEiTomKyGqmQiklmP"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "別れのブルース(まどをあければ)"
      , filename = "wakarenoblues_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=10xGOm73NxgOpcuXK1qxvhPXQ1TOyrdMw"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "桑港のチャイナタウン(さんふらんしすこのちゃいなたうん)"
      , filename = "chinatown_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1PbYS8lbD7Y13BisNcnjdvsnMY0GZVx6L"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "さんぽ(あるこうあるこうわたしはげんき)"
      , filename = "sanpo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1mKepNmNB2Sq5XiOqLP7dKnQzaoEWbFZH"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "森の小人(もりのこかげでどんじゃらほい)"
      , filename = "morinokobito_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1B9gDWevIcVvpd03E9cSS1Kcx_K5TyMS3"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "若鷲の歌(わかいちしおのよかれんの)"
      , filename = "wakawashinouta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1jpv7TUhae3NcmeOMebhfLYJu4bAEj6vG"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "あら野のはてに(あらののはてにゆうひはおちて。クリスマス)"
      , filename = "aranonohateni_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1gU6S8zYcwn_DUkh7bRY7PmpsyBw3XS19"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "あわてんぼうのサンタクロース(クリスマス)"
      , filename = "awatenbo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1bRvWIAaz5jkCp2cF1dWILxHdF9roI3jq"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "牧人ひつじを(まきびとひつじをまもれる。クリスマス)"
      , filename = "makibito_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1O4Q1dRvw9dyqxExTNTfg7T7GN9bxkzwU"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "冬景色(さぎりきゆるみなとえの)"
      , filename = "fuyugeshiki_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1MHOF5ij89pecc636InrKXQyWd2qm8oyT"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ひいらぎかざろう(クリスマス)"
      , filename = "hiiragi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1QDMCoj8CYbQ-rd-S2hPiafauRykr4w7R"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "涙そうそう(ふるいあるばむめくりありがとうってつぶやいた)"
      , filename = "nadasoso_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id=1cONlZ-VAnHRjaG-A6_nJviwRQt6q47Eb"
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "アメイジング・グレイス"
      , filename = "amazinggrace_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "翼をください(いまわたしのねがいごとがかなうならば)"
      , filename = "tsubasa_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "青い目の人形(あおいめをしたおにんぎょは)"
      , filename = "aoimewoshita_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "青い山脈(わかくあかるいうたごえに)"
      , filename = "aoisanmyaku_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "上を向いて歩こう"
      , filename = "uewomuite_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "夢はひそかに(ディズニー「シンデレラ」)"
      , filename = "dreamisawish_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "右から2番目の星(ディズニー「ピーター・パン」)"
      , filename = "migikara2banme_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ふるさと(うさぎおいしかのやま)"
      , filename = "furusato_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "花は咲く(まっしろなゆきみちにはるかぜかおる)"
      , filename = "hanawasaku_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "浜辺の歌(あしたはまべをさまよえば)"
      , filename = "hamabe_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ライオンは寝ている(トークンズ)"
      , filename = "lionsleeps_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ラ・ラ・ルー(ディズニー「わんわん物語」)"
      , filename = "lalalu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ドラゴンクエスト序曲"
      , filename = "dragonquest_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "歌の町（よい子がすんでるよいまちは）"
      , filename = "utanomachi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "叱られて(しかられてあのこはまちまでおつかいに)"
      , filename = "shikararete_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "春の唄(らららあかいはなたば)"
      , filename = "harunouta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "少年時代(なつがすぎかぜあざみ)"
      , filename = "shonenjidai_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ハイ・ホー(くちぶえをげんきにふきならし、ディズニー「白雪姫」)"
      , filename = "heighho_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "シンコペーテッド・クロック(ルロイ・アンダーソン)"
      , filename = "syncopatedclock_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "オネスティ(ビリー・ジョエル)"
      , filename = "honesty_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "日の丸の旗（しろじにあかくひのまるそめて）"
      , filename = "hinomaru_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "アイアイ(あいあいあいあいおさるさんだよ)"
      , filename = "aiai_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ビッグ・ベンの鐘(ウェストミンスター宮殿の時計)"
      , filename = "bigben_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "恋は水色(ポール・モーリア)"
      , filename = "lamourestbleu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ここに幸あり(あらしもふけばあめもふる)"
      , filename = "kokonisachi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ポリリズム(Perfume とてもだいじなきみのおもいは)"
      , filename = "polyrhythm_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "あの町この町(あのまちこのまちひがくれる)"
      , filename = "anomachi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "船頭さん(むらのわたしのせんどさんは)"
      , filename = "sendo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "春よ、来い(松任谷由美。あわきひたりたつにわかあめ)"
      , filename = "haruyokoimatsutoya_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "たこのうた(たこたこあがれ)"
      , filename = "takotako_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "浪花節だよ人生は(のめといわれてすなおにのんだ)"
      , filename = "naniwabushi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "マルエツの歌(どくたーげんきどくたーげんき)"
      , filename = "maruetsu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ローソンストア100(ひゃくひゃくひゃくえん)"
      , filename = "lawsonhyaku_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ケーズデンキの歌(ゆめゆめはっぴーいつでもやすい)"
      , filename = "ksdenki_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "すみだ川(いちょうがえしにくろじゅすかけて)"
      , filename = "sumidagawa_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "誰か故郷を想わざる(はなつむのべにひはおちて)"
      , filename = "darekakokyowo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "セサミストリートのテーマ(さーにーでい)"
      , filename = "sesamistreet_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "人生劇場(やるとおもえばどこまでやるさ)"
      , filename = "jinseigekijo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "若いお巡りさん(もしもしべんちでささやくおふたりさん)"
      , filename = "wakaiomawari_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "冬の夜(ともしびちかくきぬぬうははは)"
      , filename = "fuyunoyoru_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "兎のダンス(タラッタラッタラッタ)"
      , filename = "usaginodance_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "カチューシャ(りんごのはなほころび)"
      , filename = "katyusha_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ハート・アンド・ソウル(Heart and Soul)"
      , filename = "heartandsoul_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "世界に一つだけの花(はなやのみせさきにならんだ)"
      , filename = "sekainihitotsu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "故郷を離るる歌(そののさゆりなでしこかきねのちぐさ)"
      , filename = "kokyowohanaruru_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "アマリリス(みんなできこうたのしいオルゴールを)"
      , filename = "amaryllis_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "東京節(パイノパイノパイ)"
      , filename = "tokyobushi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "行商人(コロブチカ、korobeiniki, korobushka)"
      , filename = "korobeiniki_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "春よ来い(はるよこいはやくこいあるきはじめた)"
      , filename = "haruyokoishoka_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "蒲田行進曲(にじのみやこひかりのみなときねまのてんち)"
      , filename = "kamata_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "カリンカ"
      , filename = "kalinka_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "君は我が心の中に(Du, Du Liegst Mir Im Herzen)"
      , filename = "duliegstmir_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "トロイカ(ゆきのしらかばなみき)"
      , filename = "troika_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "美しき天然(そらにさえずるとりのこえ)"
      , filename = "utsukushiki_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "冬のソナタ(最初から今まで )"
      , filename = "fuyunosonata_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "いつも何度でも(千と千尋の神隠し。よんでいるどこかむねのおくで)"
      , filename = "itsumonando_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "主よ人の望みの喜びよ(J.S.バッハ)"
      , filename = "shuyohitononozomino_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ありのままで(アナと雪の女王イントロ。let It Go)"
      , filename = "letitgointro_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ます(シューベルト)"
      , filename = "masu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "華麗なる大円舞曲(ショパン)"
      , filename = "kareinaru_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "天国と地獄(オッフェンバック)"
      , filename = "tengokujigoku_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "クシコス・ポスト(ネッケ)"
      , filename = "csikospost_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "軍艦マーチ(まもるもせむるも)"
      , filename = "gunkan_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "恋とはどんなものかしら(モーツアルト。フィガロの結婚より)"
      , filename = "koitowadonna_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "同期の桜(きさまとおれとは)"
      , filename = "doukinosakura_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "東京音頭(とうきょうおんど。はあーおどりおどるならちょいと)"
      , filename = "tokyoondo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ジムノペディ1番(サティ)"
      , filename = "gymnopedies_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "亜麻色の髪の乙女(ドビュッシー)"
      , filename = "amairodebussy_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "美しき青きドナウ(ヨハン・シュトラウス2世)"
      , filename = "donau_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ジュ・トゥ・ヴ(エリック・サティ)"
      , filename = "jeteveux_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "モーツァルトの子守歌"
      , filename = "mozartkomori_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ブラームスの子守歌"
      , filename = "brahmskomori_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "運命(ベートーベン交響曲5番)"
      , filename = "unmei_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ハバネラ(ビゼー。カルメンより)"
      , filename = "habanera_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "新世界(ドヴォルザーク)"
      , filename = "shinsekai_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ヴィヴァルディ四季より春"
      , filename = "vivaldishiki_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "威風堂々(エルガー)"
      , filename = "ifudodo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "春の歌(メンデルスゾーン)"
      , filename = "mendelsharunouta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "乾杯の歌(ヴェルディ)"
      , filename = "kanpai_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ラデツキー行進曲(ヨハン・シュトラウス1世)"
      , filename = "radetzky_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ずいずいずっころばし"
      , filename = "zuizui_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "燃えろよ燃えろよ"
      , filename = "moeroyo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "マイボニー(My Bonnie Lies Over the Ocean)"
      , filename = "mybonnie_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "茶色の小瓶"
      , filename = "chairo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "権兵衛さんの赤ちゃん(ごんべえさんのあかちゃんが)"
      , filename = "gonbe_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "山の音楽家(わたしゃおんがくかやまのこりす)"
      , filename = "yamanoongakuka_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "木星(ホルスト「惑星」よりジュピター)"
      , filename = "mokusei_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "アイネ・クライネ・ナハト・ムジーク(モーツァルト)"
      , filename = "eineclinenacht_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "雨だれの前奏曲(ショパン)"
      , filename = "amadare_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "愛の喜び(マルティーニ)"
      , filename = "ainoyorokobi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "江戸の子守唄(ねんねんころりよおころりよ)"
      , filename = "edokomori_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "あんたがたどこさ(ひごさひごどこさくまもとさ)"
      , filename = "antagata_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "一週間(にちようびにいちばにでかけ)"
      , filename = "isshukan_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "森のくまさん(あるひもりのなかくまさんにであった)"
      , filename = "morinokuma_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "川の流れのように(しらずしらずあるいてきた)"
      , filename = "kawanonagare_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "夏の思い出(なつがくればおもいだす)"
      , filename = "natsunoomoide_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ブラームスのワルツ(円舞曲)"
      , filename = "waltzbrahms_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "線路は続くよどこまでも(せんろはつづくよどこまでも)"
      , filename = "senrowa_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "幸せなら手をたたこう(しあわせならてをたたこう)"
      , filename = "shiawasenara_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "雪(ゆきやこんこあられやこんこ)"
      , filename = "yukiyakonko_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "北国の春(しらかばあおぞらみなみかぜ)"
      , filename = "kitaguninoharu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "静かな湖畔(しずかなこはんのもりのかげから)"
      , filename = "shizukanakohan_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "女のみち(わたしがささげたそのひとに)"
      , filename = "onnanomichi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "おもちゃのチャチャチャ"
      , filename = "omochanochachacha_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ペールギュントより朝(グリーグ)"
      , filename = "peergyntasagrieg_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ホルン協奏曲第1番(モーツァルト)"
      , filename = "hornmozart_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "池の雨(ヤマハ音楽教室幼児科メロディー暗唱曲)"
      , filename = "ikenoame_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ベートーベンのトルコ行進曲"
      , filename = "turkbeethoven_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "げんこつやまのたぬきさん"
      , filename = "genkotsu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "聖者が街にやってくる(聖者の行進))"
      , filename = "seija_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "こぎつね(こぎつねこんこんやまのなか)"
      , filename = "kogitsune_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ロンドン橋(ろんどんばしおちた)"
      , filename = "londonbashi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "メリーさんの羊(めりーさんのひつじ)"
      , filename = "marysanno_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "アブラハムの子(あぶらはむにはしちにんのこ)"
      , filename = "abrahamunoko_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "茶摘(ちゃつみ。なつもちかづくはちじゅうはちや)"
      , filename = "chatsumi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "大きな古時計(おおきなのっぽのふるどけい)"
      , filename = "okinafurudokei_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "たき火(かきねのかきねのまがりかど)"
      , filename = "takibi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "四季の歌(はるをあいするひとは)"
      , filename = "shikinouta_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "かたつむり(でんでんむしむし)"
      , filename = "katatsumuri_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ほたるこい"
      , filename = "hotarukoi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "かごめかごめ(かごのなかのとりは)"
      , filename = "kagome_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "かえるの合唱(かえるのうたがきこえてくるよ)"
      , filename = "kaerunogassho_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ゆかいな牧場(いちろうさんのまきばでいーあいいーあいおー)"
      , filename = "yukainamakiba_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ぶんぶんぶん(ぶんぶんぶんはちがとぶ)"
      , filename = "bunbunbun_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "大きな栗の木の下で(おおきなくりのきのしたで)"
      , filename = "okinakuri_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "とんぼのめがね"
      , filename = "tonbono_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "お正月(もういくつねるとおしょうがつ)"
      , filename = "oshogatsu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "手をたたきましょう"
      , filename = "tewotata_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "凱旋行進曲(ヴェルディ。アイーダ)"
      , filename = "gaisen_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "Ob-La-Di, Ob-La-Da (ビートルズ)"
      , filename = "obladi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "Carry That Weight (ビートルズ)"
      , filename = "carrythatweight_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "Across the Universe (ビートルズ)"
      , filename = "acrossuniverse_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "有楽町で逢いましょう(あなたをまてばあめがふる)"
      , filename = "yurakucho_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "秋桜(うすべにのこすもすがあきのひの)"
      , filename = "cosmos_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "だんご３兄弟(くしにささってだんごだんご)"
      , filename = "dango3kyodai_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "チム・チム・チェリー(ちむちむにーちむちむにー)"
      , filename = "chimchimcheree_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "鉄腕アトム(そらをこえてららら)"
      , filename = "tetsuwan_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "夜霧よ今夜もありがとう(しのびあうこいをつつむよぎりよ)"
      , filename = "yogiriyo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "星の流れに(ほしのながれにみをうらなって)"
      , filename = "hoshinonagareni_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "一月一日(いちがついちじつ、としのはじめのためしとて)"
      , filename = "ichigatsuichijitsu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "かっこう"
      , filename = "kakkou_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "きらきら星(きらきらぼし)"
      , filename = "kirakira_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "こいのぼり(やねよりたかい)"
      , filename = "koinobori_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "この道(このみちはいつかきたみち)"
      , filename = "konomichi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "この世の花(このよのはな。あかくさくはなあおいはな)"
      , filename = "konoyonohana_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ミッキーマウス・マーチ(ぼくらのくらぶのりーだーは)"
      , filename = "mickeymousemarch_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "みかんの花咲く丘(みかんのはながさいている)"
      , filename = "mikan_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "もみじ(あきのゆうひにてるやま)"
      , filename = "momiji_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "虫の声(あれまつむしがないている)"
      , filename = "mushinokoe_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "むすんでひらいて(むすんでひらいててをうってむすんで)"
      , filename = "musunde_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "南国土佐を後にして(なんごくとさをあとにして)"
      , filename = "nangoku_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ワンツー・ジェンカ(おおきくくちあけて)"
      , filename = "onetwojenkka_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "再会(さいかい。あえなくなってはじめてしった)"
      , filename = "saikai_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "さくらさくら"
      , filename = "sakura_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "酋長の娘(わたしのらばさん)"
      , filename = "shuchou_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "小さな世界(ちいさなせかい、It's a small world、せかいじゅうどこだって)"
      , filename = "smallworld_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "竹田の子もりうた(もりもいやがるぼんから)"
      , filename = "takedanokomori_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "赤鼻のトナカイ(Rudolph the Red-Nosed Reindeer、まっかなおはなの。クリスマス)"
      , filename = "tonakai_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "幻想即興曲(ショパン)"
      , filename = "gensou_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "君が代(きみがよはちよにやちよに)"
      , filename = "kimigayo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "シューベルトの子守歌(ねむれねむらははのむねに)"
      , filename = "schubertkomori_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "シューベルトの野ばら(わらべはみたりのなかのばら)"
      , filename = "schubertnobara_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "野球拳(やきゅうけん。やきゅうするならこういうぐあいにしやしゃんせ)"
      , filename = "yakyuken_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "赤い靴(あかいくつはいてたおんなのこ)"
      , filename = "akaikutsu_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "赤とんぼ(ゆうやけこやけのあかとんぼ)"
      , filename = "akatonbo_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "亜麻色の髪の乙女(ヴィレッジ・シンガーズ。あまいろのながいかみをかぜが)"
      , filename = "amaironokami_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "あの子はたあれ(あのこはたあれたれでしょね)"
      , filename = "anokowatare_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "仰げば尊し(あおげばとうとしわがしのおん)"
      , filename = "aogeba_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "ちょうちょう(ちょうちょうちょうちょうなのはにとまれ)"
      , filename = "chouchou_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "カントリー・ロード(かんとりーろーど、このみち)"
      , filename = "countryroad_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "どんぐりころころ(どんぐりころころどんぶりこ)"
      , filename = "donguri_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "富士山(ふじさん。あたまをくものうえにだし)"
      , filename = "fujisan_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "春が来た(はるがきた)"
      , filename = "harugakita_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "春風(ふけそよそよふけはるかぜよ)"
      , filename = "harukaze_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "春の小川(はるのおがわはさらさらながる)"
      , filename = "harunoogawa_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "うさぎ(うさぎうさぎなにみてはねる)"
      , filename = "usagi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "われは海の子(われはうみのこしらなみの)"
      , filename = "warewaumi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "椰子の実(やしのみ。なもしらぬとおきしまより)"
      , filename = "yashinomi_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "イエスタデイ・ワンス・モア(カーペンターズ)"
      , filename = "yesterdayonce_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "勇気100パーセント(がっかりしてめそめそしてどうしたんだい)"
      , filename = "yuki100p_crop.pdf"
      }
    , { jpgUrl = "https://drive.google.com/uc?id="
      , mp3Url = "https://drive.google.com/uc?id="
      , title = "喜びの歌(はれたるあおぞらただようくもよ)"
      , filename = "yorokobi_crop.pdf"
      }
    ]
