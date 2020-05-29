module Arabic001 exposing (main)

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
    { latin : String
    , kana : String
    , arabic : String
    , meaning : String
    , showanswer : Bool
    , list : List Arabicdata
    }


type alias Arabicdata =
    { latin : String
    , kana : String
    , arabic : String
    , meaning : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" "" "" "" False dict
    , Random.generate NewList (shuffle dict)
    )


type Msg
    = Delete
    | Next
    | NewRandom Int
    | Shuffle
    | NewList (List Arabicdata)
    | ShowAnswer Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Delete ->
            ( model
            , Cmd.none
            )

        Next ->
            ( model
            , Cmd.none
            )

        NewRandom n ->
            case List.drop n dict of
                x :: _ ->
                    ( { model
                        | latin = x.latin
                        , kana = x.kana
                        , arabic = x.arabic
                        , meaning = x.meaning
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

        ShowAnswer index ->
            case List.drop index model.list of
                x :: _ ->
                    ( { model
                        | latin = x.latin
                        , kana = x.kana
                        , arabic = x.arabic
                        , meaning = x.meaning
                        , showanswer = True
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


view : Model -> Html Msg
view model =
    div []
        [ text "Convert latin to arabic"
        , p [] [ text "SabaaH" ]
        , button [] [ text "Show Answer" ]
        , button [] [ text "Delete" ]
        , button [] [ text "Next" ]
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
    [ { latin = "a-s-salaamu"
      , kana = "アッサラーム"
      , arabic = "اَلسَّلَامُ"
      , meaning = "peace"
      }
    , { latin = "2alaykum"
      , kana = "アライクム"
      , arabic = "عَلَيْكُمْ"
      , meaning = "on you"
      }
    , { latin = "SabaaH"
      , kana = "サバーフ"
      , arabic = "صَبَاح"
      , meaning = "morning"
      }
    , { latin = "marHaban"
      , kana = "マルハバン"
      , arabic = "مَرْحَبًا"
      , meaning = "Hello"
      }
    , { latin = "2anaa bikhayr"
      , kana = "アナー ビクハイル"
      , arabic = "أَنا بِخَيْر"
      , meaning = "I'm fine"
      }
    , { latin = "kabir"
      , kana = "カビール"
      , arabic = "كَبير"
      , meaning = "large, big"
      }
    , { latin = "kabiira"
      , kana = "カビーラ"
      , arabic = "كبيرة"
      , meaning = "large, big"
      }
    , { latin = "siith"
      , kana = "スィース"
      , arabic = "سيث"
      , meaning = "Seth (male name)"
      }
    , { latin = "baluuza"
      , kana = "バルーザ"
      , arabic = "بَلوزة"
      , meaning = "blouse"
      }
    , { latin = "tii shiirt"
      , kana = "ティー シイールト"
      , arabic = "تي شيرْت"
      , meaning = "T-shirt"
      }
    , { latin = "ma3Taf"
      , kana = "マアタフ"
      , arabic = "معْطَف"
      , meaning = "a coat"
      }
    , { latin = "riim"
      , kana = "リーム"
      , arabic = "ريم"
      , meaning = "Reem (male name)"
      }
    , { latin = "tan-nuura"
      , kana = "タンヌーラ"
      , arabic = "تَنّورة"
      , meaning = "a skirt"
      }
    , { latin = "jadiid"
      , kana = "ジャディード"
      , arabic = "جَديد"
      , meaning = "new"
      }
    , { latin = "wishshaaH"
      , kana = "ウィシャーハ"
      , arabic = "وِشَاح"
      , meaning = "a scarf"
      }
    , { latin = "juudii"
      , kana = "ジューディー"
      , arabic = "جودي"
      , meaning = "Judy(name)"
      }
    , { latin = "jamiil"
      , kana = "ジャミール"
      , arabic = "جَميل"
      , meaning = "good, nice, pretty, beautiful"
      }
    , { latin = "kalb"
      , kana = "キャルブ"
      , arabic = "كَلْب"
      , meaning = "a dog"
      }
    , { latin = "2abyaD"
      , kana = "アビヤッド"
      , arabic = "أَبْيَض"
      , meaning = "white"
      }
    , { latin = "qub-b3a"
      , kana = "クッバ"
      , arabic = "قُبَّعة"
      , meaning = "a hat"
      }
    , { latin = "mruu2a"
      , kana = "ムルーア"
      , arabic = "مْروءة"
      , meaning = "chivalry"
      }
    , { latin = "Taawila"
      , kana = "ターウィラ"
      , arabic = "طاوِلة"
      , meaning = "a table"
      }
    , { latin = "haadhihi madiina qadiima"
      , kana = "ハージヒ マディーナ カディーマ"
      , arabic = "هَذِهِ مَدينة قَديمة"
      , meaning = "This is an ancient city"
      }
    , { latin = "haadhihi binaaya jamiila"
      , kana = "ハージヒ ビナーヤ ジャミーラ"
      , arabic = "هَذِهِ بِناية جَميلة"
      , meaning = "This is a beautiful building"
      }
    , { latin = "hadhaa muhammad"
      , kana = "ハーザー ムハンマド"
      , arabic = "هَذا مُحَمَّد"
      , meaning = "This is Mohammed"
      }
    , { latin = "haadhihi Hadiiqa jamiila"
      , kana = "ハージヒ ハディーカ ジャミーラ"
      , arabic = "هَذِهِ حَديقة جَميلة"
      , meaning = "This is a pretty garden"
      }
    , { latin = "haadhihi Hadiiqa qadiima"
      , kana = "ハージヒ ハディーカ カディーマ"
      , arabic = "هَذِهِ حَديقة قَديمة"
      , meaning = "This is an old garden"
      }
    , { latin = "al-Haa2iT"
      , kana = "アルハーイト"
      , arabic = "الْحائط"
      , meaning = "the wall"
      }
    , { latin = "Haa2iT"
      , kana = "ハーイト"
      , arabic = "حائِط"
      , meaning = "wall"
      }
    , { latin = "hadhaa al-Haa2iT kabiir"
      , kana = "ハーザ ル ハーイト カビール"
      , arabic = "هَذا الْحائِط كَبير"
      , meaning = "this wall is big"
      }
    , { latin = "al-kalb"
      , kana = "アル カルブ"
      , arabic = "الْكَلْب"
      , meaning = "the dog"
      }
    , { latin = "haadhihi al-binaaya"
      , kana = "ハージヒ アル ビナーヤ"
      , arabic = "هذِهِ الْبِناية"
      , meaning = "this building"
      }
    , { latin = "al-ghurfa"
      , kana = "アル グルファ"
      , arabic = "اَلْغُرفة"
      , meaning = "the room"
      }
    , { latin = "al-ghurfa kabiira"
      , kana = "アルグルファ カビーラ"
      , arabic = "اَلْغرْفة كَبيرة"
      , meaning = "Theroom is big"
      }
    , { latin = "haadhihi alghurfa kabiira"
      , kana = "ハージヒ アルグルファ カビーラ"
      , arabic = "هَذِهِ الْغُرْفة كَبيرة"
      , meaning = "this room is big"
      }
    , { latin = "hadhaa alkalb kalbii"
      , kana = "ハーザー アルカルブ カルビー"
      , arabic = "هَذا  الْكَلْب كَْلبي"
      , meaning = "this dog is my dog"
      }
    , { latin = "hadhaa alkalb jaw3aan"
      , kana = "ハーザー アルカルブ ジャウアーン"
      , arabic = "هَذا الْكَلْب جَوْعان"
      , meaning = "this dog is hungry"
      }
    , { latin = "haadhihi al-binaaya waasi3a"
      , kana = "ハージヒ アルビナーヤ ワースィア"
      , arabic = "هَذِهِ الْبناية واسِعة"
      , meaning = "this building is spacious"
      }
    , { latin = "al-kalb ghariib"
      , kana = "アルカルブ ガリーブ"
      , arabic = "اَلْكَلْب غَريب"
      , meaning = "The dog is weird"
      }
    , { latin = "alkalb kalbii"
      , kana = "アルカルブ カルビー"
      , arabic = "اَلْكَلْب كَلْبي"
      , meaning = "The dog is my dog"
      }
    , { latin = "hunaak"
      , kana = "フナーク"
      , arabic = "هُناك"
      , meaning = "there"
      }
    , { latin = "hunaak bayt"
      , kana = "フナーク バイト"
      , arabic = "هُناك بَيْت"
      , meaning = "There is a house"
      }
    , { latin = "al-bayt hunaak"
      , kana = "アル バイト フナーク"
      , arabic = "اَلْبَيْت هُناك"
      , meaning = "The house is there"
      }
    , { latin = "hunaak wishaaH 2abyaD"
      , kana = "フナーク ウィシャーハ アビヤド"
      , arabic = "هُناك وِشاح أبْيَض"
      , meaning = "There is a white scarf"
      }
    , { latin = "alkalb munaak"
      , kana = "アルカルブ ムナーク"
      , arabic = "اَلْكَلْب مُناك"
      , meaning = "The dog is there"
      }
    , { latin = "fii shanTatii"
      , kana = "フィー シャンタティー"
      , arabic = "في شَنْطَتي"
      , meaning = "in my bag"
      }
    , { latin = "hal 3indak maHfaDha yaa juurj"
      , kana = "ハル アインダク マハファザ ヤー ジュールジュ"
      , arabic = "هَل عِنْدَك مَحْفَظة يا جورْج"
      , meaning = "do you have a wallet , george"
      }
    , { latin = "3indii shanTa ghaalya"
      , kana = "アインディー シャンタ ガーリヤ"
      , arabic = "عِنْدي شَنْطة غالْية"
      , meaning = "I have an expensive bag"
      }
    , { latin = "shanTatii fii shanTatik ya raanyaa"
      , kana = "シャンタティー フィー シャンタティク ヤー ラーニヤー"
      , arabic = "شِنْطَتي في شَنْطتِك يا رانْيا"
      , meaning = "my bag is in your bag rania"
      }
    , { latin = "huunak maHfaDha Saghiira"
      , kana = "フナーク マハファザ サギーラ"
      , arabic = "هُناك مَحْفَظة صَغيرة"
      , meaning = "There is a small wallet"
      }
    , { latin = "hunaak kitaab jadiid"
      , kana = "フナーク キターブ ジャディード"
      , arabic = "هَناك كِتاب جَديد"
      , meaning = "There is a new book"
      }
    , { latin = "hunaak kitaab Saghiir"
      , kana = "フナーク キターブ サギール"
      , arabic = "هُناك كِتاب صَغير"
      , meaning = "There is a small book"
      }
    , { latin = "hunaak qubb3a fii shanTatak yaa buub"
      , kana = "フナーク クッバア フィー シャンタタク ヤー ブーブ"
      , arabic = "هُناك قُبَّعة في شَنْطَتَك يا بوب"
      , meaning = "There is a hat in your bag bob"
      }
    , { latin = "hunaak shanTa Saghiira"
      , kana = "フナーク シャンタ サギーラ"
      , arabic = "هُناك شَنْطة صَغيرة"
      , meaning = "There is a small bag"
      }
    , { latin = "shanTatii hunaak"
      , kana = "シャンタティー フナーク"
      , arabic = "شَنْطَتي هُناك"
      , meaning = "my bag is over there"
      }
    , { latin = "hunaak kitaab Saghiir wa-wishaaH kabiir fii ShanTatii"
      , kana = "フナーク キターブ サギール ワ ウィシャーハ カビール フィー シャンタティー"
      , arabic = "هُناك كِتاب صَغير وَوِشاح كَبير في شَنْطَتي"
      , meaning = "There is a small book and a big scarf in my bag"
      }
    , { latin = "hunaak maHfaDha Saghiir fii shanTatii"
      , kana = "フナーク マハファザ サギール フィー シャンタティー"
      , arabic = "هُناك مَحْفَظة صَغيرة في شَنْطَتي"
      , meaning = "There is a small wallet in my bag"
      }
    , { latin = "aljaami3a hunaak"
      , kana = "アルジャーミア フナーク"
      , arabic = "اَلْجامِعة هُناك"
      , meaning = "The university is there"
      }
    , { latin = "hunaak kitaab"
      , kana = "フナーク キターブ"
      , arabic = "هُناك كِتاب"
      , meaning = "There is a book"
      }
    , { latin = "al-madiina hunaak"
      , kana = "アルマディーナ フナーク"
      , arabic = "اَلْمَدينة هُناك"
      , meaning = "Thecity is there"
      }
    , { latin = "hal 3indik shanTa ghaaliya yaa Riim"
      , kana = "ハル アインディク シャンタ ガーリヤ ヤー リーム"
      , arabic = "هَل عِندِك شَنْطة غالْية يا ريم"
      , meaning = "do you have an expensive bag Reem"
      }
    , { latin = "hal 3indik mashruub yaa saamya"
      , kana = "ハル アインディク マシュルーブ ヤー サーミヤ"
      , arabic = "هَل عِنْدِك مَشْروب يا سامْية"
      , meaning = "do you have a drink samia"
      }
    , { latin = "hunaak daftar rakhiiS"
      , kana = "フナーク ダフタル ラクヒース"
      , arabic = "هُناك دَفْتَر رَخيص"
      , meaning = "There is a cheep notebook"
      }
    , { latin = "laysa 3indii daftar"
      , kana = "ライサ アインディー ダフタル"
      , arabic = "لَيْسَ عِنْدي دَفْتَر"
      , meaning = "I do not have a notebook"
      }
    , { latin = "laysa hunaak masharuub fii shanTatii"
      , kana = "ライサ フナーク マシャルーブ フィー シャンタティー"
      , arabic = "لَيْسَ هُناك مَشْروب في شَنْطَتي"
      , meaning = "There is no drink in my bag"
      }
    , { latin = "laysa hunaak kitaab qaSiir fii baytii"
      , kana = "ライサ フナーク キターブ カスィール フィー バイティ"
      , arabic = "لَيْسَ هُناك كِتاب قَصير في بَيْتي"
      , meaning = "There is no short book in my house"
      }
    , { latin = "laysa hunaak daftar rakhiiS"
      , kana = "ライサ フナーク ダフタル ラクヒース"
      , arabic = "لَيْسَ هُناك دَفْتَر رَخيص"
      , meaning = "There is no cheap notebook"
      }
    , { latin = "laysa 3indii sii dii"
      , kana = "ライサ アインディー スィー ヂー"
      , arabic = "لَيْسَ عَنْدي سي دي"
      , meaning = "I do not have a CD"
      }
    , { latin = "laysa hunaak qalam fii shanTatii"
      , kana = "ライサ フナーク カラム フィー シャンタティー"
      , arabic = "لَيْسَ هُناك قَلَم في شَنْطَتي"
      , meaning = "There is no pen in my bag"
      }
    , { latin = "laysa hunaak kitaab qaSiir fii shanTatii"
      , kana = "ライサ フナーク キターブ カスィール フィー シャンタティー"
      , arabic = "لَيْسَ هُناك كِتاب قَصير في شَنْطَتي"
      , meaning = "There is no short book in my bag"
      }
    , { latin = "laysa hunaak daftar 2abyaD"
      , kana = "ライサ フナーク ダフタル アビヤド"
      , arabic = "لَيْسَ هُناك دَفْتَر أَبْيَض"
      , meaning = "There is no white notebook."
      }
    , { latin = "maTbakh"
      , kana = "マタバクフ"
      , arabic = "مَطْبَخ"
      , meaning = "a kitchen"
      }
    , { latin = "3ilka"
      , kana = "アイルカ"
      , arabic = "عِلْكة"
      , meaning = "chewing gum"
      }
    , { latin = "miftaaH"
      , kana = "ミフターフ"
      , arabic = "مفْتاح"
      , meaning = "a key"
      }
    , { latin = "tuub"
      , kana = "トゥーブ"
      , arabic = "توب"
      , meaning = "top"
      }
    , { latin = "nuquud"
      , kana = "ヌクード"
      , arabic = "نُقود"
      , meaning = "money, cash"
      }
    , { latin = "aljazeera"
      , kana = "アルジャズィーラ"
      , arabic = "الجزيرة"
      , meaning = "Al Jazeera"
      }
    , { latin = "kursii"
      , kana = "クルスィー"
      , arabic = "كَرْسي"
      , meaning = "a chair"
      }
    , { latin = "sari3"
      , kana = "サリア"
      , arabic = "سَريع"
      , meaning = "fast"
      }
    , { latin = "Haasuub"
      , kana = "ハースーブ"
      , arabic = "حاسوب"
      , meaning = "a computer"
      }
    , { latin = "maktab"
      , kana = "マクタブ"
      , arabic = "مَكْتَب"
      , meaning = "office, desk"
      }
    , { latin = "hadhaa maktab kabiir"
      , kana = "ハーザー マクタブ カビール"
      , arabic = "هَذا مَِكْتَب كَبير"
      , meaning = "This is a big office"
      }
    , { latin = "kursii alqiTTa"
      , kana = "クルスィー アルキッタ"
      , arabic = "كُرْسي الْقِطّة"
      , meaning = "the cat's chair"
      }
    , { latin = "Haasuub al-2ustaadha"
      , kana = "ハースーブ アル ウスターザ"
      , arabic = "حاسوب اَلْأُسْتاذة"
      , meaning = "professor's computer"
      }
    , { latin = "kursii jadiid"
      , kana = "クルスィー ジャディード"
      , arabic = "كُرْسي جَديد"
      , meaning = "a new chair"
      }
    , { latin = "SaHiifa"
      , kana = "サヒーファ"
      , arabic = "صَحيفة"
      , meaning = "newspaper"
      }
    , { latin = "haatif"
      , kana = "ハーティフ"
      , arabic = "هاتِف"
      , meaning = "phone"
      }
    , { latin = "2amriikiyy"
      , kana = "アムリーキーイ"
      , arabic = "أمْريكِي"
      , meaning = "American"
      }
    , { latin  = "2amriikaa wa-a-S-Siin"
      , kana = "アムリーカー ワ アッスィーン"
      , arabic = "أَمْريكا وَالْصّين"
      , meaning = "America and China"
      }
    , { latin  = "qahwa"
      , kana = "カハワ"
      , arabic = "قَهْوة"
      , meaning = "coffee"
      }
    , { latin  = "Haliib"
      , kana = "ハリーブ"
      , arabic = "حَليب"
      , meaning = "milk"
      }
    , { latin  = "muuza"
      , kana = "ムーザ"
      , arabic = "موزة"
      , meaning = "a banana"
      }
    , { latin  = "2akl"
      , kana = "アクル"
      , arabic = "أَكْل"
      , meaning = "food"
      }
    , { latin  = "2akl 3arabiyy wa-qahwa 3arabiyy"
      , kana = "アクル アラビーイ ワ カハワ アラビーイ"
      , arabic = "أَكْل عَرَبيّ وَقَهْوة عَرَبيّة"
      , meaning = "Arabic food and Arabic coffee"
      }
    , { latin  = "ruzz"
      , kana = "ルッズ"
      , arabic = "رُزّ"
      , meaning = "rice"
      }
    , { latin  = "ruzzii wa-qahwatii"
      , kana = "ルッズイー ワ カハワティー"
      , arabic = "رُزّي وَقَهْوَتي"
      , meaning = "my rice and my coffee"
      }
     , { latin  = "qahwatii fii shanTatii"
       , kana = "カハワティー フィー シャンタティー"
       , arabic = "قَهْوَتي في  شَنْطَتي"
       , meaning = "My coffee is in my bag"
       }
     , { latin  = "qahwa siith"
       , kana = "カハワ スィース"
       , arabic = "قَهْوَة  سيث"
       , meaning = "Seth's coffee"
       }
    , { latin  = "Sadiiqathaa"
      , kana = "サディーカトハー"
      , arabic = "صَديقَتها"
      , meaning = "her friend"
      }
    , { latin  = "jaarat-haa"
      , kana = "ジャーラト ハー"
      , arabic = "جارَتها"
      , meaning = "her neighbor"
      }
    , { latin  = "2ukhtii"
      , kana = "ウクフティ"
      , arabic = "أُخْتي"
      , meaning = "my sister"
      }
    , { latin  = "Sadiiqa jayyida"
      , kana = "サディーカ ジャイイダ"
      , arabic = "صَديقة  جَيِّدة"
      , meaning = "a good friend"
      }أ
     , { latin  = "2a3rif"
       , arabic = "أَعْرِف"
       , meaning = "I know"
       }
    , { latin  = "2anaa 2a3rifhu"
      , kana = "アナー アーリフフ"
      , arabic = "أَنا أَعْرِفه"
      , meaning = "I know him"
      }
    , { latin  = "Taawila Tawiila"
      , kana = "ターウィラ タウィーラ"
      , arabic = "طاوِلة طَويلة"
      , meaning = "a long table"
      }
    , { latin  = "baytik wa-bayt-haa"
      , kana = "バイティク ワ バイトハー"
      , arabic = "بَيْتِك وَبَيْتها"
      , meaning = "your house and her house"
      }
    , { latin  = "ism Tawiil"
      , kana = "イスム タウィール"
      , arabic = "اِسْم طَويل"
      , meaning = "long name"
      }
    , { latin  = "baytii wa-baythaa"
      , kana = "バイティー ワ バイトハー"
      , arabic = "بَيْتي وَبَيْتها"
      , meaning = "my house and her house"
      }
    , { latin  = "laysa hunaak lugha Sa3ba"
      , kana = "ライサ フナーク ルガ サアバ"
      , arabic = "لَيْسَ هُناك لُغة صَعْبة"
      , meaning = "There is no diffcult language."
      }
    , { latin  = "hadhaa shay2 Sa3b"
      , kana = "ハーザー シャイ サアバ"
      , arabic = "هَذا شَيْء صَعْب"
      , meaning = "This is a difficult thing."
      }
    , { latin  = "ismhu taamir"
      , kana = "イスムフ ターミル"
      , arabic = "اِسْمهُ تامِر"
      , meaning = "His name is Tamer."
      }
    , { latin  = "laa 2a3rif 2ayn bayt-hu"
      , kana = "ラー アーリフ アイン バイトフ"
      , arabic = "لا أَعْرِف أَيْن بَيْته"
      , meaning = "I don't know where his house is"
      }
    , { latin  = "laa 2a3rif 2ayn 2anaa"
      , kana = "ラー アーリフ アイン アナー"
      , arabic = "لا أعرف أين أنا."
      , meaning = "I don't know where I am."
      }
    , { latin  = "bayt-hu qariib min al-jaami3a"
      , kana = "バイトフ カリーブ ミン アル ジャーミア"
      , arabic = "بيته قريب من الجامعة"
      , meaning = "His house is close to the university"
      }
    , { latin  = "ismhaa arabiyy"
      , kana = "イスムハー アラビーイ"
      , arabic = "إسمها عربي"
      , meaning = "Her name is arabic."
      }
    , { latin  = "riim Sadiiqa Sa3ba"
      , kana = "リーム サディーカ サアバ"
      , arabic = "ريم صديقة صعبة"
      , meaning = "Reem is a difficult friend."
      }      
    , { latin  = "ismhu bashiir"
      , kana = "イスムフ バシール"
      , arabic = "إسمه بشير"
      , meaning = "HIs name is Bashir."
      }      
    , { latin  = "ismhaa Tawiil"
      , kana = "イスムハー タウィール"
      , arabic = "إسمها طويل"
      , meaning = "Her name is long."
      }      
    , { latin  = "Sadiiqhaa buub qariib min baythaa"
      , kana = "サディークハー ブーブ カリーブ ミン バイトハー"
      , arabic = "صديقها بوب قريب من بيتها"
      , meaning = "Her friend Bob is close to her house."
      } 
    , { latin  = "ismhu buub"
      , kana = "イスムフ ブーブ"
      , arabic = "إسمه بوب"
      , meaning = "His name is Bob."
      }
    , { latin  = "baythu qariib min baythaa"
      , kana = "バイトフ カリーブ ミン バイトハー"
      , arabic = "بيته قريب من بيتها"
      , meaning = "His house is close to her house."
      }
    , { latin  = "hadhaa shay2 Sa3b"
      , kana = "ハーザー シャイ サアブ"
      , arabic = "هذا شيء صعب"
      , meaning = "This is a difficult thing."
      }
    , { latin  = "3alaaqa"
      , kana = "アラーカ"
      , arabic = "عَلاقَة"
      , meaning = "relationship"
      }
    , { latin  = "al-qiTTa"
      , kana = "アルキッタ"
      , arabic = "اَلْقِطّة"
      , meaning = "the cat"
      }
    , { latin  = "laa 2uhib"
      , kana = "ラー ウヒッブ"
      , arabic = "لا أُحِب"
      , meaning = "I do not like"
      }
    , { latin  = "al-2akl mumti3"
      , kana = "アルアクル ムムティア"
      , arabic = "اَلْأَكْل مُمْتع"
      , meaning = "Eating is fun."
      }
    , { latin  = "al-qiraa2a"
      , kana = "アルキラーエ"
      , arabic = "اَلْقِراءة"
      , meaning = "reading"
      }
    , { latin  = "alkitaaba"
      , kana = "アルキターバ"
      , arabic = "الْكِتابة"
      , meaning = "writing"
      }
    , { latin  = "alkiraa2a wa-alkitaaba"
      , kana = "アルキラーエ ワ アルキターバ"
      , arabic = "اَلْقِراءة وَالْكِتابة"
      , meaning = "reading and writing"
      }
    , { latin  = "muhimm"
      , kana = "ムヒンム"
      , arabic = "مُهِمّ"
      , meaning = "important"
      }
    , { latin  = "alkiaaba shay2 muhimm"
      , kana = "アルキターバ シャイ ムヒンム"
      , arabic = "اَلْكِتابة شَيْء مُهِمّ"
      , meaning = "Writing is an important thing."
      }
    , { latin  = "al-jaara wa-al-qiTTa"
      , kana = "アル ジャーラ ワ アル キッタ"
      , arabic = "اَلْجارة وَالْقِطّة"
      , meaning = "the neighbor and the cat"
      }
    , { latin  = "qiTTa wa-alqiTTa"
      , kana = "キッタ ワ アルキッタ"
      , arabic = "قِطّة وَالْقِطّة"
      , meaning = "a cat and the cat"
      }
    , { latin  = "2ayDaan"
      , kana = "アイダン"
      , arabic = "أَيْضاً"
      , meaning = "also"
      }
    , { latin  = "almaT3m"
      , kana = "アルマタム"
      , arabic = "الْمَطْعْم"
      , meaning = "the restaurant"
      }
    , { latin  = "maa2"
      , kana = "マー"
      , arabic = "ماء"
      , meaning = "water"
      }
    , { latin  = "maT3am"
      , kana = "マタム"
      , arabic = "مَطْعَم"
      , meaning = "a restaurant"
      }
    , { latin  = "a-t-taSwiir"
      , kana = "アッタスウィール"
      , arabic = "اَلْتَّصْوير"
      , meaning = "photography"
      }
    , { latin  = "a-n-nawm"
      , kana = "アンナウム"
      , arabic = "اَلْنَّوْم"
      , meaning = "sleeping, sleep"
      }
    , { latin  = "a-s-sibaaha"
      , kana = "アッスィバーハ"
      , arabic = "اَلْسِّباحة"
      , meaning = "swimming"
      }
    , { latin  = "Sabaahan 2uhibb al-2akl hunaa"
      , kana = "サバーハン ウヒッブ アルアクル フナー"
      , arabic = "صَباحاً أُحِبّ اَلْأَكْل هُنا"
      , meaning = "In the morning, I like eating here."
      }
    , { latin  = "kathiiraan"
      , kana = "カシーラン"
      , arabic = "كَثيراً"
      , meaning = "much"
      }
    , { latin  = "hunaa"
      , kana = "フナー"
      , arabic = "هُنا"
      , meaning = "here"
      }
    , { latin  = "jiddan"
      , kana = "ジッダン"
      , arabic = "جِدَّاً"
      , meaning = "very"
      }
    , { latin  = "3an"
      , kana = "アン"
      , arabic = "عَن"
      , meaning = "about"
      }      
    , { latin  = "2uhibb a-s-safar 2ilaa 2iiTaaliyaa"
      , kana = "ウヒッブ アッサファル いらー イーターリヤー"
      , arabic = "أُحِبّ اَلْسَّفَر إِلى إيطالْيا"
      , meaning = "I like traveling to Italy."
      }      
    , { latin  = "al-kalaam ma3a 2abii"
      , kana = "アルカラーム マア アビー"
      , arabic = "اَلْكَلام مَعَ أَبي"
      , meaning = "talking with my father"
      }      
    , { latin  = "2uHibb aljarii bi-l-layl"
      , kana = "ウヒッブ アルジャリー ビッライル"
      , arabic = "أُحِبّ اَلْجَري بِالْلَّيْل"
      , meaning = "I like running at night."
      }
    , { latin  = "2uriidu"
      , kana = "ウリード"
      , arabic = "أُريدُ"
      , meaning = "I want"
      }
    , { latin  = "2uHibb 2iiTaaliyaa 2ayDan"
      , kana = "ウヒッブ イーターリヤー アイダン"
      , arabic = "أُحِبّ إيطاليا أَيْضاً"
      , meaning = "I like Italy also."
      }
    , { latin  = "2uHibb alqiraa2a 3an kuubaa bi-l-layl"
      , kana = "ウヒッブ アルキラーア アン クーバー ビッライル"
      , arabic = "أُحِبّ اَلْقِراءة عَن كوبا بِالْلَّيْل"
      , meaning = "I like reading about Cuba at night."
      }
    , { latin  = "2uHibb al-kalaam 3an il-kitaaba"
      , kana = "ウヒッブ アル カラーム アニル キターバ"
      , arabic = "أحِبّ اَلْكَلام عَن اَلْكِتابة"
      , meaning = "I like talking about writing."
      }
    , { latin  = "alqur2aan"
      , kana = "アルクルアーン"
      , arabic = "اَلْقُرْآن"
      , meaning = "Koran"
      }
    , { latin  = "bayt jamiil"
      , kana = "バイト ジャミール"
      , arabic = "بَيْت جَميل"
      , meaning = "a pretty house"
      }
    , { latin  = "mutarjim mumtaaz"
      , kana = "ムタルジム ムムターズ"
      , arabic = "مُتَرْجِم مُمْتاز"
      , meaning = "an amazing translator"
    }
    , { latin  = "jaami3a mash-huura"
      , kana = "ジャーミア マシュフーラ"
      , arabic = "جامِعة مَشْهورة"
      , meaning = "a famous university"
      }
    , { latin  = "al-bayt al-jamiil"
      , kana = "アルバイト アルジャミール"
      , arabic = "اَلْبَيْت اَلْجَميل"
      , meaning = "the pretty house"
      }
    , { latin  = "al-bint a-s-suuriyya"
      , kana = "アル ビンタ ッスーリヤ"
      , arabic = "اَلْبِنْت اَلْسّورِيّة"
      , meaning = "a Syrian girl"
      }
    , { latin  = "al-mutarjim al-mumtaaz"
      , kana = "アルムタルジム アルムムターズ"
      , arabic = "اَلْمُتَرْجِم اَلْمُمْتاز"
      , meaning = "the amazing translator"
      }
    , { latin  = "al-jaami3a al-mash-huura"
      , kana = "アルジャーミア アルマシュフーラ"
      , arabic = "اَلْجامِعة اَلْمَشْهورة"
      , meaning = "the famous university"
      }
    , { latin  = "al-bayt jamiil"
      , kana = "アルバイト ジャミール"
      , arabic = "اَلْبَيْت جَميل"
      , meaning = "The house is pretty."
      }
    , { latin  = "al-bint suuriyya"
      , kana = "アルビント スーリーヤ"
      , arabic = "البنت سورِيّة"
      , meaning = "The girl is Syrian."
      }
    , { latin  = "al-mutarjim mumtaaz"
      , kana = "アルムタルジム ムムターズ"
      , arabic = "اَلْمُتَرْجِم مُمْتاز"
      , meaning = "The translator is amazing."
      }
    , { latin  = "al-jaami3a mash-huura"
      , kana = "アルジャーミア マシュフーラ"
      , arabic = "اَلْجامِعة مَشْهورة"
      , meaning = "The university is famous."
      }
    , { latin  = "maTar"
      , kana = "マタル"
      , arabic = "مَطَر"
      , meaning = "rain"
      }
    , { latin  = "yawm Tawiil"
      , kana = "ヤウム タウィール"
      , arabic = "يَوْم طَويل"
      , meaning = "a long day"
      }
    , { latin  = "haadhaa yawm Tawiil"
      , kana = "ハーザー ヤウム タウィール"
      , arabic = "هَذا يَوْم طَويل"
      , meaning = "This is a long day."
      }
    , { latin  = "shanTa fafiifa"
      , kana = "シャンタ ファフィーファ"
      , arabic = "شَنْطة خَفيفة"
      , meaning = "a light bag"
      }
    , { latin  = "al-maTar a-th-thaqiil mumtaaz"
      , kana = "アルマタル アッサキール ムムターズ"
      , arabic = "اَلْمَطَر اَلْثَّقيل مُمْتاز"
      , meaning = "The heavy rain is amazing."
      }
    , { latin  = "Taqs ghariib"
      , kana = "タクス ガリーブ"
      , arabic = "طَقْس غَريب"
      , meaning = "a weird weather"
      }
    , { latin  = "yawm Haarr"
      , kana = "ヤウム ハール"
      , arabic = "يَوْم حارّ"
      , meaning = "a hot day"
      }
    , { latin  = "Taawila khafiifa"
      , kana = "ターウィラ クハフィーファ"
      , arabic = "طاوِلة خَفيفة"
      , meaning = "a light table"
      }
    , { latin  = "Taqs jamiil"
      , kana = "タクス ジャミール"
      , arabic = "طَقْس جَميل"
      , meaning = "a pretty weather"
      }
    , { latin  = "al-maTar a-th-thaqiil mumtaaz"
      , kana = "アルマタル アッサキール ムムターズ"
      , arabic = "اَلْمَطَر اَلْثَّقيل مُمْتاز"
      , meaning = "The heavy rain is amazing."
      }
    , { latin  = "haadhaa yawm Haarr"
      , kana = "ハーザー ヤウム ハール"
      , arabic = "هَذا يَوْم حارّ"
      , meaning = "This is a hot day."
      }
    , { latin  = "shanTa khafiifa"
      , kana = "シャンタ クハフィーファ"
      , arabic = "شَنْطة خَفيفة"
      , meaning = "a light bag"
      }
    , { latin  = "hunaak maTar baarid jiddan"
      , kana = "フナーク マタル バーリド ジッダン"
      , arabic = "هُناك مَطَر بارِد جِدّاً"
      , meaning = "There is a very cold rain."
      }
    , { latin  = "Sayf"
      , kana = "サイフ"
      , arabic = "صّيْف"
      , meaning = "summer"
      }
    , { latin  = "shitaa2"
      , kana = "シター"
      , arabic = "شِتاء"
      , meaning = "winter"
      }
    , { latin  = "shitaa2 baarid"
      , kana = "シター バーリド"
      , arabic = "شِتاء بارِد"
      , meaning = "cold winter"
      }
    , { latin  = "binaaya 3aalya"
      , kana = "ビナーヤ アーリヤ"
      , arabic = "بِناية عالْية"
      , meaning = "a high building"
      }
    , { latin  = "yawm baarid"
      , kana = "ヤウム バーリド"
      , arabic = "يَوْم بارِد"
      , meaning = "a cold day"
      }
    , { latin  = "ruTuuba 3aalya"
      , kana = "ルトゥーバ アーリヤ"
      , arabic = "رُطوبة عالْية"
      , meaning = "high humidity"
      }
    , { latin  = "Sayf mumTir"
      , kana = "サイフ ムムティル"
      , arabic = "صَيْف مُمْطِر"
      , meaning = "a rainy summer"
      }
    , { latin  = "a-r-ruTuubat al3aalya"
      , kana = "アッルルトゥーバト アラーリヤ"
      , arabic = "اَلْرُّطوبة الْعالْية"
      , meaning = "the high humidity"
      }
    , { latin  = "a-T-Taqs al-mushmis"
      , kana = "アッタクス アルムシュミス"
      , arabic = "اّلْطَّقْس الّْمُشْمِس"
      , meaning = "the sunny weather"
      }
    , { latin  = "shitaa2 mumTir"
      , kana = "シター ムムティル"
      , arabic = "شِتاء مُمْطِر"
      , meaning = "a rainy winter"
      }      
    , { latin  = "Sayf Haarr"
      , kana = "サイフ ハール"
      , arabic = "صَيْف حارّ"
      , meaning = "a hot summer"
      }      
    , { latin  = "al-yawm yawm Tawiil"
      , kana = "アルヤウム ヤウム タウィール"
      , arabic = "اَلْيَوْم يَوْم طَويل"
      , meaning = "Today is a long day."
      }      
    , { latin  = "laa 2uhibb a-T-Taqs al-mushmis"
      , kana = "ラー ウヒッブ アッタクス アルムシュミス"
      , arabic = "لا أُحِبّ اَلْطَقْس اَلْمُشْمِس"
      , meaning = "I do not like sunny weather."
      }      
    , { latin  = "a-T-Taqs mumTir jiddan al-yawm"
      , kana = "アッタクス ムムティル ジッダン アルヤウム"
      , arabic = "اَلْطَقْس مُمْطِر جِدّاً اَلْيَوْم"
      , meaning = "The weather is very rainy today."
      }
    , { latin  = "laa 2uhibb a-T-Taqs al-mumTir"
      , kana = "ラー ウヒッブ アッタクス アルムティル"
      , arabic = "لا أحِبّ اَلْطَّقْس اَلْمُمْطِر"
      , meaning = "I do not like the rainy weather."
      }
    , { latin  = "a-T-Taqs mushmis al-yawm"
      , kana = "アッタクス ムシュミス アルヤウム"
      , arabic = "اَلْطَّقْس مُشْمِس اَلْيَوْم"
      , meaning = "The weather is sunny today."
      }
    , { latin  = "khariif"
      , kana = "ハリーフ"
      , arabic = "خَريف"
      , meaning = "fall, autumn"
      }
    , { latin  = "qamar"
      , kana = "カマル"
      , arabic = "قَمَر"
      , meaning = "moon"
      }
    , { latin  = "rabii3"
      , kana = "ラビーア"
      , arabic = "رَبيع"
      , meaning = "spring"
      }
    , { latin  = "a-sh-shitaa2 mumTir"
      , kana = "アッシター ムムティル"
      , arabic = "اَلْشِّتاء مُمْطِر"
      , meaning = "The winter is rainy."
      }
    , { latin  = "a-S-Sayf al-baarid"
      , kana = "アッサイフ アルバーリド"
      , arabic = "اَلْصَّيْف اَلْبارِد"
      , meaning = "the cold summer"
      }
    , { latin  = "al-qamar al-2abyaD"
      , kana = "アルカマル アルアビヤド"
      , arabic = "اَلْقَمَر اَلْأَبْيَض"
      , meaning = "the white moon"
      }
    , { latin  = "a-sh-shitaa2 Tawiil wa-baarid"
      , kana = "アッシター タウィール ワ バーリド"
      , arabic = "اَلْشِّتاء طَويل وَبارِد"
      , meaning = "The winter is long and cold."
      }
    , { latin  = "a-r-rabii3 mumTir al-2aan"
      , kana = "アッラビーア ムムティル アルアーン"
      , arabic = "اَلْرَّبيع مُمْطِر اَلآن"
      , meaning = "The spring is rainy now"
      }
    , { latin  = "Saghiir"
      , kana = "サギール"
      , arabic = "صَغير"
      , meaning = "small"
      }
    , { latin  = "kashiiran"
      , kana = "カシーラン"
      , arabic = "كَثيراً"
      , meaning = "a lot, much"
      }
    , { latin  = "a-S-Siin"
      , kana = "アッスィーン"
      , arabic = "اَلْصّين"
      , meaning = "China"
      }
    , { latin  = "al-qaahira"
      , kana = "アル カーヒラ"
      , arabic = "اَلْقاهِرة"
      , meaning = "Cairo"
      }
    , { latin  = "al-bunduqiyya"
      , kana = "アル ブンドゥキーヤ"
      , arabic = "اَلْبُنْدُقِية"
      , meaning = "Venice"
      }
    , { latin  = "filasTiin"
      , kana = "フィラスティーン"
      , arabic = "فِلَسْطين"
      , meaning = "Palestine"
      }
    , { latin  = "huulandaa"
      , kana = "フーランダー"
      , arabic = "هولَنْدا"
      , meaning = "Netherlands, Holland"
      }
    , { latin  = "baghdaad"
      , kana = "バグダード"
      , arabic = "بَغْداد"
      , meaning = "Bagdad"
      }
    , { latin  = "Tuukyuu"
      , kana = "トーキョー"
      , arabic = "طوكْيو"
      , meaning = "Tokyo"
      }
    , { latin  = "al-yaman"
      , kana = "アル ヤマン"
      , arabic = "اَلْيَمَن"
      , meaning = "Yemen"
      }
    , { latin  = "SaaHil Tawiil"
      , kana = "サーヒル タウィール"
      , arabic = "ساحَل طَويل"
      , meaning = "a long coast"
      }
    , { latin  = "al-2urdun"
      , kana = "アル ウルドゥン"
      , arabic = "اَلْأُرْدُن"
      , meaning = "Jordan"
      }      
    , { latin  = "haadha l-balad"
      , kana = "ハーザ ル バラド"
      , arabic = "هَذا الْبَلَد"
      , meaning = "this country"
      }      
    , { latin  = "2ayn baladik yaa riim"
      , kana = "アイン バラディク ヤー リーム"
      , arabic = "أَيْن بَلَدِك يا ريم"
      , meaning = "Where is your country, Reem?"
      }      
    , { latin  = "baladii mumtaaz"
      , kana = "バラディー ムムターズ"
      , arabic = "بَلَدي مُمْتاز"
      , meaning = "My country is amazing."
      }      
    , { latin  = "haadhaa balad-haa"
      , kana = "ハーザー バラドハー"
      , arabic = "هَذا بَلَدها"
      , meaning = "This is her country."
      }      
    , { latin  = "hal baladak jamiil yaa juurj?"
      , kana = "ハル バラダク ジャミール ヤー ジュールジュ"
      , arabic = "هَل بَلَدَك جَميل يا جورْج"
      , meaning = "Is your country pretty, George"
      }
    , { latin  = "al-yaman balad Saghiir"
      , kana = "アルヤマン バラド サギール"
      , arabic = "اَلْيَمَن بَلَد صَغير"
      , meaning = "Yemen is a small country."
      }
    , { latin  = "qaari2"
      , kana = "カーリー"
      , arabic = "قارِئ"
      , meaning = "reader"
      }
    , { latin  = "ghaa2ib"
      , kana = "ガーイブ"
      , arabic = "غائِب"
      , meaning = "absent"
      }
    , { latin  = "mas2uul"
      , kana = "マスウール"
      , arabic = "مَسْؤول"
      , meaning = "responsoble, administrator"
      }
    , { latin  = "jaa2at"
      , kana = "ジャーアト"
      , arabic = "جاءَت"
      , meaning = "she came"
      }
    , { latin  = "3indii"
      , kana = "アインディー"
      , arabic = "عِنْدي"
      , meaning = "I have"
      }
    , { latin  = "3indik"
      , kana = "アインディク"
      , arabic = "عِنْدِك"
      , meaning = "you have"
      }
    , { latin  = "ladii kitaab"
      , kana = "ラディー キターブ"
      , arabic = "لَدي كِتاب"
      , meaning = "I have a book."
      }
    , { latin  = "3indhaa"
      , kana = "アインドハー"
      , arabic = "عِنْدها"
      , meaning = "she has"
      }      
    , { latin  = "3indhu"
      , kana = "アインドフ"
      , arabic = "عِنْدهُ"
      , meaning = "he has"
      }      
    , { latin  = "laysa 3indhu"
      , kana = "ライサ アインドフ"
      , arabic = "لَيْسَ عِنْدهُ"
      , meaning = "he does not have"
      }      
    , { latin  = "laysa 3indhaa"
      , kana = "ライサ アインドハー"
      , arabic = "لَيْسَ عِنْدها"
      , meaning = "she does not have"
      }      
    , { latin  = "hunaak maTar thaqiil"
      , kana = "フナーク マタル サキール"
      , arabic = "هُناك مَطَر ثَقيل"
      , meaning = "There is a heavy rain."
      }
    , { latin  = "hunaak wishaaH fii shanTatii"
      , kana = "フナーク ウィシャーハ フィー シャンタティー"
      , arabic = "هُناك وِشاح في شَنْطتي"
      , meaning = "There is a scarf in my bag."
      }
    , { latin  = "2amaamii rajul ghariib"
      , kana = "アマーマミー ラジュル ガリーブ"
      , arabic = "أَمامي رَجُل غَريب"
      , meaning = "There is a weird man in front of me."
      }
    , { latin  = "fi l-khalfiyya bayt"
      , kana = "フィル クハルフィーヤ バイト"
      , arabic = "في الْخَلفِيْة بَيْت"
      , meaning = "There is a house in the background."
      }      
    , { latin  = "fii shanTatii wishaaH"
      , kana = "フィー シャンタティー ウィシャーハ"
      , arabic = "في شَنْطَتي وِشاح"
      , meaning = "There is a scarf in my bag."
      }
    , { latin  = "2asad"
      , kana = "アサド"
      , arabic = "أَسَد"
      , meaning = "a lion"
      }
    , { latin  = "2uHibb 2asadii laakinn laa 2uHibb 2asadhaa"
      , kana = "ウヒッブ アサディ ラキン ラー ウヒッブ アサドハー"
      , arabic = "أحِبَ أَسَدي لَكِنّ لا أُحِبّ أَسَدها"
      , meaning = "I like my lion but I do not like her lion."
      }
    , { latin  = "laysa 3indhu"
      , kana = "ライサ アインドフ"
      , arabic = "لَيْسَ عِنْدهُ"
      , meaning = "he does not have"
      }
    , { latin  = "3indhaa kalb wa-qiTTa"
      , kana = "アインドハー カルブ ワ キッタ"
      , arabic = "عِنْدها كَلْب وَقِطّة"
      , meaning = "She has a doc and a cat."
      }
    , { latin  = "Sadiiqathu saamia ghaniyya"
      , kana = "サディーカトフ サーミヤ ガニーヤ"
      , arabic = "صَديقَتهُ سامْية غَنِيّة"
      , meaning = "His friend Samia is rich."
      }
    , { latin  = "taariikhiyya"
      , kana = "ターリークヒーヤ"
      , arabic = "تاريخِيّة"
      , meaning = "historical"
      }
    , { latin  = "juurj 3indhu 3amal mumtaaz"
      , kana = "ジュールジュ アインドフ アアマル ムムターズ"
      , arabic = "جورْج عِنْدهُ عَمَل مُمْتاز"
      , meaning = "George has an amazing work."
      }
    , { latin  = "Sadiiqii taamir ghaniyy jiddan"
      , kana = "サディーキー ターミル ガニーイ ジッダン"
      , arabic = "صَديقي تامِر غَنِيّ جِدّاً"
      , meaning = "My friend Tamer is very rich"
      }
    , { latin  = "laa 2a3rif haadha l-2asad"
      , kana = "ラー アーリフ ハーザ ル アサド"
      , arabic = "لا أَعْرِف هَذا الْأَسّد"
      , meaning = "I do not know this lion."
      }
    , { latin  = "laysa 3indhu ma3Taf"
      , kana = "ライサ アインドフ マアタフ"
      , arabic = "لَيْسَ عِنْدهُ معْطَف"
      , meaning = "He does not have a coat."
      }
    , { latin  = "fi l-khalfiyya zawjatak yaa siith"
      , kana = "フィ ル クハルフィーヤ ザウジャタク ヤー スィース"
      , arabic = "في الْخَلْفِيّة زَوْجَتَك يا سيث"
      , meaning = "There is your wife in background, Seth"
      }
    , { latin  = "su2uaal"
      , kana = "スウアール"
      , arabic = "سُؤال"
      , meaning = "a question"
      }
    , { latin  = "Sadiiqat-hu saamya laabisa tannuura"
      , kana = "サディーカトフ サーミヤ ラービサ タンヌーラ"
      , arabic = "صدَيقَتهُ سامْية لابِسة تّنّورة"
      , meaning = "His friend Samia is wearing a skirt."
      }
    , { latin  = "wa-hunaa fi l-khalfiyya rajul muD-Hik"
      , kana = "ワ フナー フィル クハルフィーヤ ラジュル ムドヒク"
      , arabic = "وَهُنا في الْخَلْفِتّة رَجُل مُضْحِك"
      , meaning = "And here in the background there is a funny man."
      }
    , { latin  = "man haadhaa"
      , kana = "マン ハーザー"
      , arabic = "مَن هَذا"
      , meaning = "Who is this?"
      }
    , { latin  = "hal 2anti labisa wishaaH yaa lamaa"
      , kana = "ハル アンティ ラビサ ウィシャーハ ヤー ラマー"
      , arabic = "هَل أَنْتِ لابِسة وِشاح يا لَمى"
      , meaning = "Are you wering a scarf, Lama?"
      }
    , { latin  = "2akhii bashiir mashghuul"
      , kana = "アクヒー バシール マシュグール"
      , arabic = "أَخي بَشير مَشْغول"
      , meaning = "My brother Bashir is busy."
      }
    , { latin  = "fii haadhihi a-S-Suura imraa muD-Hika"
      , kana = "フィー ハージヒ アッスーラ イムラア ムドヒカ"
      , arabic = "في هَذِهِ الْصّورة اِمْرأة مُضْحِكة"
      , meaning = "Thre is a funny woman in this picture."
      }
    , { latin  = "hal 2anta laabis qubb3a yaa siith"
      , kana = "ハル アンタ ラービス クッバ ヤー スィース"
      , arabic = "هَل أَنْتَ لابِس قُبَّعة يا سيث"
      , meaning = "Are you wearing a hat, Seth?"
      }
    , { latin  = "fi l-khalfiyya rajul muD-Hik"
      , kana = "フィル クハルフィーヤ ラジュル ムドヒク"
      , arabic = "في الْخَلْفِيّة رَجُل مُضْحِك"
      , meaning = "There is a funny man in the background."
      }
    , { latin  = "shub-baak"
      , kana = "シュッバーク"
      , arabic = "شُبّاك"
      , meaning = "a window"
      }
    , { latin  = "sariir"
      , kana = "サリール"
      , arabic = "سَرير"
      , meaning = "a bed"
      }
    , { latin  = "saadii 2ustaadhii"
      , kana = "サーディー ウスタージー"
      , arabic = "شادي أُسْتاذي"
      , meaning = "Sadie is my teacher."
      }
    , { latin  = "2ummhu"
      , kana = "ウンムフ"
      , arabic = "أُمّهُ"
      , meaning = "his mother"
      }
    , { latin  = "maa haadhaa a-S-Sawt"
      , kana = "マー ハーザー アッサウト"
      , arabic = "ما هَذا الْصَّوْت"
      , meaning = "What is this noise"
      }
    , { latin  = "2adkhul al-Hammaam"
      , kana = "アドクフル アルハンマーム"
      , arabic = "أَدْخُل اَلْحَمّام"
      , meaning = "I enter the bathroom."
      }
    , { latin  = "2uHibb a-s-sariir al-kabiir"
      , kana = "ウヒッブ アッサリール アルカビール"
      , arabic = "أُحِبّ اَلْسَّرير اَلْكَبير"
      , meaning = "I love the big bed."
      }
    , { latin  = "hunaak Sawt ghariib fi l-maTbakh"
      , kana = "フナーク サウト ガリーブ フィル マトバクフ"
      , arabic = "هُناك صَوْت غَريب في الْمَطْبَخ"
      , meaning = "There is a weird nose in the kitchen."
      }
    , { latin  = "2anaam fi l-ghurfa"
      , kana = "アナーム フィル グルファ"
      , arabic = "أَنام في الْغُرْفة"
      , meaning = "I sleep in the room."
      }
    , { latin  = "tilfaaz Saghiir fii Saaluun kabiir"
      , kana = "ティルファーズ サギール フィー サールーン カビール"
      , arabic = "تِلْفاز صَغير في صالون كَبير"
      , meaning = "a small television in a big living room"
      }
    , { latin  = "2anaam fii sariir maksuur"
      , kana = "アナーム フィー サリール マクスール"
      , arabic = "أَنام في سَرير مَكْسور"
      , meaning = "I sleep in a broken bed."
      }
    , { latin  = "a-s-sariir al-kabiir"
      , kana = "アッサリール アルカビール"
      , arabic = "اَلْسَّرير اَلْكَبير"
      , meaning = "the big bed"
      }
    , { latin  = "maa haadhaa a-S-Swut"
      , kana = "マー ハーザー アッスウト"
      , arabic = "ما هَذا الصّوُت"
      , meaning = "What is this noise?"
      }
    , { latin  = "sariirii mumtaaz al-Hamdu li-l-laa"
      , kana = "サリーリー ムムターズ アルハムド リッラー"
      , arabic = "سَريري مُمتاز اَلْحَمْدُ لِله"
      , meaning = "My bed is amazing, praise be to God"
      }
    , { latin  = "2anaam kathiiran"
      , kana = "アナーム カシーラン"
      , arabic = "أَنام كَشيراً"
      , meaning = "I sleep a lot"
      }
    , { latin  = "hunaak Sawt ghariib"
      , kana = "フナーク サウト ガリーブ"
      , arabic = "هُناك صَوْت غَريب"
      , meaning = "There is a weird noise."
      }
    , { latin  = "shub-baak"
      , kana = "シュッバーク"
      , arabic = "شُبّاك"
      , meaning = "a window"
      }
    , { latin  = "2anaam fii sariir Saghiir"
      , kana = "アナーム フィー サリール サギール"
      , arabic = "أَنام في سَرير صَغير"
      , meaning = "I sleep in a small bed."
      }
    , { latin  = "muHammad 2ustaadhii"
      , kana = "ムハンマド ウスタージー"
      , arabic = "مُحَمَّد أُسْتاذي"
      , meaning = "Mohammed is my teacher."
      }
    , { latin  = "mahaa 2ummhu"
      , kana = "マハー ウンムフ"
      , arabic = "مَها أُمّهُ"
      , meaning = "Maha is his mother."
      }
    , { latin  = "fii haadhaa sh-shaari3 Sawt ghariib"
      , kana = "フィー ハーザー ッシャーリア サウト ガリーブ"
      , arabic = "في هٰذا ٱلْشّارِع صَوْت غَريب"
      , meaning = "There is a weird noise on this street"
      }
    , { latin  = "2askun fii a-s-saaluun"
      , kana = "アスクン フィー アッサルーン"
      , arabic = "أَسْكُن في الْصّالون"
      , meaning = "I live in the living room."
      }
    , { latin  = "haadhaa sh-shaari3"
      , kana = "ハーザー ッシャーリア"
      , arabic = "هَذا الْشّارِع"
      , meaning = "this street"
      }
    , { latin  = "3ind-hu ghurfa nawm Saghiira"
      , kana = "アインドフ グルファ ナウム サギーラ"
      , arabic = "عِندهُ غُرْفة نَوْم صَغيرة"
      , meaning = "He has a small bedroom."
      }
    , { latin  = "laa 2aftaH albaab bisabab l-T-Taqs"
      , kana = "ラー アフタフ アルバーブ ビサバブ ルッタクス"
      , arabic = "لا أَفْتَح اَلْباب بِسَبَب اّلْطَّقْس"
      , meaning = "I do not open the door because of the weather."
      }
    , { latin  = "Sifr"
      , kana = "スィフル"
      , arabic = "صِفْر"
      , meaning = "zero"
      }
    , { latin  = "3ashara"
      , kana = "アシャラ"
      , arabic = "عَشَرَة"
      , meaning = "ten"
      }
    , { latin  = "waaHid"
      , kana = "ワーヒド"
      , arabic = "وَاحِد"
      , meaning = "one"
      }
    , { latin  = "2ithnaan"
      , kana = "イスナーン"
      , arabic = "اِثْنان"
      , meaning = "two"
      }
    , { latin  = "kayf ta3uddiin min waaHid 2ilaa sitta"
      , kana = "カイフ タアウッディーン ミン ワーヒド イラー スィッタ"
      , arabic = "كَيْف تَعُدّين مِن ١ إِلى ٦"
      , meaning = "How do you count from one to six?"
      }
    , { latin  = "bil-lugha"
      , kana = "ビッルガ"
      , arabic = "بِالْلُّغة"
      , meaning = "in language"
      }
    , { latin  = "bil-lugha l-3arabiya"
      , kana = "ビッルガルアラビーヤ"
      , arabic = "بِالْلُّغة الْعَرَبِيّة"
      , meaning = "in the arabic language"
      }
    , { latin  = "ta3rifiin"
      , kana = "ターリフィーン"
      , arabic = "تَعْرِفين"
      , meaning = "you know"
      }    
    , { latin  = "hal ta3rifiin kull shay2 yaa mahaa"
      , kana = "ハル ターリフィーン クル シャイ ヤー マハー"
      , arabic = "هَل تَعْرِفين كُلّ شَيء يا مَها"
      , meaning = "Do you know everything Maha?"
      }    
    , { latin  = "kayf ta3udd yaa 3umar"
      , kana = "カイフ タアウッド ヤ ウマル"
      , arabic = "كَيْف تَعُدّ يا عُمَر"
      , meaning = "How do you count Omar?"
      }
    , { latin  = "Kayf ta3udd min Sifr 2ilaa 2ashara yaa muHammad"
      , kana = "カイフ タアウッド ミン スィフル イラー アシャラ ヤー ムハンマド"
      , arabic = "كَيْف تَعُدّ مِن٠ إِلى ١٠ يا مُحَمَّد"
      , meaning = "How do you count from 0 to 10 , Mohammed?"
      }
    , { latin  = "hal ta3rif yaa siith"
      , kana = "ハル ターリフ ヤー スィース"
      , arabic = "هَل تَعْرِف يا سيث"
      , meaning = "Do you know Seth?"
      }
    , { latin  = "bayt buub"
      , kana = "バイト ブーブ"
      , arabic = "بَيْت بوب"
      , meaning = "Bob's house"
      }
    , { latin  = "maT3am muHammad"
      , kana = "マタム ムハンマド"
      , arabic = "مَطْعَم مُحَمَّد"
      , meaning = "Mohammed's restaurant"
      }
    , { latin  = "SaHiifat al-muhandis"
      , kana = "サヒーファト アル ムハンディス"
      , arabic = "صَحيفة اَلْمُهَنْدِس"
      , meaning = "the enginner's newspaper"
      }
    , { latin  = "madiinat diitruuyt"
      , kana = "マディーナト ディートルーイト"
      , arabic = "مَدينة ديتْرويْت"
      , meaning = "the city of Detroit"
      }
    , { latin  = "jaami3a juurj waashinTun"
      , kana = "ジャーミア ジュールジュ ワーシントン"
      , arabic = "جامِعة جورْج واشِنْطُن"
      , meaning = "George Washinton University"
      }
    , { latin  = "SabaaHan"
      , kana = "サバーハン"
      , arabic = "صَباحاً"
      , meaning = "in the morning"
      }
    , { latin  = "masaa2an"
      , kana = "マサーアン"
      , arabic = "مَساءً"
      , meaning = "in the evening"
      }
    , { latin  = "wilaayatak"
      , kana = "ウィラーヤタク"
      , arabic = "وِلايَتَك"
      , meaning = "your state"
      }
    , { latin  = "madiina saaHiliyya"
      , kana = "マディーナ サーヒリーヤ"
      , arabic = "مَدينة ساحِلِيّة"
      , meaning = "a coastal city"
      }
    , { latin  = "muzdaHima"
      , kana = "ムズダヒマ"
      , arabic = "مُزْدَحِمة"
      , meaning = "crowded"
      }
    , { latin  = "wilaaya kaaliifuurniyaa"
      , kana = "ウィラーヤ カーリーフールニヤー"
      , arabic = "وِلاية كاليفورْنْيا"
      , meaning = "the state of California"
      }
    , { latin  = "baHr"
      , kana = "バハル"
      , arabic = "بَحْر"
      , meaning = "sea"
      }
    , { latin  = "DawaaHii"
      , kana = "ダワーヒー"
      , arabic = "ضَواحي"
      , meaning = "suburbs"
      }
    , { latin  = "taskuniin"
      , kana = "タスクニーン"
      , arabic = "تَسْكُنين"
      , meaning = "you live"
      }
    , { latin  = "nyuuyuurk"
      , kana = "ニューユールク"
      , arabic = "نْيويورْك"
      , meaning = "New York"
      }
    , { latin  = "qar-yatik"
      , kana = "カルヤティク"
      , arabic = "قَرْيَتِك"
      , meaning = "your (to female) village"
      }
    , { latin  = "shubbaak"
      , kana = "シュッバーク"
      , arabic = "شُبّاك"
      , meaning = "a window"
      }
    , { latin  = "jaziira"
      , kana = "ジャズィーラ"
      , arabic = "جَزيرة"
      , meaning = "an island"
      }
    , { latin  = "Tabii3a"
      , kana = "タビーア"
      , arabic = "طَبيعة"
      , meaning = "nature"
      }
    , { latin  = "al-2iskandariyya"
      , kana = "アル イスカンダリーヤ"
      , arabic = "اَلْإِسْكَندَرِيّة"
      , meaning = "Alexandria"
      }
    , { latin  = "miSr"
      , kana = "ミスル"
      , arabic = "مِصْر"
      , meaning = "Egypt"
      }
    , { latin  = "na3am"
      , kana = "ナアム"
      , arabic = "نَعَم"
      , meaning = "yes"
      }
    , { latin  = "SabaaH l-khayr"
      , kana = "サバーフ ル クハイル"
      , arabic = "صَباح اَلْخَيْر"
      , meaning = "Good morning."
      }
    , { latin  = "SabaaH an-nuur"
      , kana = "サバーフ アン ヌール"
      , arabic = "صَباح اَلْنّور"
      , meaning = "Good morning."
      }
    , { latin  = "masaa2 al-khayr"
      , kana = "マサー アル クハイル"
      , arabic = "مَساء اَلْخَيْر"
      , meaning = "Good evening"
      }
    , { latin  = "masaa2 an-nuur"
      , kana = "マサー アンヌール"
      , arabic = "مَساء اَلْنّور"
      , meaning = "Good evening."
      }
    , { latin  = "tasharrafnaa"
      , kana = "タシャッラフナー"
      , arabic = "تَشَرَّفْنا"
      , meaning = "It's a pleasure to meet you."
      }
    , { latin  = "hal 2anta bi-khyr"
      , kana = "ハル アンタ ビ クハイル"
      , arabic = "هَل أَنْتَ بِخَيْر"
      , meaning = "Are you well?"
      }
    , { latin  = "kayfak"
      , kana = "カイファク"
      , arabic = "كَيْفَك"
      , meaning = "How are you?"
      }
    , { latin  = "al-yawm"
      , kana = "アル ヤウム"
      , arabic = "اَلْيَوْم"
      , meaning = "today"
      }
    , { latin  = "kayfik al-yawm"
      , kana = "カイフィク アル ヤウム"
      , arabic = "كَيْفِك اَلْيَوْم"
      , meaning = "How are you today?"
      }
    , { latin  = "marHaban ismii buub"
      , kana = "マルハバン イスミー ブーブ"
      , arabic = "مَرْحَباً اِسْمي بوب"
      , meaning = "Hello, my name is Bob."
      }
    , { latin  = "mariiD"
      , kana = "マリード"
      , arabic = "مَريض"
      , meaning = "sick"
      }
    , { latin  = "yawm sa3iid"
      , kana = "ヤウム サアイード"
      , arabic = "يَوْم سَعيد"
      , meaning = "Have a nice day."
      }
    , { latin  = "sa3iid"
      , kana = "サアイード"
      , arabic = "سَعيد"
      , meaning = "happy"
      }
    , { latin  = "2anaa Haziinat l-yawm"
      , kana = "アナー ハズィーナト ル ヤウム"
      , arabic = "أَنا حَزينة الْيَوْم"
      , meaning = "I am sad today."
      }
    , { latin  = "2anaa Haziin jiddan"
      , kana = "アナー ハズィーン ジッダン"
      , arabic = "أَنا حَزين جِدّاً"
      , meaning = "I am very sad."
      }
    , { latin  = "2anaa mariiDa lil2asaf"
      , kana = "アナー マリーダ リルアサフ"
      , arabic = "أَنا مَريضة لِلْأَسَف"
      , meaning = "I am sick unfortunately."
      }
    , { latin  = "2ilaa l-liqaa2 yaa Sadiiqii"
      , kana = "イラー ッリカー ヤー サディーキイ"
      , arabic = "إِلى الْلِّقاء يا صَديقي"
      , meaning = "Until next time, my friend."
      }
    , { latin  = "na3saana"
      , kana = "ナアサーナ"
      , arabic = "نَعْسانة"
      , meaning = "sleepy"
      }
    , { latin  = "mutaHammis"
      , kana = "ムタハムミス"
      , arabic = "مُتَحَمِّس"
      , meaning = "excited"
      }
    , { latin  = "maa smak"
      , kana = "マー スマク"
      , arabic = "ما إسْمَك"
      , meaning = "What is your name?"
      }
    , { latin  = "2anaa na3saan"
      , kana = "アナー ナアサーン"
      , arabic = "أَنا نَعْسان"
      , meaning = "I am sleepy."
      }
    , { latin  = "yal-laa 2ilaa l-liqaa2"
      , kana = "ヤッラー イラー ッリカー"
      , arabic = "يَلّإِ إِلى الْلَّقاء"
      , meaning = "Alright, until next time."
      }
    , { latin  = "ma3a as-salaama"
      , kana = "マア アッサラーマ"
      , arabic = "مَعَ الْسَّلامة"
      , meaning = "Goodbye."
      }
    , { latin  = "tamaam"
      , kana = "タマーム"
      , arabic = "تَمام"
      , meaning = "OK"
      }
    , { latin  = "2anaatamaam al-Hamdu li-l-laa"
      , kana = "アナ タマーム アル ハムドゥ リッラー"
      , arabic = "أَنا تَمام اَلْحَمْدُ لِله"
      , meaning = "I am OK , praise be to God."
      }
     , { latin  = "maa al2akhbaar"
       , arabic = "ما الْأَخْبار"
       , meaning = "What is new?"
       }
    , { latin  = "al-bathu alhii"
      , kana = "アル バス アルヒー"
      , arabic = "اَلْبَثُ اَلْحي"
      , meaning = "live broadcast"
      }
    , { latin  = "2ikhtar"
      , kana = "イクフタル"
      , arabic = "إِخْتَر"
      , meaning = "choose"
      }
    , { latin  = "sayyaara"
      , kana = "サイヤーラ"
      , arabic = "سَيّارة"
      , meaning = "a car"
      }
    , { latin  = "2akh ghariib"
      , kana = "アクフ ガリーブ"
      , arabic = "أَخ غَريب"
      , meaning = "a weird brother"
      }
    , { latin  = "2ukht muhimma"
      , kana = "ウクフト ムヒムマ"
      , arabic = "أُخْت مُهِمّة"
      , meaning = "an important sister"
      }
    , { latin  = "ibn kariim wa-mumtaaz"
      , kana = "イブン カリーム ワ ムムターズ"
      , arabic = "اِبْن كَريم وَمُمْتاز"
      , meaning = "a generous and amazing son"
      }
    , { latin  = "2ab"
      , kana = "アブ"
      , arabic = "أَب"
      , meaning = "a father"
      }      
    , { latin  = "2umm"
      , kana = "ウンム"
      , arabic = "أُمّ"
      , meaning = "a mother"
      }
    , { latin  = "ibn"
      , kana = "イブン"
      , arabic = "اِبْن"
      , meaning = "a son"
      }
    , { latin  = "mumti3"
      , kana = "ムムティア"
      , arabic = "مُمْتِع"
      , meaning = "fun"
      }
    , { latin  = "muHaasib"
      , kana = "ムハースィブ"
      , arabic = "مُحاسِب"
      , meaning = "an accountant"
      }
    , { latin  = "ma-smika ya 2ustaadha"
      , kana = "マスミカ ヤー ウスターザ"
      , arabic = "ما اسْمِك يا أُسْتاذة"
      , meaning = "What is your name ma'am?"
      }
    , { latin  = "qiTTatak malika"
      , kana = "キッタタク マリカ"
      , arabic = "قِطَّتَك مَلِكة"
      , meaning = "Your cat is a queen."
      }
    , { latin  = "jadda laTiifa wa-jadd laTiif"
      , kana = "ジャッダ ラティーファ ワ ジャッド ラティーフ"
      , arabic = "جَدّة لَطيفة وَجَدّ لَطيف"
      , meaning = "a kind grandmother and a kind grandfather"
      }
    , { latin  = "qiTTa jadiida"
      , kana = "キッタ ジャディーダ"
      , arabic = "قِطّة جَديدة"
      , meaning = "a new cat"
      }
    , { latin  = "hal jaddatak 2ustaadha"
      , kana = "ハル ジャーダタック ウスターザ"
      , arabic = "هَل جَدَّتَك أُسْتاذة"
      , meaning = "Is your grandmother a professor?"
      }
     , { latin  = "hal zawjatak 2urduniyya"
       , arabic = "هَل زَوْجَتَك أُرْدُنِتّة"
       , meaning = "Is your wife a Jordanian?"
       }
    , { latin  = "mu3allim"
      , kana = "ムアッリム"
      , arabic = "مُعَلِّم"
      , meaning = "a teacher"
      }
    , { latin  = "dhakiyya"
      , kana = "ザキーヤ"
      , arabic = "ذَكِيّة"
      , meaning = "smart"
      }
    , { latin  = "ma3Taf"
      , kana = "マアタフ"
      , arabic = "مَعْطَف"
      , meaning = "a coat"
      }
    , { latin  = "qubba3a zarqaa2 wa-bunniyya"
      , kana = "クッバ ザルカー ワ ブンニーヤ"
      , arabic = "قُبَّعة زَرْقاء وَبُنّية"
      , meaning = "a blue ad brown hat"
      }
    , { latin  = "bayDaa2"
      , kana = "バイダー"
      , arabic = "بَيْضاء"
      , meaning = "white"
      }
    , { latin  = "al-2iijaar jayyid al-Hamdu li-l-laa"
      , kana = "アル イージャール ジャイイド アル ハムドゥ リッラー"
      , arabic = "اَلْإِيجار جَيِّد اَلْحَمْدُ لِله"
      , meaning = "The rent is good, praise be to God."
      }
    , { latin  = "jaami3a ghaalya"
      , kana = "ジャーミア ガーリヤ"
      , arabic = "جامِعة غالْية"
      , meaning = "an expensive university"
      }
    , { latin  = "haadhaa Saaluun qadiim"
      , kana = "ハーザー サルーン カディーム"
      , arabic = "هَذا صالون قَديم"
      , meaning = "This is an old living room."
      }
    , { latin  = "haadhihi Hadiiqa 3arabiyya"
      , kana = "ハーディヒ ハディーカ アラビーヤ"
      , arabic = "هَذِهِ حَديقة عَرَبِيّة"
      , meaning = "This is an Arabian guarden."
      }
    , { latin  = "al-HaaiT"
      , kana = "アル ハーイト"
      , arabic = "اَلْحائِط"
      , meaning = "the wall"
      }
    , { latin  = "hunaak shanTa Saghiira"
      , kana = "フナーク シャンタ サギーラ"
      , arabic = "هُناك شَنطة صَغيرة"
      , meaning = "There is a small bag."
      }
    , { latin  = "2abii hunaak"
      , kana = "アビー フナーク"
      , arabic = "أَبي هُناك"
      , meaning = "My father is there."
      }
    , { latin  = "haatifak hunaak yaa buub"
      , kana = "ハーティファク フナーク ヤー ブーブ"
      , arabic = "هاتِفَك هُناك يا بوب"
      , meaning = "Your telephone is there, Bob."
      }
    , { latin  = "haatifii hunaak"
      , kana = "ハーティフィー フナーク"
      , arabic = "هاتِفي هُناك"
      , meaning = "My telephone is there."
      }
    , { latin  = "hunaak 3ilka wa-laab tuub fii shanTatik"
      , kana = "フナーク アイルカ ワ ラーブトゥーブ フィー シャンタティク"
      , arabic = "هُناك عِلكة وَلاب توب في شَنطَتِك"
      , meaning = "There is a chewing gum and a laptop in your bag."
      }
    , { latin  = "raSaaS"
      , kana = "ラサース"
      , arabic = "رَصاص"
      , meaning = "lead"
      }
    , { latin  = "qalam raSaaS"
      , kana = "カラム ラサース"
      , arabic = "قَلَم رَصاص"
      , meaning = "a pencil"
      }
    , { latin  = "mu2al-lif"
      , kana = "ムアッリフ"
      , arabic = "مُؤَلِّف"
      , meaning = "an author"
      }
    , { latin  = "shaahid al-bath-t il-Hayy"
      , kana = "シャーヒド アル バスト アル ハイイ"
      , arabic = "شاهد البث الحي"
      , meaning = "Watch the live braodcast"
      }
    , { latin  = "2a3iish"
      , kana = "アーイーシュ"
      , arabic = "أَعيش"
      , meaning = "I live"
      }
    , { latin  = "2a3iish fi l-yaabaan"
      , kana = "アーイーシュ フィ ル ヤーバーン"
      , arabic = "أَعيش في لايابان"
      , meaning = "I live in Japan."
      }
    , { latin  = "2anaa 2ismii faaTima"
      , kana = "アナー イスミー ファーティマ"
      , arabic = "أَنا إِسمي فاطِمة"
      , meaning = "My name is Fatima (female name)."
      }
     , { latin  = "2a3iish fii miSr"
      , kana = "アーイーシュ フィー ミスル"     
       , arabic = "أَعيش في مِصر"
       , meaning = "I live in Egypt."
       }
    , { latin  = "al3mr"
      , kana = "アラームル"
      , arabic = "العمر"
      , meaning = "age"
      }
    , { latin  = "2ukhtii wa-Sadiiqhaa juurj"
      , kana = "ウクフティー ワ サディークハー ジュールジュ"
      , arabic = "أُخْتي وَصَديقهل جورْج"
      , meaning = "my sister and her friend George"
      }
    , { latin  = "3amalii"
      , kana = "アアマリー"
      , arabic = "عَمَلي"
      , meaning = "my work"
      }
    , { latin  = "haadhihi Sadiiqat-hu saamiya"
      , kana = "ハージヒ サディーカトフ サーミア"
      , arabic = "هَذِهِ صَديقَتهُ سامية"
      , meaning = "This is his girlfriend Samia."
      }
    , { latin  = "shitaa2"
      , kana = "シター"
      , arabic = "شِتاء"
      , meaning = "winter"
      }
    , { latin  = "Sayf mumTil"
      , kana = "サイフ ムムティル"
      , arabic = "صَيْف مُمْطِر"
      , meaning = "a rainy summer"
      }
    , { latin  = "3aalya"
      , kana = "アーリヤ"
      , arabic = "عالْية"
      , meaning = "high"
      }
    , { latin  = "laa 2uHibb a-T-Taqs al mumTil"
      , kana = "ラー ウヒッブ アッタクス アル ムムティル"
      , arabic = "لا أُحِبّ اَلْطَّقْس اَلْمُمْطِر"
      , meaning = "I do not like rainy weather."
      }
    , { latin  = "Sayf Haarr Tawiil"
      , kana = "サイフ ハール タウィール"
      , arabic = "صَيْف حارّ طَويل"
      , meaning = "a long hot summer"
      }
    , { latin  = "ruTuuba 3aalya"
      , kana = "ルトゥーバ アーリヤ"
      , arabic = "رُطوبة عالية"
      , meaning = "high humidity"
      }      
    , { latin  = "a-r-rTuubat l-3aalya"
      , kana = "アルトゥーバト ルアーリヤ"
      , arabic = "اَلْرُّطوبة الْعالْية"
      , meaning = "the high humidity"
      }
    , { latin  = "al-yawm"
      , kana = "アルヤウム"
      , arabic = "اَلْيَوْم"
      , meaning = "today"
      }
    , { latin  = "alyawm yawm baarid"
      , kana = "アルヤウム ヤウム バーリド"
      , arabic = "اَلْيَوْم  يَوْم بارِد"
      , meaning = "Today is a cold day."
      }
    , { latin  = "tashar-rfnaa"
      , kana = "タシャッラフナー"
      , arabic = "تشرفنا"
      , meaning = "Pleased to meet you."
      }
    , { latin  = "a-S-Sayf l-baarid"
      , kana = "アッサイフ ル バーリド"
      , arabic = "اَلْصَّيْف اَلْبارِد"
      , meaning = "the cold summer"
      }
    , { latin  = "a-r-rabii3"
      , kana = "アッラビーア"
      , arabic = "اَلْرَّبيع"
      , meaning = "the spring"
      }
    , { latin  = "al-khariif mushmis"
      , kana = "アル ハリーフ ムシュミス"
      , arabic = "اَلْخَريف مُشْمِس"
      , meaning = "The fall is sunny."
      }
    , { latin  = "rabii3 jamiil"
      , kana = "ラビーア ジャミール"
      , arabic = "رَبيع جَميل"
      , meaning = "a pretty spring"
      }
    , { latin  = "rabii3 baarid fii 2iskutlandan"
      , kana = "ラビーア バアリド フィー スクトランダン"
      , arabic = "رَبيع بارِد في إِسْكُتْلَنْدا"
      , meaning = "a cold spring in Scotland"
      }
    , { latin = "kayfa"
      , kana = "カイファ"
      , arabic = "كَيْفَ"
      , meaning = "how"
      }
    , { latin  = "kaifa Haalka"
      , kana = "カイファ ハールカ"
      , arabic = "كَيْفَ حالكَ"
      , meaning = "How are you?"
      }
    , { latin  = "Hammaam"
      , kana = "ハンマーム"
      , arabic = "حَمّام"
      , meaning = "bathroom"
      }
    , { latin  = "haadhaa balad-haa"
      , kana = "ハーザー バラドハー"
      , arabic = "هَذا بَلَدها"
      , meaning = "This is her country."
      }
    , { latin  = "al-2urdun"
      , kana = "アル ウルドゥン"
      , arabic = "اَلْأُرْدُن"
      , meaning = "Jordan"
      }
    , { latin  = "a-s-saaHil"
      , kana = "アッサーヒル"
      , arabic = "اَلْسّاحِل"
      , meaning = "the coast"
      }
    , { latin  = "2uhibb a-s-safar 2ilaa 2almaaniiaa"
      , kana = "ウヒッブ アッサファル イラ アルマニア"
      , arabic = "أُحِب اَلْسَّفَر إِلى أَلْمانيا"
      , meaning = "I like travelling to Germany"
      }
    , { latin  = "hiyya"
      , kana = "ヒヤ"
      , arabic = "هِيَّ"
      , meaning = "she"
      }
    , { latin  = "huwwa"
      , kana = "フワ"
      , arabic = "هُوَّ"
      , meaning = "he"
      }
    , { latin  = "2anti"
      , kana = "アンティ"
      , arabic = "أَنْتِ"
      , meaning = "you (female)"
      }
    , { latin  = "2anta"
      , kana = "アンタ"
      , arabic = "أَنْتَ"
      , meaning = "you (male)"
      }
    , { latin  = "mutarjim dhakiyy"
      , kana = "ムタルジム ザキーイ"
      , arabic = "مُتَرْجِم ذَكِيّ"
      , meaning = "a smart translator (male)"
      }
    , { latin  = "mutarjima dhakiyya"
      , kana = "ムタルジマ ザキーヤ"
      , arabic = "مُتَرْجِمة ذَكِيّة"
      , meaning = "a smart translator (female)"
      }
    , { latin  = "2ustaadh 2amriikiyy"
      , kana = "ウスターズ アマリキーイ"
      , arabic = "أُسْتاذ أَمْريكِيّ"
      , meaning = "an American professor (male)"
      }
    , { latin  = "2ustaadha 2amriikiyya"
      , kana = "ウスターザ アマリキーヤ"
      , arabic = "أُسْتاذة أَمْريكِيّة"
      , meaning = "an American professor (female)"
      }
    , { latin  = "3alaa"
      , kana = "アラー"
      , arabic = "عَلى"
      , meaning = "on, on top of"
      }
    , { latin  = "al-3arabiyya l-fuSHaa"
      , kana = "アルアラビーヤ ル フスハー"
      , arabic = "اَلْعَرَبِيّة الْفُصْحى"
      , meaning = "Standard Arabic"
      }
    , { latin  = "bariiTaanyaa l-kubraa"
      , kana = "ブリターニヤー ル クブラー"
      , arabic = "بَريطانْيا الْكُبْرى"
      , meaning = "Great Britain"
      }
    , { latin  = "balad 3arabiyy"
      , kana = "バラド アラビーイ"
      , arabic = "بَلَد عَرَبِيّ"
      , meaning = "an Arab country"
      }
    , { latin  = "madiina 3arabiyya"
      , kana = "マディーナ アラビーヤ"
      , arabic = "مَدينة عَرَبِيّة"
      , meaning = "an Arab city"
      }
    , { latin  = "bint jadiid"
      , kana = "ビント ジャディード"
      , arabic = "بَيْت جَديد"
      , meaning = "a new house"
      }
    , { latin  = "jaami3a jadiida"
      , kana = "ジャーミア ジャディーダ"
      , arabic = "جامِعة جَديدة"
      , meaning = "a new university"
      }
    , { latin = "hadhaa Saaluun ghaalii"
      , kana = "ハーザー サールーン ガーリー"
      , arabic = "هَذا صالون غالي"
      , meaning = "This is an expensive living room"
      }      
    , { latin  = "ghaalii"
      , kana = "ガーリー"
      , arabic = "غالي"
      , meaning = "expensive, dear"
      }
    , { latin  = "khaalii"
      , kana = "クハーリー"
      , arabic = "خالي"
      , meaning = "my mother’s brother, uncle"
      }
    , { latin  = "taab"
      , kana = "ターブ"
      , arabic = "تاب"
      , meaning = "to repent"
      }
    , { latin  = "Taab"
      , kana = "ターブ"
      , arabic = "طاب"
      , meaning = "to be good, pleasant"
      }
    , { latin  = "2umm"
      , kana = "ウンム"
      , arabic = "أُمّ"
      , meaning = "mother"
      }
    , { latin  = "2ukht"
      , kana = "ウフト"
      , arabic = "أُخْت"
      , meaning = "siter"
      }
    , { latin  = "bint"
      , kana = "ビント"
      , arabic = "بِنْت"
      , meaning = "daughter, girl"
      }
    , { latin  = "2ummii"
      , kana = "ウンミー"
      , arabic = "أُمّي"
      , meaning = "my mother"
      }
    , { latin  = "ibnak"
      , kana = "イブナク"
      , arabic = "اِبْنَك"
      , meaning = "your son (to a man)"
      }
    , { latin  = "ibnik"
      , kana = "イブニク"
      , arabic = "اِبْنِك"
      , meaning = "your son (to a woman)"
      }
    , { latin  = "al-3iraaq"
      , kana = "アライラーク"
      , arabic = "اَلْعِراق"
      , meaning = "iraq"
      }
    , { latin  = "nadhiir"
      , kana = "ナディール"
      , arabic = "نَذير"
      , meaning = "warner, herald"
      }
    , { latin  = "naDhiir"
      , kana = "ナディール"
      , arabic = "نَظير"
      , meaning = "equal"
      }
    , { latin  = "madiinatii"
      , kana = "マディーナティ"
      , arabic = "مَدينَتي"
      , meaning = "my city"
      }
    , { latin  = "madiinatak"
      , kana = "マディーナタク"
      , arabic = "مَدينَتَك"
      , meaning = "your city (to a male)"
      }
    , { latin  = "madiinatik"
      , kana = "マディーナティク"
      , arabic = "مَدينَتِك"
      , meaning = "your city (to a female)"
      }
    , { latin  = "jaara"
      , kana = "ジャーラ"
      , arabic = "جارة"
      , meaning = "a neighbor (female)"
      }
    , { latin  = "jaaratii"
      , kana = "ジャーラティ"
      , arabic = "جارَتي"
      , meaning = "my neighbor (female)"
      }
    , { latin  = "jaaratak"
      , kana = "ジャーラタク"
      , arabic = "جارَتَك"
      , meaning = "your (female) neighbor (to a male)"
      }
    , { latin  = "jaaratik"
      , kana = "ジャーラティク"
      , arabic = "جارَتِك"
      , meaning = "your (female) neighbor (to a female)"
      }
    , { latin  = "al-bayt jamiil"
      , kana = "アルバイト ジャミール"
      , arabic = "اَلْبَيْت جَميل"
      , meaning = "The house is pretty"
      }
    , { latin  = "al-madiina jamiila"
      , kana = "アルマディーナ ジャミーラ"
      , arabic = "اَلْمَدينة جَميلة"
      , meaning = "The city is pretty"
      }
    , { latin  = "baytak jamiil"
      , kana = "バイタク ジャミール"
      , arabic = "بَيْتَك جَميل"
      , meaning = "Your house is pretty (to a male)"
      }
    , { latin  = "madiinatak jamiila"
      , kana = "マディーナタク ジャミーラ"
      , arabic = "مَدينَتَك جَميلة"
      , meaning = "Your city is pretty (to a male)"
      }
    , { latin  = "baytik jamiil"
      , kana = "バイティク ジャミール"
      , arabic = "بَيْتِك جَميل"
      , meaning = "Your house is pretty (to a female)"
      }
    , { latin  = "madiinatik jamiila"
      , kana = "マディーナティク ジャミーラ"
      , arabic = "مَدينَتِك جَميلة"
      , meaning = "Your city is pretty (to a female)"
      }
    , { latin  = "dall"
      , kana = "ダル"
      , arabic = "دَلّ"
      , meaning = "to show, guide"
      }
    , { latin  = "Dall"
      , kana = "ダル"
      , arabic = "ضَلّ"
      , meaning = "to stray"
      }
    , { latin  = "3ind juudii bayt"
      , kana = "アインド ジューディー バイト"
      , arabic = "عِنْد جودي بَيْت"
      , meaning = "Judy has a house."
      }
    , { latin  = "3indii baitii"
      , kana = "アインディー バイティー"
      , arabic = "عِنْدي بَيْت"
      , meaning = "I have a house."
      }
    , { latin  = "3indaka bayt"
      , kana = "アインダカ バイト"
      , arabic = "عِنْدَك بَيْت"
      , meaning = "You (to a man) have a house."
      }
    , { latin  = "3indika bayt"
      , kana = "アインディカ バイト"
      , arabic = "عِنْدِك بَيْت"
      , meaning = "You (to a woman) have a house."
      }
    , { latin  = "laysa 3ind juudii bayt"
      , kana = "ライサ アインド ジュウディー バイト"
      , arabic = "لَيْسَ عِنْد جودي بَيْت"
      , meaning = "Judy does not have a house."
      }
    , { latin  = "laysa 3indii kalb"
      , kana = "ライサ アインド カルブ"
      , arabic = "لَيْسَ عِنْدي كَلْب"
      , meaning = "I do not have a dog."
      }
    , { latin  = "laysa 3indika wishaaH"
      , kana = "ライサ アインディカ ウィシャーハ"
      , arabic = "لَيْسَ عِنْدِك وِشاح"
      , meaning = "You do not have a scarf. (to a woman)"
      }
    , { latin  = "madiina suuriyya"
      , kana = "マディーナ スリーヤ"
      , arabic = "مَدينة سورِيّة"
      , meaning = "a Syrian city"
      }
    , { latin  = "filasTiin makaan mashhuur"
      , kana = "フィラストィーン マカーン マシュフール"
      , arabic = "فِلَسْطين مَكان مَشْهور"
      , meaning = "Palestine is a famous place."
      }
    , { latin  = "a-s-suudaan wa-l3iraaq"
      , kana = "アッスーダーン ワライラーク"
      , arabic = "اَلْسّودان وَالْعِراق"
      , meaning = "Sudan and Iraq"
      }
    , { latin  = "al-3aaSima"
      , kana = "アルアースィマ"
      , arabic = "اَلْعاصِمة"
      , meaning = "the captal"
      }
    , { latin  = "jabal"
      , kana = "ジャバル"
      , arabic = "جَبَل"
      , meaning = "a mountain"
      }
    , { latin  = "a-th-thuudaan"
      , kana = "アッスーダーン"
      , arabic = "الشودان"
      , meaning = "Sudan"
      }
    , { latin  = "bayt 2azraq"
      , kana = "バイト アズラク"
      , arabic = "بَيْت أَزْرَق"
      , meaning = "a blue house"
      }
    , { latin  = "madiina zarqaa2"
      , kana = "マディーナ ザルカー"
      , arabic = "مَدينة زَرْقاء"
      , meaning = "a blue city"
      }
    , { latin  = "al-bayt 2azraq"
      , kana = "アルバイト アズラク"
      , arabic = "اَلْبَيْت أَزْرَق"
      , meaning = "The house is blue"
      }
    , { latin  = "al-madiina zarqaa2"
      , kana = "アル マディーナ ザルカー"
      , arabic = "اَلْمَدينة زَرْقاء"
      , meaning = "The city is blue."
      }
    , { latin  = "2azraq zarqaa2"
      , kana = "アズラク ザルカー"
      , arabic = "أَزْرَق  زَرْقاء"
      , meaning = "blue"
      }
    , { latin  = "saam"
      , kana = "サーム"
      , arabic = "سام"
      , meaning = "Sam (maile name)"
      }
    , { latin  = "Saam"
      , kana = "サーム"
      , arabic = "صام"
      , meaning = "to fast"
      }
    , { latin  = "Sadiiqii Juurj 3ind-hu 3amal mumtaaz"
      , kana = "サディークィー ジュールジュ アインダフー アアマル ムムターズ"
      , arabic = "صَديقي جورْج عِنْدهُ عَمَل مُمْتاز"
      , meaning = "My friend George has excellent job."
      }
    , { latin  = "ghaniyy"
      , kana = "ガニィイ"
      , arabic = "غَنِيّ"
      , meaning = "rich"
      }
    , { latin  = "amra2a"
      , kana = "アムラア"
      , arabic = "اَمْرَأة"
      , meaning = "a woman"
      }
    , { latin  = "2amaamaka"
      , kana = "アマーマカ"
      , arabic = "أَمامَك"
      , meaning = "in front of you"
      }
    , { latin  = "khalfak"
      , kana = "ハルファク"
      , arabic = "خَلْفَك"
      , meaning = "behind you"
      }
    , { latin  = "bijaanib"
      , kana = "ビジャーニブ"
      , arabic = "بِجانِب"
      , meaning = "next to"
      }
    , { latin  = "2abii mashghuul daayman"
      , kana = "アビー マシュグール ダーイマン"
      , arabic = "أَبي مَشْغول دائِماً"
      , meaning = "My father is always busy."
      }
    , { latin  = "su2aal"
      , kana = "スアール"
      , arabic = "سُؤال"
      , meaning = "question"
      }
    , { latin  = "ma3ii"
      , kana = "マアイー"
      , arabic = "معي"
      , meaning = "with me"
      }
    , { latin  = "labisa"
      , kana = "ラビサ"
      , arabic = "لابِسة"
      , meaning = "dress up"
      }
    , { latin  = "man ma3ii"
      , kana = "マン マアイー"
      , arabic = "مَن مَعي؟"
      , meaning = "Who is this?"
      }
    , { latin  = "Hanafiyya"
      , kana = "ハナフィーヤ"
      , arabic = "حَنَفِيّة"
      , meaning = "a faucet"
      }
    , { latin  = "Sawt"
      , kana = "サウト"
      , arabic = "صَوْت"
      , meaning = "voice"
      }
    , { latin  = "2adkhul"
      , kana = "アドホル"
      , arabic = "أَدْخُل"
      , meaning = "enter"
      }
    , { latin  = "al-haatif mu3aTTal wa-t-tilfaaz 2ayDan"
      , kana = "アルハーティフ ムアッタル ワッティルファーズ アイダン"
      , arabic = "اَلْهاتِف مُعَطَّل وَالْتَّلْفاز أَيضاً"
      , meaning = "The telephone is out of order and the television also."
      }
    , { latin  = "hunaak mushkila ma3a t-tilaaz"
      , kana = "フナーク ムシュキラ マア ッティルファーズ"
      , arabic = "هُناك مُشْكِلة مَعَ الْتِّلْفاز"
      , meaning = "There is a problem with the television."
      }
    , { latin  = "2a3rif"
      , kana = "アーリフ"
      , arabic = "أَعْرِف"
      , meaning = "I know ..."
      }
    , { latin = "raqam"
      , kana = "ラカム"
      , arabic = "رَقَم"
      , meaning = "number"
      }
    , { latin  = "la 2a3rif kul-l al-2aedaan"
      , kana = "ラー アーリフ クッラ ル アーダーン"
      , arabic = "لا أَعْرِف كُلّ اَلْأَعْداد"
      , meaning = "I do not know all the numbers."
      }
    , { latin  = "ta3rifiin"
      , kana = "ターリフィーン"
      , arabic = "تَعْرِفين"
      , meaning = "You (female) know"
      }
    , { latin  = "li2anna"
      , kana = "リアンナ"
      , arabic = "لِأَنَّ"
      , meaning = "because"
      }
    , { latin  = "samna"
      , kana = "サムナ"
      , arabic = "سَمنة"
      , meaning = "ghee"
      }
    , { latin  = "wilaaya"
      , kana = "ウィラーヤ"
      , arabic = "وِلايَة"
      , meaning = "a state"
      }
    , { latin  = "zawjii wa-bnii"
      , kana = "ザウジー ワブニー"
      , arabic = "زَوجي وَابني"
      , meaning = "my husband and my son"
      }
    , { latin  = "mumtaaz"
      , kana = "ムムターズ"
      , arabic = "مُمتاز"
      , meaning = "amazing, excellent"
      }
    , { latin  = "abnii"
      , kana = "アブニー"
      , arabic = "اَبني"
      , meaning = "my son"
      }
    , { latin  = "muHaasib"
      , kana = "ムハースィブ"
      , arabic = "مُحاسب"
      , meaning = "an accountant"
      }
    , { latin  = "juz2"
      , kana = "ジュズ"
      , arabic = "جُزء"
      , meaning = "a part of"
      }
    , { latin  = "fataa"
      , kana = "ファター"
      , arabic = "فَتاة"
      , meaning = "a young woman, a girl"
      }
    , { latin  = "tis3a"
      , kana = "ティスア"
      , arabic = "تِسعة"
      , meaning = "nine"
      }
    , { latin  = "hal l-lghat l-3arabiyya Sa3ba"
      , kana = "ハル ッルガト ルアラビーヤ サアバ"
      , arabic = "هَل اللُّغَة العَرَبية صَعبة"
      , meaning = "Is arabic language difficult?"
      }
    , { latin  = "maadhaa fa3lta 2amsi"
      , kana = "マーザー ファアルタ アムスィ"
      , arabic = "ماذا فَعلتَ أَمسِ"
      , meaning = "What did you do yesterday?"
      }
    , { latin  = "maadhaa 2akalta"
      , kana = "マーザー アカルタ"
      , arabic = "ماذا أَكَلتَ"
      , meaning = "What did you eat?"
      }
    , { latin  = "shu2uun"
      , kana = "シュ ウーン"
      , arabic = "شُؤُون"
      , meaning = "affairs, things"
      }
    , { latin  = "mataa waSalta"
      , kana = "マター ワサルタ"
      , arabic = "مَتي وَصَلتَ"
      , meaning = "When did you arrive?"
      }
    , { latin  = "suuq"
      , kana = "スーク"
      , arabic = "سوق"
      , meaning = "market"
      }
    , { latin  = "Haafila"
      , kana = "ハーフィラ"
      , arabic = "حافِلة"
      , meaning = "a bus"
      }
    , { latin  = "tannuura"
      , kana = "タンヌーラ"
      , arabic = "تَنورة"
      , meaning = "a skirt"
      }
    , { latin  = "laHaDha"
      , kana = "ラハザ"
      , arabic = "لَحَظة"
      , meaning = "a moment"
      }
    , { latin  = "2ayna l-qiTTa"
      , kana = "アイナ ルキッタ"
      , arabic = "أَينَ القِطّة"
      , meaning = "Where is the cat?"
      }
    , { latin  = "shaay"
      , kana = "シャーイ"
      , arabic = "شاي"
      , meaning = "tea"
      }      
    , { latin  = "hal haadhihi Haqiibatki"
      , kana = "ハル ハージヒ ハキーバトキ"
      , arabic = "هَل هَذِهِ حَقيبَتكِ"
      , meaning = "Is this your bag?"
      }
    , { latin  = "Hakiiba"
      , kana = "ハキーバ"
      , arabic = "حَقيبَة"
      , meaning = "a bag"
      }
    , { latin  = "Haal"
      , kana = "ハール"
      , arabic = "حال"
      , meaning = "condition"
      }
    , { latin  = "SaHiifa"
      , kana = "サヒーファ"
      , arabic = "صَحيفة"
      , meaning = "newspaper"
      }
    , { latin  = "maktab"
      , kana = "マクタブ"
      , arabic = "مَكْتَب"
      , meaning = "an office, a desk"
      }      
    , { latin  = "bunnii"
      , kana = "ブンニー"
      , arabic = "بُنّي"
      , meaning = "brown"
      }
    , { latin  = "2ila l-liqaa2"
      , kana = "イラ ッリカー"
      , arabic = "إِلى اللِّقاء"
      , meaning = "Bye. See you again."
      }
    , { latin  = "daa2iman"
      , kana = "ダーイマン"
      , arabic = "دائمًا"
      , meaning = "always"
      }
    , { latin  = "Hasanan"
      , kana = "ハサナン"
      , arabic = "حَسَنًا"
      , meaning = "Okay, good, fantastic!"
      }
    , { latin  = "2ayna l-Hammaam"
      , kana = "アイナ ル ハンマーン"
      , arabic = "أَينَ الحَمّام"
      , meaning = "Where is the bathroom?"
      }
    , { latin  = "baqara"
      , kana = "バカラ"
      , arabic = "بَقَرة"
      , meaning = "a cow"
      }
    , { latin  = "nasiij"
      , kana = "ナスィージ"
      , arabic = "نَسيج"
      , meaning = "texture"
      }
    , { latin  = "Hajar"
      , kana = "ハジャル"
      , arabic = "حَجَر"
      , meaning = "a stone"
      }
    , { latin  = "muthal-lath"
      , kana = "ムサッラス"
      , arabic = "مُثَلَّث"
      , meaning = "a triangle"
      }
    , { latin  = "kathiir"
      , kana = "カシール"
      , arabic = "كَثير"
      , meaning = "many, a lot of"
      }
    , { latin  = "thawm"
      , kana = "サウム"
      , arabic = "ثَوم"
      , meaning = "garlic"
      }
    , { latin  = "qiTTatii Saghiira"
      , kana = "キッタティー サギーラ"
      , arabic = "قِطَّتي صَغيرة"
      , meaning = "my small cat"
      }
    , { latin  = "dubb"
      , kana = "ドッブ"
      , arabic = "دُبّ"
      , meaning = "a bear"
      }
    , { latin  = "Tabakh"
      , kana = "タバクハ"
      , arabic = "طَبَخ"
      , meaning = "to cook, cooking"
      }
    , { latin  = "nakhl"
      , kana = "ナクヘル"
      , arabic = "نَخْل"
      , meaning = "date palm tree"
      }
    , { latin  = "kharuuf"
      , kana = "クハルーフ"
      , arabic = "خَروف"
      , meaning = "a sheep"
      }
    , { latin  = "samaHa"
      , kana = "サマハ"
      , arabic = "سَمَح"
      , meaning = "to allow, forgive"
      }
    , { latin  = "tashar-rfnaa"
      , kana = "タシャッラフナー"
      , arabic = "تَثَرَّفنا"
      , meaning = "I am pleased to meet you."
      }
    , { latin  = "Haliib"
      , kana = "ハリーブ"
      , arabic = "حَليب"
      , meaning = "milk (m)"
      }
    , { latin  = "haatha l-maTar a-th-thaqiir Sa3b"
      , kana = "ハーザ ル マタル アッサキール サアブ"
      , arabic = "هَذا المَطَر الثقيل صَعب"
      , meaning = "This heavy rain is difficult."
      }
    , { latin  = "al-maTar"
      , kana = "アルマタル"
      , arabic = "المَطَر"
      , meaning = "the rain"
      }
    , { latin  = "muHaadatha"
      , kana = "ムハーダサ"
      , arabic = "مُحادَثة"
      , meaning = "conversation"
      }
    , { latin  = "zawjatii ta3baana"
      , kana = "ザウジャティー タアバーナ"
      , arabic = "زَوجَتي تَعبانة"
      , meaning = "My wife is tired."
      }
    , { latin  = "shukuran"
      , kana = "シュクラン"
      , arabic = "شُكْراً"
      , meaning = "thank you"
      }
    , { latin  = "shukran jaziilan"
      , kana = "シュクラン ジャズィーラン"
      , arabic = "ثُكْراً جَزيلاً"
      , meaning = "Thank you very much."
      }
    , { latin  = "jaw3aan"
      , kana = "ジャウアーン"
      , arabic = "جَوعان"
      , meaning = "hungry, starving"
      }
    , { latin  = "2abyaD bayDaa2"
      , kana = "アビヤド バイダー"
      , arabic = "أَبْيَض بَيْضاء"
      , meaning = "white"
      }
    , { latin  = "jadd wa-jadda"
      , kana = "ジャッド ワ ジャッダ"
      , arabic = "جَدّ وَجَدّة"
      , meaning = "grandfather and grandmother"
      }
    , { latin  = "2aaluu"
      , kana = "アールー"
      , arabic = "آلو"
      , meaning = "Hello (on the phone)"
      }
    , { latin  = "SabaaH l-khayr"
      , kana = "サバーフ ル クハイル"
      , arabic = "صَباح الخّير"
      , meaning = "good morning"
      }
    , { latin  = "laakinn"
      , kana = "ラキン"
      , arabic = "لَكِنّ"
      , meaning = "but"
      }
    , { latin  = "thaqaafa"
      , kana = "サカーファ"
      , arabic = "ثَقافة"
      , meaning = "culture"
      }
    , { latin  = "Haarr"
      , kana = "ハール"
      , arabic = "حارّ"
      , meaning = "hot"
      }
    , { latin  = "Taqs baarid"
      , kana = "タクス バーリド"
      , arabic = "طَقْس بارِد"
      , meaning = "cold weather"
      }
    , { latin  = "tilfaaz"
      , kana = "ティルファーズ"
      , arabic = "تِلْفاز"
      , meaning = "a television"
      }
    , { latin  = "tufaaHa"
      , kana = "トゥファーハ"
      , arabic = "تُفاحة"
      , meaning = "an apple"
      }
    , { latin  = "sariir"
      , kana = "サリール"
      , arabic = "سَرير"
      , meaning = "a bed"
      }
    , { latin  = "kursii"
      , kana = "クルスィー"
      , arabic = "كُرسي"
      , meaning = "a chair"
      }
    , { latin  = "3an"
      , kana = "アン"
      , arabic = "عَن"
      , meaning = "about"
      }
    , { latin  = "samaa2"
      , kana = "サマー"
      , arabic = "سَماء"
      , meaning = "sky (f)"
      }
    , { latin  = "2iiTaalyaa"
      , kana = "イーターリヤー"
      , arabic = "إيطاليا"
      , meaning = "Italy"
      }
    , { latin  = "2arD"
      , kana = "アルド"
      , arabic = "أَرض"
      , meaning = "a land (f)"
      }
    , { latin  = "wilaayat taksaas"
      , kana = "ウィラーヤト タクサース"
      , arabic = "وِلاية تَكْساس"
      , meaning = "the state of Texas"
      }
    , { latin  = "Sahfii Sahfiiya"
      , kana = "サハフィー サハフィーヤ"
      , arabic = "صَحفي صَحفية"
      , meaning = "a journalist"
      }
    , { latin  = "bint suuriyya"
      , kana = "ビント スーリヤ"
      , arabic = "بِنْت سورِيّة"
      , meaning = "a Syrian girl"
      }
    , { latin  = "2umm"
      , kana = "ウンム"
      , arabic = "أُمّ"
      , meaning = "a mother (f)"
      }
    , { latin  = "3ayn"
      , kana = "アイン"
      , arabic = "عَيْن"
      , meaning = "an eye (f)"
      }
    , { latin  = "qadam"
      , kana = "カダム"
      , arabic = "قَدَم"
      , meaning = "a foot (f)"
      }
    , { latin  = "3an l-qiraa2a"
      , kana = "アニル キラーエ"
      , arabic = "عَن القِراءة"
      , meaning = "about reading"
      }
    , { latin  = "a-s-safar"
      , kana = "アッサファル"
      , arabic = "السفر"
      , meaning = "travelling"
      }
    , { latin  = "kulla yawm"
      , kana = "クッラ ヤウム"
      , arabic = "كُلَّ يَوم"
      , meaning = "every day"
      }
    , { latin  = "2adrs fi l-jaami3a kulla yawm"
      , kana = "アドルス フィ ル ジャーミア クッラ ヤウム"
      , arabic = "أَدرس في الجامِعة كُلَّ يَوم"
      , meaning = "I study at the university every day."
      }
    , { latin  = "dhahaba"
      , kana = "ザハバ"
      , arabic = "ذَهَبَ"
      , meaning = "He went"
      }
    , { latin  = "katabaa"
      , kana = "カタバー"
      , arabic = "كَتَبَا"
      , meaning = "They (two male) wrote"
      }
    , { latin  = "katabtu"
      , kana = "カタブトゥ"
      , arabic = "كَتَبْتُ"
      , meaning = "I wrote"
      }
    , { latin  = "katabti"
      , kana = "カタブティ"
      , arabic = "كَتَبْتِ"
      , meaning = "You (female) wrote"
      }
    , { latin  = "katabta"
      , kana = "カタブタ"
      , arabic = "كَتَبْتَ"
      , meaning = "You (male) wrote"
      }
    , { latin  = "katabat"
      , kana = "カタバット"
      , arabic = "كَتَبَت"
      , meaning = "She wrote"
      }
    , { latin  = "ramaDaan"
      , kana = "ラマダーン"
      , arabic = "رَمَضان"
      , meaning = "Ramadan"
      }
    , { latin  = "qahwa"
      , kana = "カハワ"
      , arabic = "قَهوة"
      , meaning = "coffee"
      }
    , { latin  = "al-2aan"
      , kana = "アル アーン"
      , arabic = "اَلآن"
      , meaning = "right now"
      }
    , { latin  = "saa3at Haa2iT"
      , kana = "サーアト ハーイト"
      , arabic = "ساعة حائط"
      , meaning = "a wall clock"
      }
    , { latin  = "kami s-saa3a l-2aan"
      , kana = "カミッサーア ルアーン"
      , arabic = "كَمِ الساعة الآن"
      , meaning = "What time is it now?"
      }
    , { latin  = "a-s-saa3a kam"
      , kana = "アッサーア カム"
      , arabic = "الساعة كَم"
      , meaning = "What time is it?"
      }
    , { latin  = "2a3Tinii"
      , kana = "アーティニー"
      , arabic = "أَعْطِني"
      , meaning = "Give me ..."
      }
    , { latin  = "Tayyib"
      , kana = "タイイブ"
      , arabic = "طَيِّب"
      , meaning = "Ok, good"
      }
    , { latin  = "2abuu shaqra"
      , kana = "アブーシャクラ"
      , arabic = "أَبو شَقرة"
      , meaning = "Abu Shakra (restaurant)"
      }
    , { latin  = "haathihi T-Taawila Haara"
      , kana = "ハージヒ ッターウィラ ハーラ"
      , arabic = "هَذِهِ الطاوِلة حارة"
      , meaning = "This table is hot."
      }
    , { latin  = "ma3Taf khafiif"
      , kana = "マアタフ クハフィーフ"
      , arabic = "معطَف خَفيف"
      , meaning = "a light coat"
      }
    , { latin  = "maTar khafiif"
      , kana = "マタル クハフィーフ"
      , arabic = "مَطَر خَفيف"
      , meaning = "a light rain"
      }
    , { latin  = "a-T-Taqs"
      , kana = "アッタクス"
      , arabic = "الطَّقس"
      , meaning = "the weather"
      }
    , { latin  = "2alf"
      , kana = "アルフ"
      , arabic = "أَلف"
      , meaning = "a thousand"
      }
    , { latin  = "mi3a"
      , kana = "ミア"
      , arabic = "مِئة"
      , meaning = "a hundred"
      }
    , { latin  = "3ashara"
      , kana = "アシャラ"
      , arabic = "عَشرة"
      , meaning = "ten"
      }
    , { latin  = "al-Hamdu li-l-laa"
      , kana = "アルハムド リッラー"
      , arabic = "الحَمدُ لِلَّه"
      , meaning = "Praise be to God."
      }
    , { latin  = "Hubba"
      , kana = "フッバ"
      , arabic = "حُبَّ"
      , meaning = "love"
      }
    , { latin  = "3ilka"
      , kana = "アイルカ"
      , arabic = "عِلكة"
      , meaning = "chewing gum"
      }
    , { latin  = "thaqiil"
      , kana = "サキール"
      , arabic = "ثَقيل"
      , meaning = "heavy"
      }
    , { latin  = "haatifii"
      , kana = "ハーティフィー"
      , arabic = "هاتِفي"
      , meaning = "my phone"
      }
    , { latin  = "thamaaniya"
      , kana = "サマーニヤ"
      , arabic = "ثَمانية"
      , meaning = "eight"
      }
    , { latin  = "sab3a"
      , kana = "サブア"
      , arabic = "سَبعة"
      , meaning = "seven"
      }
    , { latin  = "sitta"
      , kana = "スィッタ"
      , arabic = "سِتَّة"
      , meaning = "six"
      }
    , { latin  = "khamsa"
      , kana = "クハムサ"
      , arabic = "خَمسة"
      , meaning = "five"
      }
    , { latin  = "2arba3a"
      , kana = "アルバア"
      , arabic = "أَربَعة"
      , meaning = "four"
      }
    , { latin  = "thalaatha"
      , kana = "サラーサ"
      , arabic = "ثَلاثة"
      , meaning = "three"
      }
    , { latin  = "2alif baa2 taa2 thaa2 jiim Haa2 khaa2"
      , kana = "アリフ バー ター サー ジーム ハー クハー"
      , arabic = "أَلِف باء تاء ثاء جيم حاء خاء"
      , meaning = "ا ب ت ث ج ح خ"
      }
    , { latin  = "daal dhaal raa2 zaay siin shiin"
      , kana = "ダール ザール ラー ザーイ スィーン シーン"
      , arabic = "دال ذال راء زاي سين شين"
      , meaning = "د ذ ر ز س ش"
      }
    , { latin  = "Saad Daad Taa2 Dhaa2 3ain ghain"
      , kana = "サード ダード ター ザー アイン ガイン"
      , arabic = "صاد ضاد طاء ظاء عَين غَين"
      , meaning = "ص ض ط ظ ع غ"
      }
    , { latin  = "faa2 qaaf kaaf laam miim nuun"
      , kana = "ファー カーフ カーフ ラーム ミーム ヌーン"
      , arabic = "فاء قاف كاف لام ميم نون"
      , meaning = "ف ق ك ل م ن"
      }
    , { latin  = "haa2 waaw yaa2 hamza"
      , kana = "ハー ワーウ ヤー ハムザ"
      , arabic = "هاء واو ياء هَمزة"
      , meaning = "ه و ي ء"
      }
    , { latin  = "kaifa l-Haal"
      , kana = "カイファ ル ハール"
      , arabic = "كَيفَ الحال"
      , meaning = "How are you? (How is the condition?)"
      }
    , { latin  = "bi-khayr wa-l-Hamdu li-l-laa"
      , kana = "ビクハイル ワルハムドゥ リッラー"
      , arabic = "بِخَير وَالحَمدُ لِلَّه"
      , meaning = "I am fine.  Praise be to God."
      }
    , { latin  = "2aHmar Hamraa2"
      , kana = "アフマル ハムラー"
      , arabic = "أَحمَر حَمراء"
      , meaning = "red"
      }
    , { latin  = "muHaamii"
      , kana = "ムハーミー"
      , arabic = "مُحامي"
      , meaning = "an attorney, a lawyer"
      }
    , { latin  = "haadhaa rakamii"
      , kana = "ハーザー ラカミー"
      , arabic = "هَذا رَقَمي"
      , meaning = "This is my number."
      }
    , { latin  = "samaka 2asmaak"
      , kana = "サマカ アスマーク"
      , arabic = "سَمَكة أَسماك"
      , meaning = "fish, fish (plural)"
      }
    , { latin  = "shajara 2ashujaar"
      , kana = "シャジャラ アシュジャール"
      , arabic = "شَجَرة أَشجار"
      , meaning = "tree, trees"
      }
    , { latin  = "manzil"
      , kana = "マンズィル"
      , arabic = "مَنزِل"
      , meaning = "a house, home"
      }
    , { latin = "bayt"
      , kana = "バイト"
      , arabic = "بَيْت"
      , meaning = "a house"
      }
    , { latin = "Hadiiqa"
      , kana = "ハディーカ"
      , arabic = "حَديقة"
      , meaning = "garden"
      }
    , { latin = "haadhihi Hadiiqa 3arabyya"
      , kana = "ハージヒ ハディーカ アラビーヤ"
      , arabic = "هَذِهِ حَديقة عَرَبيّة"
      , meaning = "This is an Arab garden"
      }
    , { latin  = "tafaD-Dal ijlis"
      , kana = "タファッダル イジュリス"
      , arabic = "تَفَضَّل اِجْلِس"
      , meaning = "Please sit down."
      }
    , { latin  = "tafaD-Dalii"
      , kana = "タファッダリー"
      , arabic = "تَفَضَّلي"
      , meaning = "Please (female word)"
      }
    , { latin  = "shaay min faDlika"
      , kana = "シャーイ ミン ファドリカ"
      , arabic = "شاي مِن فَضلِكَ"
      , meaning = "Tea please."
      }
    , { latin  = "ma3a s-salaama"
      , kana = "マア ッサラーマ"
      , arabic = "مَعَ السَّلامة"
      , meaning = "Good bye."
      }
    , { latin  = "ash-shams"
      , kana = "アッシャムス"
      , arabic = "الشَّمس"
      , meaning = "the sun"
      }
    , { latin  = "haadha l-qalam"
      , kana = "ハーザ ル カラム"
      , arabic = "هَذا القَلَم"
      , meaning = "this pen"
      }
    , { latin  = "muta2assif laa 3alayka"
      , kana = "ムタアッシフ ラー アライカ"
      , arabic = "مُتأَسِّف. لا عَلَيكَ."
      , meaning = "I am sorry. Do not mind."
      }
    , { latin  = "al-qamar"
      , kana = "アルカマル"
      , arabic = "القَمَر"
      , meaning = "the moon"
      }
    , { latin  = "walad al-walad"
      , kana = "ワラド アルワラド"
      , arabic = "وَلَد الوَلَد"
      , meaning = "boy , the boy"
      }
    , { latin  = "madrasa"
      , kana = "マドラサ"
      , arabic = "مَدرَسة"
      , meaning = "a school"
      }
    , { latin  = "saa2iq"
      , kana = "サーイク"
      , arabic = "سائق"
      , meaning = "a driver"
      }
    , { latin  = "daftar"
      , kana = "ダフタル"
      , arabic = "دَفتَر"
      , meaning = "a notebook"
      }
    , { latin  = "ba3da 2idhnika"
      , kana = "バァダ イズニカ"
      , arabic = "بَعدَ إِذنِكَ"
      , meaning = "After your permit. Excuse me."
      }
    , { latin  = "muwaDh-Dhaf"
      , kana = "ムワッザフ"
      , arabic = "مُوَظَّف"
      , meaning = "an employee"
      }
    , { latin  = "waaHid"
      , kana = "ワーヒド"
      , arabic = "واحِد"
      , meaning = "one"
      }
    , { latin  = "2ithnaan"
      , kana = "イスナーン"
      , arabic = "اِثنان"
      , meaning = "two"
      }
    , { latin  = "qamiiS"
      , kana = "カミース"
      , arabic = "قَميص"
      , meaning = "a shirt"
      }
    , { latin  = "qaamuus"
      , kana = "カームース"
      , arabic = "قاموس"
      , meaning = "dictionary"
      }
    , { latin  = "majal-la"
      , kana = "マジャッラ"
      , arabic = "مَجَلَّة"
      , meaning = "magazine"
      }
    , { latin  = "2iijaarii"
      , kana = "イージャーリー"
      , arabic = "إيجاري"
      , meaning = "my rent"
      }
    , { latin  = "maa haadhaa"
      , kana = "マー ハーザー"
      , arabic = "ما هَذا"
      , meaning = "What is this?"
      }
    , { latin  = "khubz"
      , kana = "クフブズ"
      , arabic = "خُبز"
      , meaning = "bread"
      }
    , { latin  = "riisha"
      , kana = "リーシャ"
      , arabic = "ريشة"
      , meaning = "feather"
      }
    , { latin  = "Taa2ira"
      , kana = "ターイラ"
      , arabic = "طائرة"
      , meaning = "an airplane"
      }
    , { latin  = "Dhabii"
      , kana = "ザビー"
      , arabic = "ظَبي"
      , meaning = "an antelope"
      }
    , { latin  = "Tabiib"
      , kana = "タビーブ"
      , arabic = "طَبيب"
      , meaning = "doctor"
      }
    , { latin  = "laa 2a3rif 2ayna 2anaa"
      , kana = "ラー アーリフ アイナ アナー"
      , arabic = "لا أَعرِف أَين أَنا"
      , meaning = "I do not know where I am."
      }
    , { latin  = "jaarii"
      , kana = "ジャーリー"
      , arabic = "جاري"
      , meaning = "my (male) neighbor"
      }
     , { latin  = "huwa wa hiya wa hum"
       , kana = "フワ ワ ヒヤ ワ フム"
       , arabic = "هُوَ وَ هِيَ وَ هُم"
       , meaning = "he and she and they"
       }
    , { latin  = "2anta wa 2anti wa 2antum"
      , kana = "アンタ ワ アンティ ワ アントゥム"
      , arabic = "أَنتَ وَ أَنتِ وَ أَنتُم"
      , meaning = "you (male) and you (female) and you (plural)"
      }
    , { latin  = "naHnu"
      , kana = "ナフヌ"
      , arabic = "نَحنُ"
      , meaning = "we"
      }
    , { latin  = "2akh"
      , kana = "アクハ"
      , arabic = "أَخ"
      , meaning = "a brother"
      }
    , { latin  = "Hijaab"
      , kana = "ヒジャーブ"
      , arabic = "حِجاب"
      , meaning = "a barrier, Hijab"
      }
    , { latin  = "2ustaadhii"
      , kana = "ウスタージー"
      , arabic = "أُستاذي"
      , meaning = "my professor"
      }
    , { latin  = "SabaaH n-nuur"
      , kana = "サバーフ ン ヌール"
      , arabic = "صَباح النور"
      , meaning = "Good morning."
      }
    , { latin  = "mu3l-lamii"
      , kana = "ムアッラミー"
      , arabic = "مُعلَّمي"
      , meaning = "my teacher"
      }
    , { latin  = "al-2qkl wa-n-nawm"
      , kana = "アル アクル ワ ン ナウム"
      , arabic = "الأَكْل وَالنَّوم"
      , meaning = "eating and sleeping"
      }
    , { latin  = "2aiDan"
      , kana = "アイダン"
      , arabic = "أَيضاً"
      , meaning = "also"
      }
    , { latin  = "al-jarii"
      , kana = "アル ジャリー"
      , arabic = "الجَري"
      , meaning = "running"
      }
    , { latin  = "a-n-nawm"
      , kana = "アンナウム"
      , arabic = "النَّوم"
      , meaning = "sleeping"
      }
    , { latin  = "bintii"
      , kana = "ビンティー"
      , arabic = "بِنتي"
      , meaning = "my daughter"
      }
    , { latin  = "2amaama"
      , kana = "アマーマ"
      , arabic = "أَمامَ"
      , meaning = "in front of, before"
      }
    , { latin  = "jaami3tii fii Tuukyuu"
      , kana = "ジャーミアティー フィー トーキョー"
      , arabic = "جامِعتي في طوكيو"
      , meaning = "My university is in Tokyo."
      }
    , { latin  = "2ayn jaami3tka"
      , kana = "アイン ジャーミアトカ"
      , arabic = "أَين جامِعتكَ"
      , meaning = "Where is your university?"
      }
    , { latin  = "a-t-taSwiir"
      , kana = "アッタスウィール"
      , arabic = "التصْوير"
      , meaning = "photography"
      }
    , { latin  = "jaaratii"
      , kana = "ジャーラティー"
      , arabic = "جارَتي"
      , meaning = "my (female) neighbor"
      }
    , { latin  = "jaarii"
      , kana = "ジャーリー"
      , arabic = "جاري"
      , meaning = "my (male) neighbor"
      }
    , { latin  = "Dawaahii"
      , kana = "ダワーヒー"
      , arabic = "ضَواحي"
      , meaning = "suburbs"
      }
    , { latin  = "2askn fii DawaaHii baghdaad"
      , kana = "アスクン フィー ダワーヒー バグダード"
      , arabic = "أَسكن في ضَواحي بَغداد"
      , meaning = "I live in the suburbs of Bagdad."
      }
    , { latin  = "qar-yatii qariiba min madiinat bayruut"
      , kana = "カルヤティー カリーバ ミン マディーナト バイルート"
      , arabic = "قَريتي قَريبة مِن مَدينة بَيروت"
      , meaning = "My village is close to the city of Beirut."
      }
    , { latin  = "3afwan"
      , kana = "アフワン"
      , arabic = "عَفواً"
      , meaning = "Excuse me. Sure, it's Ok. (Reply to thank you)"
      }
    , { latin  = "2ahlan wa-sahlan"
      , kana = "アハラン ワ サハラン"
      , arabic = "أَهلاً وَسَهلاً"
      , meaning = "Welcome."
      }
    , { latin = "kitaab"
      , kana = "キターブ"
      , arabic = "كِتاب"
      , meaning = "a book"
      }
    , { latin  = "Sadiiqathu ruuzaa qariibhu min baythu"
      , kana = "サディーカトフ ルーザー カリーバ ミン バイトフ"
      , arabic = "صَديقَته روزا قَريبة مِن بَيته"
      , meaning = "His friend Rosa is close to his house."
      }
    , { latin  = "Sadiiqathu qariiba min manzilhu"
      , kana = "サディーカトフ カリーバ ミン マンズィルフ"
      , arabic = "صَديقَته قَريبة مِن مَنزِله."
      , meaning = "His girlfriend is close to his home"
      }
    , { latin  = "2amaam al-jaami3a"
      , kana = "アマーマ ル ジャーミア"
      , arabic = "أَمام اَلْجامِعة"
      , meaning = "in front of the university"
      }
    , { latin  = "waraa2 l-maqhaa"
      , kana = "ワラーア ル マクハー"
      , arabic = "وَراء المَقهى"
      , meaning = "behind the cafe"
      }
    , { latin  = "2anaafi l-maqhaa"
      , kana = "アナ フィ ル マクハー"
      , arabic = "أَنا في المَقهى"
      , meaning = "I am in the cafe."
      }
    , { latin  = "bi-l-layr"
      , kana = "ビッライル"
      , arabic = "بِاللَّيل"
      , meaning = "at night"
      }
    , { latin  = "3an il-yaabaan"
      , kana = "アニル ヤーバーン"
      , arabic = "عَن اليابان"
      , meaning = "about Japan"
      }
    , { latin  = "qabl a-s-saa3at l-khaamisa"
      , kana = "カブラ ッサーアト ル クハーミサ"
      , arabic = "قَبل الساعة الخامِسة"
      , meaning = "before the fifth hour"
      }
    , { latin  = "ba3d a-Dh-Dhuhr"
      , kana = "バァダ ッズホル"
      , arabic = "بَعد الظُّهر"
      , meaning = "afternoon"
      }
    , { latin  = "2uHibb a-n-nawm ba3d a-Dh-Dhuhr"
      , kana = "ウヒッブ アンナウム バァダ ッズホル"
      , arabic = "أحِبّ اَلْنَّوْم بَعْد اَلْظَّهْر"
      , meaning = "I like sleeping in the afternoon."
      }
    , { latin  = "alkalaam ma3a 2abii ba3d alDh-Dhuhr"
      , kana = "アルカラーム マア アビー バァダ ッズホル"
      , arabic = "اَلْكَلام معَ أَبي بَعْد اَلْظَّهْر"
      , meaning = "talking with my father in the afternoon"
      }
    , { latin  = "a-s-salaamu 3alaykum"
      , kana = "アッサラーム アライクム"
      , arabic = "اَلْسَّلامُ عَلَيْكُم"
      , meaning = "Peace be upon you."
      }
    , { latin  = "wa-3alaykumu a-s-salaam"
      , kana = "ワ アライクム アッサラーム"
      , arabic = "وَعَلَيكم السلام"
      , meaning = "And peace be upon you."
      }
    , { latin  = "lil2asaf"
      , kana = "リルアサフ"
      , arabic = "لِلْأَسَف"
      , meaning = "unfortunately"
      }
    , { latin  = "al-baHr al-2abyaD al-mutawas-siT"
      , kana = "アル バハル アル アビヤド アル ムタワッスィト"
      , arabic = "اَاْبَحْر اَلْأَبْيَض اَلْمُتَوَسِّط"
      , meaning = "the Meditteranean Sea"
      }
    , { latin  = "2uHibb a-s-safar 2ila l-baHr al-2abyaD al-mutawas-siT"
      , kana = "ウヒッブ アッサファル イラ ル バハル アル アビヤド アル ムタワッスィト"
      , arabic = "أُحِبّ اَلْسَّفَر إِلى الْبَحْر اَلْلأَبْيَض اَلْمُتَوَسِّط"
      , meaning = "I like travelling to the Mediterranean Sea."
      }
    , { latin  = "ghadan"
      , kana = "ガダン"
      , arabic = "غَداً"
      , meaning = "tomorrow"
      }
    , { latin  = "li-maadhaa"
      , kana = "リ マーザー"
      , arabic = "لَماذا"
      , meaning = "why"
      }
    , { latin  = "3indii fikra"
      , kana = "アインディー フィクラ"
      , arabic = "عِندي فِكْرة"
      , meaning = "I have an idea."
      }
    , { latin  = "hal 3indaka haatif"
      , kana = "ハル アインダカ ハーティフ"
      , arabic = "هَل عِندَكَ هاتِف"
      , meaning = "Do you have a phone?"
      }
    , { latin  = "fi l-T-Taabiq al-2awwal"
      , kana = "フィル ッタービク アルアッワル"
      , arabic = "في الْطّابِق اَلْأَوَّل"
      , meaning = "on the first floor"
      }
    , { latin  = "a-sh-shaanii"
      , kana = "アッシャーニー"
      , arabic = "الثاني"
      , meaning = "the second"
      }
    , { latin  = "fi l-T-Taabiq a-sh-sha-nii"
      , kana = "フィル ッタービク アッシャーニー"
      , arabic = "في الطابق الثاني"
      , meaning = "in the second floor"
      }
    , { latin  = "al-laa"
      , kana = "アッラー"
      , arabic = "اَلله"
      , meaning = "God"
      }
    , { latin  = "haadha l-bayt"
      , kana = "ハーザ ル バイト"
      , arabic = "هَذا البَيت"
      , meaning = "this house"
      }
    , { latin  = "haadhihi l-madiina"
      , kana = "ハージヒ ル マディーナ"
      , arabic = "هَذِهِ المَدينة"
      , meaning = "this city"
      }
    , { latin  = "hunaak bayt"
      , kana = "フナーク バイト"
      , arabic = "هُناك بَيْت"
      , meaning = "There is a house."
      }
    , { latin  = "al-bayt hunaak"
      , kana = "アルバイト フナーク"
      , arabic = "اَلْبَيْت هُناك"
      , meaning = "The house is there."
      }
    , { latin  = "hunaak washaaH 2abyaD"
      , kana = "フナーク ワシャーハ アビヤド"
      , arabic = ".هُناك وِشاح أَبْيَض"
      , meaning = "There is a white scarf."
      }
    , { latin  = "al-washaaH hunaak"
      , kana = "アルワシャーハ フナーク"
      , arabic = "اَلْوِشاح هُناك"
      , meaning = "The scarf is there."
      }
    , { latin  = "laysa hunaak bayt"
      , kana = "ライサ フナーク バイト"
      , arabic = "لَيْسَ هُناك بَيْت"
      , meaning = "There is no house."
      }
    , { latin  = "laysa hunaak washaaH 2abyaD"
      , kana = "ライサ フナーク ワシャーハ アビヤド"
      , arabic = "لَيْسَ هُناك وِشاح أَبْيَض"
      , meaning = "There is no white scarf."
      }
    , { latin  = "bayt buub"
      , kana = "バイト ブーブ"
      , arabic = "بَيْت بوب"
      , meaning = "Bob’s house"
      }
    , { latin  = "baab karii"
      , kana = "バーブ カリー"
      , arabic = "باب كَري"
      , meaning = "Carrie’s door"
      }
    , { latin  = "kalb al-bint"
      , kana = "カルブ アルビント"
      , arabic = "كَلْب اَلْبِنْت"
      , meaning = "the girl’s dog"
      }
    , { latin  = "wishaaH al-walad"
      , kana = "ウィシャーハ アル ワラド"
      , arabic = "وِشاح اَلْوَلَد"
      , meaning = "the boy’s scarf"
      }
    , { latin  = "madiinat buub"
      , kana = "マディーナト ブーブ"
      , arabic = "مَدينة بوب"
      , meaning = "Bob’s city"
      }
    , { latin  = "jaami3at karii"
      , kana = "ジャミーアト カリー"
      , arabic = "جامِعة كَري"
      , meaning = "Carrie’s university"
      }
    , { latin  = "qiT-Tat al-walad"
      , kana = "キッタト アルワラド"
      , arabic = "قِطّة اَلْوَلَد"
      , meaning = "the boy’s cat"
      }
    , { latin  = "mi3Tafhu"
      , kana = "ミターフフ"
      , arabic = "مِعْطَفهُ"
      , meaning = "his coat"
      }
    , { latin  = "mi3Tafhaa"
      , kana = "ミターフハー"
      , arabic = "مِعْطَفها"
      , meaning = "her coat"
      }
    , { latin  = "baythu"
      , kana = "バイトフ"
      , arabic = "بَيْتهُ"
      , meaning = "his house"
      }
    , { latin  = "baythaa"
      , kana = "バイトハー"
      , arabic = "بَيْتها"
      , meaning = "her house"
      }
    , { latin  = "madiinathu"
      , kana = "マディーナトフ"
      , arabic = "مَدينَتهُ"
      , meaning = "his city"
      }
    , { latin  = "madiinathaa"
      , kana = "マディーナトハー"
      , arabic = "مَدينَتها"
      , meaning = "her city"
      }
    , { latin  = "qubba3athu"
      , kana = "クッバトフ"
      , arabic = "قُبَّعَتهُ"
      , meaning = "his hat"
      }
    , { latin  = "qubba3athaa"
      , kana = "クッバトハー"
      , arabic = "قُبَّعَتها"
      , meaning = "her hat"
      }
    , { latin  = "2abtasim"
      , kana = "アブタスィム"
      , arabic = "أَبْتَسِم"
      , meaning = "I smile"
      }
    , { latin  = "2aTbukh"
      , kana = "アトブクフ"
      , arabic = "أَطْبُخ"
      , meaning = "I cook"
      }
    , { latin  = "laa 2aTbukh"
      , kana = "ラー アトブクフ"
      , arabic = "لا أَطْبُخ"
      , meaning = "I do not cook."
      }
    , { latin  = "li-d-diraasa"
      , kana = "リッディラーサ"
      , arabic = "للدراسة"
      , meaning = "to study"
      }
    , { latin  = "ma3a 2ustaadh 2aHmad"
      , kana = "マア ウスターズ アハマド"
      , arabic = "مَعَ الأُستاذ أَحمَد"
      , meaning = "with Mr. Ahmed"
      }
    , { latin  = "bi-l-yaabaaniyy"
      , kana = "ビルヤーバーニーイ"
      , arabic = "بالياباني"
      , meaning = "in Japanese"
      }
    , { latin  = "bi-s-sayaara"
      , kana = "ビッサイヤーラ"
      , arabic = "باالسيارة"
      , meaning = "by car"
      }
    , { latin  = "li-2akhii"
      , kana = "リアクヒー"
      , arabic = "لِأَخي"
      , meaning = "for my brother"
      }
    , { latin  = "3ala l-kursii"
      , kana = "アラ ル クルスィー"
      , arabic = "عَلى الكُرسي"
      , meaning = "on the chair"
      }
    , { latin  = "taHt al-maktab"
      , kana = "タハタ ル マクタブ"
      , arabic = "تَحت المَكتَب"
      , meaning = "under the desk"
      }
    , { latin  = "amaam al-maHaTTa"
      , kana = "アマーマ ル マハッタ"
      , arabic = "أَمام المَحطّة"
      , meaning = "in front of the station"
      }
    , { latin  = "2atakal-lam"
      , kana = "アタカッラム"
      , arabic = "أَتَكَلَّم"
      , meaning = "I talk, I speak"
      }
    , { latin  = "2uHibb al-kalaam"
      , kana = "ウヒッブ アルカラーム"
      , arabic = "أُحِبّ اَلْكَلام."
      , meaning = "I like talking."
      }
    , { latin  = "2uriid al-kalaam"
      , kana = "ウリード アルカラーム"
      , arabic = "أُريد اَلْكَلام"
      , meaning = "I want to talk."
      }
    , { latin  = "al-kalaam jayyid"
      , kana = "アルカラーム ジャイイド"
      , arabic = "اَلْكَلام جَيِّد"
      , meaning = "The talking is good."
      }
    , { latin  = "az-zawja"
      , kana = "アッザウジャ"
      , arabic = "اَلْزَّوْجة"
      , meaning = "the wife"
      }
    , { latin  = "as-sayyaara"
      , kana = "アッサイヤーラ"
      , arabic = "اَلْسَّيّارة"
      , meaning = "the car"
      }
    , { latin  = "ad-duktuur"
      , kana = "アッドクトゥール"
      , arabic = "ad-duktuur"
      , meaning = "the doctor"
      }
    , { latin  = "ar-rajul"
      , kana = "アッラジュル"
      , arabic = "اَلْرَّجُل"
      , meaning = "the man"
      }
    , { latin  = "as-suudaan"
      , kana = "アッスーダーン"
      , arabic = "اَلْسّودان"
      , meaning = "Sudan"
      }
    , { latin  = "yabda2"
      , kana = "ヤブダ"
      , arabic = "يَبْدَأ"
      , meaning = "he begins"
      }
    , { latin  = "shaadii l-mu3al-lim"
      , kana = "シャーディー ル ムアッリム"
      , arabic = "شادي المُعَلِّم"
      , meaning = "Shadi the teacher"
      }
    , { latin  = "mahaa l-mutarjima"
      , kana = "マハー ル ムタルジマ"
      , arabic = "مَها المُتَرجِمة"
      , meaning = "Maha the translator"
      }
    , { latin  = "fi l-bayt"
      , kana = "フィルバイト"
      , arabic = "في البَيت"
      , meaning = "in the house"
      }
    , { latin  = "fi s-sayyaara"
      , kana = "フィッサイヤーラ"
      , arabic = "في السيارة"
      , meaning = "in the car"
      }
    , { latin  = "2iDaafa"
      , kana = "イダーファ"
      , arabic = "إضافة"
      , meaning = "iDaafa, addition"
      }
    , { latin  = "2aftaH"
      , kana = "アフタハ"
      , arabic = "أَفْتَح"
      , meaning = "I open"
      }
    , { latin  = "tuHibb"
      , kana = "トゥヒッブ"
      , arabic = "تُحِبّ"
      , meaning = "you like (to a male), she likes"
      }
    , { latin  = "tuHibbiin"
      , kana = "トゥヒッビーン"
      , arabic = "تُحِبّين"
      , meaning = "you like (to a female)"
      }
    , { latin  = "yuHibb"
      , kana = "ユヒッブ"
      , arabic = "يُحِبّ"
      , meaning = "he likes"
      }
    , { latin  = "tanaam"
      , kana = "タナーム"
      , arabic = "تَنام"
      , meaning = "you sleep (to a male), she sleeps"
      }
    , { latin  = "tanaamiin"
      , kana = "タナーミーン"
      , arabic = "تَنامين"
      , meaning = "you sleep (to a female)"
      }
    , { latin  = "yaanaam"
      , kana = "ヤナーム"
      , arabic = "يَنام"
      , meaning = "he sleeps"
      }
    , { latin  = "haadhihi l-madiina laa tanaam"
      , kana = "ハージヒ ルマディーナ ラー タナーム"
      , arabic = "هٰذِهِ ٲلْمَدينة لا تَنام"
      , meaning = "This city does not sleep."
      }
    , { latin  = "maa ra2yik"
      , kana = "マー ラ イイク"
      , arabic = "ما رَأْيِك؟"
      , meaning = "What do you think?  (Literally: What is your opinion?)"
      }
    , { latin  = "maadhaa tuHib-biin"
      , kana = "マーザー トゥヒッビーン"
      , arabic = "ماذا تُحِبّين؟"
      , meaning = "What do you like?"
      }
    , { latin  = "maadhaa 2adrus"
      , kana = "マーザー アドルス"
      , arabic = "ماذا أَدْرُس؟"
      , meaning = "What do I study?"
      }
    , { latin  = "as-saa3at ath-thaanya"
      , kana = "アッサーアト アッサーニア"
      , arabic = "اَلْسّاعة الْثّانْية"
      , meaning = "the second hour"
      }
    , { latin  = "as-saa3at ath-thaalitha"
      , kana = "アッサーアト アッサーリサ"
      , arabic = "اَلْسّاعة الْثّالِثة"
      , meaning = "the third hour"
      }
    , { latin  = "as-saa3at ar-raabi3a"
      , kana = "アッサーアト アッラービア"
      , arabic = "اَلْسّاعة الْرّابِعة"
      , meaning = "the fourth hour"
      }
    , { latin  = "as-saa3at l-khaamisa"
      , kana = "アッサーアト ル クハーミサ"
      , arabic = "اَلْسّاعة الْخامِسة"
      , meaning = "the fifth hour"
      }
    , { latin  = "as-saa3at as-saadisa"
      , kana = "アッサーアト アッサーディサ"
      , arabic = "اَلْسّاعة الْسّادِسة"
      , meaning = "the sixth hour"
      }
    , { latin  = "as-saa3at as-saabi3a"
      , kana = "アッサーアト アッサービア"
      , arabic = "اَلْسّاعة الْسّابِعة"
      , meaning = "the seventh hour"
      }
    , { latin  = "as-saa3at ath-thaamina"
      , kana = "アッサーアト アッサーミナ"
      , arabic = "اَلْسّاعة الْثّامِنة"
      , meaning = "the eighth hour"
      }
    , { latin  = "as-saa3at at-taasi3a"
      , kana = "アッサーアト アッタースィア"
      , arabic = "اَلْسّاعة الْتّاسِعة"
      , meaning = "the ninth hour"
      }
    , { latin  = "as-saa3at l-3aashira"
      , kana = "アッサーアト ル アーシラ"
      , arabic = "اَلْسّاعة الْعاشِرة"
      , meaning = "the tenth hour"
      }
    , { latin  = "as-saa3at l-Haadya 3ashara"
      , kana = "アッサーアト ル ハーディヤ アシャラ"
      , arabic = "اَلْسّاعة الْحادْية عَشَرة"
      , meaning = "the eleventh hour"
      }
    , { latin  = "as-saa3ag ath-thaanya 3ashara"
      , kana = "アッサーアト アッサーニヤ アシャラ"
      , arabic = "اَلْسّاعة الْثّانْية عَشَرة"
      , meaning = "the twelfth hour"
      }
    , { latin  = "as-saa3at l-waaHida"
      , kana = "アッサーアト ル ワーヒダ"
      , arabic = "اَلْسّاعة الْواحِدة"
      , meaning = "the hour one"
      }

    , { latin  = "as-saa3at ath-thaanya ba3d a-Dh-Dhuhr"
      , kana = "アッサーアト アッサーニヤ バァダ ッズホル"
      , arabic = "اَلْسّاعة الْثّانْية بَعْد اَلْظُّهْر"
      , meaning = "two o'clock in the afternon"
      }
    , { latin  = "2anaa min lubanaan"
      , kana = "アナー ミン ルブナーン"
      , arabic = "أنا من لبنان"
      , meaning = "I am from Lebanon."
      }
     , { latin  = "lastu min lubnaan"
       , kana = "ラストゥ ミン ルブナーン"
       , arabic = "لَسْتُ من لبنان"
       , meaning = ""
       }
    , { latin  = "lastu mariiDa"
      , kana = "ラストゥ マリーダ"
      , arabic = "لَسْتُ مَريضة"
      , meaning = ""
      }
    , { latin  = "lastu fi l-bayt"
      , kana = "ラストゥ フィル バイト"
      , arabic = "لَسْتُ في الْبَيْت"
      , meaning = "I am not home."
      }
    , { latin  = "lastu min hunaa"
      , kana = "ラストゥ ミン フナー"
      , arabic = "لَسْتُ مِن هُنا"
      , meaning = "I am not form here."
      }
    , { latin  = "qarya"
      , kana = "カリヤー"
      , arabic = "قَرية"
      , meaning = "a village"
      }
    , { latin  = "sahl"
      , kana = "サヘル"
      , arabic = "سَهل"
      , meaning = "easy"
      }
    , { latin  = "a-T-Tabii3a"
      , kana = "アッタビーア"
      , arabic = "الطَّبيعة"
      , meaning = "nature"
      }
    , { latin  = "fii 2ayy saa3a"
      , kana = "フィー アイイ サーア"
      , arabic = "في أي ساعة"
      , meaning = "at which hour, when"
      }
    , { latin  = "al-iskandariyya"
      , kana = "アル イスカンダリーヤ"
      , arabic = "الاِسكَندَرِيّة"
      , meaning = "Alexandria in Egypt"
      }
    , { latin  = "2ayna l-maHaT-Ta"
      , kana = "アイナ ル マハッタ"
      , arabic = "أَينَ المَحَطّة"
      , meaning = "Where is the station?"
      }
    , { latin  = "3aDhiim jiddan"
      , kana = "アジーム ジッダン"
      , arabic = "عَظيم جِدّاً"
      , meaning = "Fantastic!  Great!"
      }
    , { latin  = "thalaatha mar-raat fi l-2usbuu3"
      , kana = "サラーサ マッラート フィル ウスブーア"
      , arabic = "ثَلاثَ مَرّات في الأُسبوع"
      , meaning = "three times a week"
      }
    , { latin  = "2asaatidha"
      , kana = "アサーティザ"
      , arabic = "أَساتِذة"
      , meaning = "masters, professors"
      }
    , { latin  = "2ikhwa"
      , kana = "イクフワ"
      , arabic = "إِخْوة"
      , meaning = "brothers"
      }
    , { latin  = "Suura jamiila"
      , kana = "スーラ ジャミーラ"
      , arabic = "صورة جَميلة"
      , meaning = "beautiful picture"
      }
    , { latin  = "al-Hkuuma l-2amriikiya"
      , kana = "アル フクーマ ル アムリーキーヤ"
      , arabic = "الحْكومة الأَمريكية"
      , meaning = "the American government"
      }
    , { latin  = "HaDaara qadiima"
      , kana = "ハダーラ カディーマ"
      , arabic = "حَضارة قَديمة"
      , meaning = "old civilization"
      }
    , { latin  = "Salaat"
      , kana = "サラート"
      , arabic = "صَلاة"
      , meaning = "prayer, worship"
      }
    , { latin  = "zakaat"
      , kana = "ザカート"
      , arabic = "زَكاة"
      , meaning = "alms"
      }
    , { latin  = "Hayaat"
      , kana = "ハヤート"
      , arabic = "حَياة"
      , meaning = "life"
      }
    , { latin  = "ghurfat bintii"
      , kana = "グルファト ビンティー"
      , arabic = "غُرفة بِنتي"
      , meaning = "my daughter's room"
      }
    , { latin  = "madiinat nyuuyuurk"
      , kana = "マディーナト ニューユールク"
      , arabic = "مَدينة نيويورك"
      , meaning = "city of New York"
      }
    , { latin  = "sharika"
      , kana = "シャリカ"
      , arabic = "شَرِكة"
      , meaning = "a company"
      }
    , { latin  = "sharikat khaalii"
      , kana = "シャリカト クハーリー"
      , arabic = "شَرِكة خالي"
      , meaning = "my uncle's company"
      }
    , { latin  = "madrasatii"
      , kana = "マドラサティー"
      , arabic = "مَدرَسَتي"
      , meaning = "my school"
      }
    , { latin  = "3alaaqatnaa"
      , kana = "アラーカトナー"
      , arabic = "عَلاقَتنا"
      , meaning = "our relationship"
      }
    , { latin  = "shuhra"
      , kana = "シュフラ"
      , arabic = "شُهرة"
      , meaning = "fame"
      }
    , { latin  = "shufrathu"
      , kana = "シュフラトフ"
      , arabic = "شُهرَته"
      , meaning = "his fame"
      }
    , { latin  = "naz-zlnii hunaa"
      , kana = "ナッズィルニー フナー"
      , arabic = "نَزِّلني هنا"
      , meaning = "Download me here."
      }
    , { latin  = "3alaa mahlika"
      , kana = "アラー マハリカ"
      , arabic = "عَلى مَهلِكَ"
      , meaning = "Slow down. Take it easy."
      }
    , { latin  = "laysa kul-la yawm"
      , kana = "ライサ クッラ ヤウム"
      , arabic = "اَيْسَ كُلَّ يَوم"
      , meaning = "not every day"
      }
    , { latin  = "kul-l l-naas"
      , kana = "クッル ル ナース"
      , arabic = "كُلّ الناس"
      , meaning = "all the people"
      }
    , { latin  = "kul-l l-2awlaad"
      , kana = "クッル ル アウラード"
      , arabic = "كُلّ الأَولاد"
      , meaning = "all the boys, children"
      }
    , { latin  = "mayk"
      , kana = "マイク"
      , arabic = "مايْك"
      , meaning = "Mike"
      }
    , { latin  = "bikam haadhaa"
      , kana = "ビカム ハーザー"
      , arabic = "بِكَم هَذا"
      , meaning = "How much is this?"
      }
    , { latin  = "dimashq"
      , kana = "ディマシュク"
      , arabic = "دِمَشق"
      , meaning = "Damascus"
      }
    , { latin  = "2in shaa2a l-laa"
      , kana = "インシャーアッラー"
      , arabic = "إِن شاءَ اللَّه"
      , meaning = "on God's will"
      }
    , { latin  = "yal-laa"
      , kana = "ヤッラー"
      , arabic = "يَلّا"
      , meaning = "alright"
    }
    , { latin  = "3aailatii"
      , kana = "アーイラティー"
      , arabic = "عائلَتي"
      , meaning = "my family"
      }
    , { latin  = "akhbaar"
      , kana = "アクフバール"
      , arabic = "أَخبار"
      , meaning = "news"
      }
    , { latin  = "tadrsiin"
      , kana = "タドルスィーン"
      , arabic = "تَدرسين"
      , meaning = "you study"
      }
    , { latin  = "3ilm al-Haasuub"
      , kana = "アイルム アル ハースーブ"
      , arabic = "عِلم الحاسوب"
      , meaning = "computer sicence"
      }
    , { latin  = "muSawwir"
      , kana = "ムサウィル"
      , arabic = "مُصَوِّر"
      , meaning = "photographer"
      }
    , { latin  = "laa 2uHib-b-hu"
      , kana = "ラー ウヒッブフ"
      , arabic = "لا أُحِبّهُ"
      , meaning = "I do not love him."
      }
    , { latin  = "ta3mal"
      , kana = "タアマル"
      , arabic = "نَعمَل"
      , meaning = "You work, we work"
      }
    , { latin  = "2aakhar"
      , kana = "アークハル"
      , arabic = "آخَر"
      , meaning = "else, another, other than this"
      }
    , { latin  = "lawn 2aakhar"
      , kana = "ラウン アークハル"
      , arabic = "لَوت آخَر"
      , meaning = "another lot, color"
      }
    , { latin  = "rabba bayt"
      , kana = "ラッババイト"
      , arabic = "رَبّة بَيت"
      , meaning = "homemaker, housewife"
      }
    , { latin  = "baaHith"
      , kana = "バーヒス"
      , arabic = "باحِث"
      , meaning = "a researcher"
      }
    , { latin  = "last jaw3aana"
      , kana = "ラスト ジャウアーナ"
      , arabic = "لَسْت جَوعانة"
      , meaning = "I am not hungry."
      }
    , { latin  = "hal juudii mutafarrigha"
      , kana = "ハル ジューディー ムタファルリガ"
      , arabic = "هَل جودي مُتَفَرِّغة؟"
      , meaning = "Is Judy free?"
      }
    , { latin  = "nuuSf"
      , kana = "ヌースフ"
      , arabic = "نُّصْف"
      , meaning = "half"
      }
    , { latin  = "fiilm 2aflaam"
      , kana = "フィールム アフラーム"
      , arabic = "فيلم ـ أَفلام"
      , meaning = "film - films"
      }
    , { latin  = "dars duruus"
      , kana = "ダルス ドゥルース"
      , arabic = "دَرس ـ دُروس"
      , meaning = "lesson - lessons"
      }
    , { latin  = "risaala - rasaa2il"
      , kana = "リサーラ ラサーイル"
      , arabic = "رِسالة - رَسائِل"
      , meaning = "letter - letters"
      }
    , { latin  = "qariib - 2aqaarib"
      , kana = "カリーブ アカーリブ"
      , arabic = "قَريب - أَقارِب"
      , meaning = "relative - relatives"
      }
    , { latin  = "Sadiiq - 2aSdiqaa2"
      , kana = "サディーク アスディカー"
      , arabic = "صَديق - أَصْذِقاء"
      , meaning = "friend - friends"
      }
    , { latin  = "kitaab - kutub"
      , kana = "キターブ クトゥブ"
      , arabic = "كِتاب - كُتُب"
      , meaning = "book - books"
      }
    , { latin  = "lugha - lughaat"
      , kana = "ルガ ルガート"
      , arabic = "لُغة - لُغات"
      , meaning = "language - languages"
      }
    , { latin  = "tuHibb al-kitaaba"
      , kana = "トゥヒッブ アルキターバ"
      , arabic = "تُحِبّ اَلْكِتابة"
      , meaning = "She likes writing."
      }
    , { latin  = "kitaabat ar-rasaa2il mumti3a"
      , kana = "キターバト アッラサーイル ムムティア"
      , arabic = "كِتابة اَلْرَّسائِل مُمْتِعة"
      , meaning = "Writing of the letters is fun."
      }
    , { latin  = "HaaDr siidii"
      , kana = "ハードル スィーディー"
      , arabic = "حاضر سيدي"
      , meaning = "Yes, sir."
      }
    , { latin  = "waqt"
      , kana = "ワクト"
      , arabic = "وَقت"
      , meaning = "time"
      }
    , { latin  = "risaala"
      , kana = "リサーラ"
      , arabic = "رِسالة"
      , meaning = "letter"
      }
    , { latin  = "fann"
      , kana = "ファン"
      , arabic = "فَنّ"
      , meaning = "art"
      }
    , { latin  = "Haziin"
      , kana = "ハズィーン"
      , arabic = "حَزين"
      , meaning = "sad"
      }
    , { latin  = "3aa2ila"
      , kana = "アーイラ"
      , arabic = "عائِلة"
      , meaning = "family"
      }
    , { latin  = "2uHibb qiraa2at al-kutub"
      , kana = "ウヒッブ キラーアト アルクトゥブ"
      , arabic = "أُحِبّ قِراءة اَلْكُتُب"
      , meaning = "I like reading of the books."
      }
    , { latin  = "2uHibb al-qiraa2a"
      , kana = "ウヒッブ アルキラーエ"
      , arabic = "أُحِبّ اَلْقِراءة"
      , meaning = "I like the reading."
      }
    , { latin  = "al-kitaaba mumti3a"
      , kana = "アルキターバ ムムティア"
      , arabic = "اَلْكِتابة مُمْتِعة"
      , meaning = "The writing is fun."
      }
    , { latin  = "kura l-qadam"
      , kana = "クーラルカダム"
      , arabic = "كُرة اَلْقَدَم"
      , meaning = "soccer"
      }
    , { latin  = "2uHibb ad-dajaaj min 2ams"
      , kana = "ウヒッブ アッダジャージ ミン アムス"
      , arabic = "أُحِبّ اَلْدَّجاج مِن أَمْس"
      , meaning = "I like the chicken from yesterday."
      }
    , { latin  = "2uHibb ad-dajaaj"
      , kana = "ウヒッブ アッダジャージ"
      , arabic = "أُحِبّ اَلْدَّجاج"
      , meaning = "I like chicken."
      }
    , { latin  = "2uHibb al-qawha"
      , kana = "ウヒッブ アルカハワ"
      , arabic = "أُحِبّ اَلْقَهْوة"
      , meaning = "I like coffee."
      }
    , { latin  = "2uriid dajaajan"
      , kana = "ウリード ダジャージャン"
      , arabic = "أُريد دَجاجاً"
      , meaning = "I want chicken."
      }
    , { latin  = "2uriid qahwa"
      , kana = "ウリード カハワ"
      , arabic = "أُريد قَهْوة"
      , meaning = "I want coffee."
      }
    , { latin  = "2aakul dajaajan"
      , kana = "アークル ダジャージャン"
      , arabic = "آكُل دَجاجاً"
      , meaning = "I eat chicken."
      }
    , { latin  = "2ashrab qahwa kul-l SabaaH"
      , kana = "アシュラブ カハワ クッル サバーハ"
      , arabic = "أَشْرَب قَهْوة كُلّ صَباح"
      , meaning = "I drink coffee every morning."
      }
    , { latin  = "2uriid Sadiiqan"
      , kana = "ウリード サディーカン"
      , arabic = "أُريد صَديقاً"
      , meaning = "I want a friend."
      }
    , { latin  = "2aakul khubzan"
      , kana = "アークル クフブザン"
      , arabic = "آكُل خُبْزاً"
      , meaning = "I eat bread."
      }
    , { latin  = "2uriid baytan jadiidan"
      , kana = "ウリード バイタン ジャディーダン"
      , arabic = "أُريد بَيْتاً جَديداً"
      , meaning = "I want a new house."
      }
    , { latin  = "matHaf"
      , kana = "マトハフ"
      , arabic = "مَتحَف"
      , meaning = "a museum"
      }
     , { latin  = "laHm"
       , kana = "ラハム"
       , arabic = "لَحْم"
       , meaning = "meat"
       }
    , { latin  = "baTaaTaa"
      , kana = "バターター"
      , arabic = "بَطاطا"
      , meaning = "potato"
      }
    , { latin  = "yashrab al-Haliib"
      , kana = "ヤシュラブ アルハリーブ"
      , arabic = "يَشْرَب الحَليب"
      , meaning = "He drinks milk"
      }
    , { latin  = "al-muqab-bilaat"
      , kana = "アルムカッビラート"
      , arabic = "المُقَبِّلات"
      , meaning = "appetizers"
      }
    , { latin  = "Hummusan"
      , kana = "フンムサン"
      , arabic = "حُمُّصاً"
      , meaning = "chickpeas, hummus"
      }
    , { latin  = "SaHiiH"
      , kana = "サヒーハ"
      , arabic = "صَحيح"
      , meaning = "true, right, correct"
      }
    , { latin  = "3aSiir"
      , kana = "アアスィール"
      , arabic = "عَصير"
      , meaning = "juice"
      }
    , { latin  = "shuurba"
      , kana = "シュールバ"
      , arabic = "شورْبة"
      , meaning = "soupe"
      }
    , { latin  = "salaTa"
      , kana = "サラタ"
      , arabic = "سَلَطة"
      , meaning = "salad"
      }
    , { latin  = "s-saakhin"
      , kana = "ッサークヒン"
      , arabic = "سّاخِن"
      , meaning = "hot, warm"
      }
    , { latin  = "Halwaa"
      , kana = "はルワー"
      , arabic = "حَلْوى"
      , meaning = "candy, dessert"
      }
    , { latin  = "kib-ba"
      , kana = "キッバ"
      , arabic = "كِبّة"
      , meaning = "kibbeh"
      }
    , { latin  = "a-T-Tabaq"
      , kana = "アッタバク"
      , arabic = "الطَّبّق"
      , meaning = "the plate, dish"
      }
    , { latin  = "Tabaq"
      , kana = "タバク"
      , arabic = "طّبّق"
      , meaning = "plate, dish"
      }
    , { latin  = "2aina 2antum"
      , kana = "アイナアントム"
      , arabic = "أَيْن أَنْتُم"
      , meaning = "Where are you?"
      }
    , { latin  = "baaS"
      , kana = "バーすぅ"
      , arabic = "باص"
      , meaning = "bus"
      }
    , { latin  = "tadhkara"
      , kana = "たずカラ"
      , arabic = "تَذْكَرة"
      , meaning = "a ticket"
      }
    , { latin  = "Saff"
      , kana = "すぁッフ"
      , arabic = "صَفّ"
      , meaning = "class"
      }
    , { latin  = "qiTaar"
      , kana = "きたーる"
      , arabic = "قِطار"
      , meaning = "train"
      }

    ]