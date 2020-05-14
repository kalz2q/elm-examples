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
    [ { latin = "alssalaamu"
      , kana = ""
      , arabic = "اَلسَّلَامُ"
      , meaning = "peace"
      }
    , { latin = "2alaykum"
      , kana = ""
      , arabic = "عَلَيْكُمْ"
      , meaning = "on you"
      }
    , { latin = "SabaaH"
      , kana = ""
      , arabic = "صَبَاح"
      , meaning = "morning"
      }
    , { latin = "marhaban"
      , kana = ""
      , arabic = "مَرْحَبًا"
      , meaning = "Hello"
      }
    , { latin = "thaqaafah"
      , kana = ""
      , arabic = "ثَقافَة"
      , meaning = "culture"
      }
    , { latin = "2anaa bikhayr"
      , kana = ""
      , arabic = "أَنا بِخَيْر"
      , meaning = "I'm fine"
      }
    , { latin = "kabir"
      , kana = ""
      , arabic = "كَبير"
      , meaning = "large, big"
      }
    , { latin = "kabirah"
      , kana = ""
      , arabic = "كبيرة"
      , meaning = "large, big"
      }
    , { latin = "bayt"
      , kana = ""
      , arabic = "بَيْت"
      , meaning = "a house"
      }
    , { latin = "laysa"
      , kana = ""
      , arabic = "لِيْسَ"
      , meaning = "do not"
      }
    , { latin = "3and"
      , kana = ""
      , arabic = "عَنْد"
      , meaning = "have"
      }
    , { latin = "siith"
      , kana = ""
      , arabic = "سيث"
      , meaning = "Seth(male name)"
      }
    , { latin = "baluuzah"
      , kana = ""
      , arabic = "بَلوزة"
      , meaning = "blouse"
      }
    , { latin = "tii shiirt"
      , kana = ""
      , arabic = "تي شيرْت"
      , meaning = "T-shirt"
      }
    , { latin = "mi3Taf"
      , kana = ""
      , arabic = "مِعْطَف"
      , meaning = "a coat"
      }
    , { latin = "riim"
      , kana = ""
      , arabic = "ريم"
      , meaning = "Reem(name)"
      }
    , { latin = "tannuura"
      , kana = ""
      , arabic = "تَنّورة"
      , meaning = "a skirt"
      }
    , { latin = "jadiid"
      , kana = ""
      , arabic = "جَديد"
      , meaning = "new"
      }
    , { latin = "wishshaaH"
      , kana = ""
      , arabic = "وِشَاح"
      , meaning = "a scarf"
      }
    , { latin = "judii"
      , kana = ""
      , arabic = "جودي"
      , meaning = "Judy(name)"
      }
    , { latin = "jamiil"
      , kana = ""
      , arabic = "جَميل"
      , meaning = "good, nice, pretty, beautiful"
      }
    , { latin = "kalb"
      , kana = ""
      , arabic = "كَلْب"
      , meaning = "a dog"
      }
    , { latin = "2azraq"
      , kana = ""
      , arabic = "أَزْرَق"
      , meaning = "blue"
      }
    , { latin = "2abyaD"
      , kana = ""
      , arabic = "أَبْيَض "
      , meaning = "white"
      }
    , { latin = "qubb3a"
      , kana = ""
      , arabic = "قُبَّعة"
      , meaning = "a hat"
      }
    , { latin = "bunniyy"
      , kana = ""
      , arabic = "بُنِّيّ"
      , meaning = "brown"
      }
    , { latin = "mruu2a"
      , kana = ""
      , arabic = "مْروءة"
      , meaning = "chivalry"
      }
    , { latin = "kitaab"
      , kana = ""
      , arabic = "كِتاب"
      , meaning = "a book"
      }
    , { latin = "Taawilah"
      , kana = ""
      , arabic = "طاوِلة"
      , meaning = "a table"
      }
    , { latin = "hadhihi madiina qadiima"
      , kana = ""
      , arabic = "هَذِهِ مَدينة قَديمة"
      , meaning = "This is an ancient city"
      }
    , { latin = "Hadiiqa"
      , kana = ""
      , arabic = "حَديقة"
      , meaning = "garden"
      }
    , { latin = "hadhihi HadiiqA 3arabyya"
      , kana = ""
      , arabic = "هَذِهِ حَديقة عَرَبيّة"
      , meaning = "This is an Arab garden"
      }
    , { latin = "hadhihi binaaya jamiila"
      , kana = ""
      , arabic = "هَذِهِ بِناية جَميلة"
      , meaning = "This is a beautiful building"
      }
    , { latin = "hadhaa muhammad"
      , kana = ""
      , arabic = "هَذا مُحَمَّد"
      , meaning = "This is mohamed"
      }
    , { latin = "hadhihi HadiiqA jamiila"
      , kana = ""
      , arabic = "هَذِهِ حَديقة جَميلة"
      , meaning = "This is a pretty garden"
      }
    , { latin = "hadhihi HadiiqA qadiima"
      , kana = ""
      , arabic = "هَذِهِ حَديقة قَديمة"
      , meaning = "This is an old garden"
      }
    , { latin = "alHa2iT"
      , kana = ""
      , arabic = "الْحائط"
      , meaning = "the wall"
      }
    , { latin = "Ha2iT"
      , kana = ""
      , arabic = "حائِط"
      , meaning = "wall"
      }
    , { latin = "hadhaa alHaa2iT kabiir"
      , kana = ""
      , arabic = "هَذا الْحائِط كَبير "
      , meaning = "this wall is big"
      }
    , { latin = "alkalb"
      , kana = ""
      , arabic = "الْكَلْب"
      , meaning = "the dog"
      }
    , { latin = "hadhihi albinaaya"
      , kana = ""
      , arabic = "هذِهِ الْبِناية "
      , meaning = "this building"
      }
    , { latin = "al-ghurfa"
      , kana = ""
      , arabic = "اَلْغُرفة"
      , meaning = "the room"
      }
    , { latin = "alghurfA kaBiira"
      , kana = ""
      , arabic = "اَلْغرْفة كَبيرة"
      , meaning = "Theroom is big"
      }
    , { latin = "hadhihi alghurfa kabiira"
      , kana = ""
      , arabic = "هَذِهِ الْغُرْفة كَبيرة"
      , meaning = "this room is big"
      }
    , { latin = "hadhaa alkalb kalbii"
      , kana = ""
      , arabic = "هَذا  الْكَلْب كَْلبي"
      , meaning = "this dog is my dog"
      }
    , { latin = "hadhaa alkalb jaw3aan"
      , kana = ""
      , arabic = "هَذا الْكَلْب جَوْعان"
      , meaning = "this dog is hungry"
      }
    , { latin = "hadhihi albinaaya waas3a"
      , kana = ""
      , arabic = "هَذِهِ الْبناية واسِعة"
      , meaning = "this building is spacious"
      }
    , { latin = "alkalb ghariib"
      , kana = ""
      , arabic = "اَلْكَلْب غَريب"
      , meaning = "The dog is weird"
      }
    , { latin = "alkalb kalbii"
      , kana = ""
      , arabic = "اَلْكَلْب كَلْبي"
      , meaning = "The dog is my dog"
      }
    , { latin = "hunaak"
      , kana = ""
      , arabic = "هُناك"
      , meaning = "there"
      }
    , { latin = "hunaak bayt"
      , kana = ""
      , arabic = "هُناك بَيْت"
      , meaning = "There is a house"
      }
    , { latin = "albayt hunaak"
      , kana = ""
      , arabic = "اَلْبَيْت هُناك"
      , meaning = "The house is there"
      }
    , { latin = "hunaak wishaaH 2abyaD"
      , kana = ""
      , arabic = "هُناك وِشاح أبْيَض"
      , meaning = "There is a white scarf"
      }
    , { latin = "alkalb munaak"
      , kana = ""
      , arabic = "اَلْكَلْب مُناك"
      , meaning = "The dog is there"
      }
    , { latin = "fii shanTatii"
      , kana = ""
      , arabic = "في شَنْطَتي"
      , meaning = "in my bag"
      }
    , { latin = "hal 3indak maHfaDHA yaa juurj"
      , kana = ""
      , arabic = "هَل عِنْدَك مَحْفَظة يا جورْج"
      , meaning = "do you have a wallet , george"
      }
    , { latin = "3indii shanTa ghaalya"
      , kana = ""
      , arabic = "عِنْدي شَنْطة غالْية"
      , meaning = "I have an expensive bag"
      }
    , { latin = "shanTatii fii shanTatik ya raanya"
      , kana = ""
      , arabic = "شِنْطَتي في شَنْطتِك يا رانْيا"
      , meaning = "my bag is in your bag rania"
      }
    , { latin = "huunak maHfaDhA Saghiira"
      , kana = ""
      , arabic = "هُناك مَحْفَظة صَغيرة"
      , meaning = "There is a small wallet"
      }
    , { latin = "hunaak kitab jadiid"
      , kana = ""
      , arabic = "هَناك كِتاب جَديد"
      , meaning = "There is a new book"
      }
    , { latin = "hunaak kitaab Saghiir"
      , kana = ""
      , arabic = "هُناك كِتاب صَغير"
      , meaning = "There is a small book"
      }
    , { latin = "hunaak qubba3A fii shanTatak yaa bob"
      , kana = ""
      , arabic = "هُناك قُبَّعة في شَنْطَتَك يا بوب"
      , meaning = "There is a hat in your bag bob"
      }
    , { latin = "hunaak shanTa Saghiira"
      , kana = ""
      , arabic = "هُناك شَنْطة صَغيرة"
      , meaning = "There is a small bag"f
      }
    , { latin = "shanTatii hunaak"
      , kana = ""
      , arabic = "شَنْطَتي هُناك"
      , meaning = "my bag is over there"
      }
    , { latin = "hunaak kitaab Saghiir wawishaaH Kabiir fii ShanTatii"
      , kana = ""
      , arabic = "هُناك كِتاب صَغير وَوِشاح كَبير في شَنْطَتي"
      , meaning = "There is a small book and a big scarf in my bag"
      }
    , { latin = "hunaak maHfaTa Saghiir fii ShanTatii"
      , kana = ""
      , arabic = "هُناك مَحْفَظة صَغيرة في شَنْطَتي"
      , meaning = "There is a small wallet in my bag"
      }
    , { latin = "aljaami3a hunaak"
      , kana = ""
      , arabic = "اَلْجامِعة هُناك"
      , meaning = "The university is there"
      }
    , { latin = "hunaak kitaab"
      , kana = ""
      , arabic = "هُناك كِتاب"
      , meaning = "There is a book"
      }
    , { latin = "almadiina hunaak"
      , kana = ""
      , arabic = "اَلْمَدينة هُناك"
      , meaning = "Thecity is there"
      }
    , { latin = "hal 3indik shanTa ghaalya ya Riim"
      , kana = ""
      , arabic = "هَل عِندِك شَنْطة غالْية يا ريم"
      , meaning = "do you have an expensive bag Reem"
      }
    , { latin = "hal 3indik mashruub ya saamya"
      , kana = ""
      , arabic = "هَل عِنْدِك مَشْروب يا سامْية"
      , meaning = "do you have a drink samia"
      }
    , { latin = "hunaak daftar rakhiiS"
      , kana = ""
      , arabic = "هُناك دَفْتَر رَخيص"
      , meaning = "There is a cheep notebook"
      }
    , { latin = "laysa 3indii daftar"
      , kana = ""
      , arabic = "لَيْسَ عِنْدي دَفْتَر"
      , meaning = "I do not have a notebook"
      }
    , { latin = "laysa hunaak masharuub fii shanTatii"
      , kana = ""
      , arabic = "لَيْسَ هُناك مَشْروب في شَنْطَتي"
      , meaning = "There is no drink in my bag"
      }
    , { latin = "laysa hunaak kitaab qaSiir fii baytii"
      , kana = "ライサ フナーク キターブ カスィール フィー バイティ"
      , arabic = "لَيْسَ هُناك كِتاب قَصير في بَيْتي"
      , meaning = "There is no short book in my house"
      }
    , { latin = "laysa hunaak daftar rakhiiS"
      , kana = ""
      , arabic = "لَيْسَ هُناك دَفْتَر رَخيص"
      , meaning = "There is no cheap notebook"
      }
    , { latin = "laysa 3indii sii dii"
      , kana = ""
      , arabic = "لَيْسَ عَنْدي سي دي"
      , meaning = "I do not have a CD"
      }
    , { latin = "laysa hunaak qalam fii shanTatii"
      , kana = ""
      , arabic = "لَيْسَ هُناك قَلَم في شَنْطَتي"
      , meaning = "There is no pen in my bag"
      }
    , { latin = "laysa hunaak kitaab qaSiir fii shanTatii"
      , kana = ""
      , arabic = "لَيْسَ هُناك كِتاب قَصير في شَنْطَتي"
      , meaning = "There is no short book in my bag"
      }
    , { latin = "laysa hunaak daftar 2abyaD"
      , kana = ""
      , arabic = "لَيْسَ هُناك دَفْتَر أَبْيَض"
      , meaning = "There is no white notebook."
      }
    , { latin = "maTbakh"
      , kana = ""
      , arabic = "مَطْبَخ"
      , meaning = "a kitchen"
      }
    , { latin = "3ilka"
      , kana = ""
      , arabic = "عِلْكة"
      , meaning = "gum"
      }
    , { latin = "miftaaH"
      , kana = ""
      , arabic = "مفْتاح"
      , meaning = "a key"
      }
    , { latin = "tuub"
      , kana = ""
      , arabic = "توب"
      , meaning = "top"
      }
    , { latin = "nuquud"
      , kana = ""
      , arabic = "نُقود"
      , meaning = "money"
      }
    , { latin = "aljazeera"
      , kana = ""
      , arabic = "الجزيرة"
      , meaning = "Al Jazeera"
      }
    , { latin = "kursii"
      , kana = ""
      , arabic = "كَرْسي"
      , meaning = "a chair"
      }
    , { latin = "sari3"
      , kana = ""
      , arabic = "سَريع"
      , meaning = "fast"
      }
    , { latin = "Haasuub"
      , kana = ""
      , arabic = "حاسوب"
      , meaning = "a computer"
      }
    , { latin = "maktab"
      , kana = ""
      , arabic = "مَكْتَب"
      , meaning = "office"
      }
    , { latin = "hadhaa maktab kabiir"
      , kana = ""
      , arabic = "هَذا مَِكْتَب كَبير"
      , meaning = "This is a big office"
      }
    , { latin = "kursii alqiTTa"
      , kana = ""
      , arabic = "كُرْسي الْقِطّة"
      , meaning = "the cat's chair"
      }
    , { latin = "Haasuub al2ustaadha"
      , kana = ""
      , arabic = "حاسوب اَلْأُسْتاذة"
      , meaning = "professor's computer"
      }
    , { latin = "kursii jadiid"
      , kana = ""
      , arabic = "كُرْسي جَديد"
      , meaning = "a new chair"
      }
    , { latin = "alHamdu lilh"
      , kana = ""
      , arabic = "اَلْحَمْدُ لِله"
      , meaning = "Praise be to God"
      }
    , { latin = "SaHiifa"
      , kana = ""
      , arabic = "صَحيفة"
      , meaning = "newspaper"
      }
    , { latin = "raqam"
      , kana = ""
      , arabic = "رَقَم"
      , meaning = "number"
      }
    , { latin = "haatif"
      , kana = ""
      , arabic = "هاتِف"
      , meaning = "phone"
      }
    , { latin = "2amriikiyy"
      , kana = ""
      , arabic = "أمْريكِي"
      , meaning = "American"
      }
    , { latin  = "2amriikaa wa-a-S-Siin"
      , kana = ""
      , arabic = "أَمْريكا وَالْصّين"
      , meaning = "America and China"
      }
    , { latin  = "qahwa"
      , kana = ""
      , arabic = "قَهْوة"
      , meaning = "coffee"
      }
    , { latin  = "Haliib"
      , kana = ""
      , arabic = "حَليب"
      , meaning = "milk"
      }
    , { latin  = "muuza"
      , kana = ""
      , arabic = "موزة"
      , meaning = "a banana"
      }
    , { latin  = "2akl"
      , kana = ""
      , arabic = "أَكْل"
      , meaning = "food"
      }
    , { latin  = "2akl 3arabyy waqahwA 3arabyy"
      , kana = ""
      , arabic = "أَكْل عَرَبيّ وَقَهْوة عَرَبيّة"
      , meaning = "Arabic food and Arabic coffee"
      }
    , { latin  = "ruzz"
      , kana = ""
      , arabic = "رُزّ"
      , meaning = "rice"
      }
    , { latin  = "ruzzii waqahwatii"
      , kana = ""
      , arabic = "رُزّي وَقَهْوَتي"
      , meaning = "my rice and my coffee"
      }
     , { latin  = "qahwatii fii shanTatii"
       , arabic = "قَهْوَتي في  شَنْطَتي"
       , meaning = "My coffee is in my bag"
       }
     , { latin  = "qahwaA siith"
       , arabic = "قَهْوَة  سيث"
       , meaning = "Seth's coffee"
       }
    , { latin  = "Sadiiqathaa"
      , kana = ""
      , arabic = "صَديقَتها"
      , meaning = "her friend"
      }
    , { latin  = "jaarat-haa"
      , kana = ""
      , arabic = "جارَتها"
      , meaning = "her neighbor"
      }
    , { latin  = "2a3rif"
      , kana = ""
      , arabic = "أَعْرِف"
      , meaning = "I know ..."
      }
    , { latin  = "2ukhtii"
      , kana = ""
      , arabic = "أُخْتي"
      , meaning = "my sister"
      }
    , { latin  = "Sadiiqa Jayyida"
      , kana = ""
      , arabic = "صَديقة  جَيِّدة"
      , meaning = "a good friend"
      }أ
     , { latin  = "2a3rif"
       , arabic = "أَعْرِف"
       , meaning = "I know"
       }
    , { latin  = "2anaa 2a3rifhu"
      , kana = ""
      , arabic = "أَنا أَعْرِفه"
      , meaning = "I know him"
      }
    , { latin  = "Taaawila Tawiila"
      , kana = ""
      , arabic = "طاوِلة طَويلة"
      , meaning = "long table"
      }
    , { latin  = "baytik wabaythaa"
      , kana = ""
      , arabic = "بَيْتِك وَبَيْتها"
      , meaning = "your house and her house"
      }
    , { latin  = "ism Tawiil"
      , kana = ""
      , arabic = "اِسْم طَويل"
      , meaning = "long name"
      }
    , { latin  = "baytii wabaythaa"
      , kana = ""
      , arabic = "بَيْتي وَبَيْتها"
      , meaning = "my house and her house"
      }
    , { latin  = "laysa hunaak lugha Sa3ba"
      , kana = ""
      , arabic = "لَيْسَ هُناك لُغة صَعْبة"
      , meaning = "There is no diffcult language."
      }
    , { latin  = "hadhaa shay2 Sa3b"
      , kana = ""
      , arabic = "هَذا شَيْء صَعْب"
      , meaning = "This is a difficult thing."
      }
    , { latin  = "ismhu taamir"
      , kana = ""
      , arabic = "اِسْمهُ تامِر"
      , meaning = "His name is Tamer."
      }
    , { latin  = "laa 2a3rif 2ayn bayt-hu"
      , kana = ""
      , arabic = "لا أَعْرِف أَيْن بَيْته"
      , meaning = "I don't know where his house is"
      }
    , { latin  = "laa 2a3rif 2ayn 2anaa"
      , kana = ""
      , arabic = "لا أعرف أين أنا."
      , meaning = "I don't know where I am."
      }
    , { latin  = "baythu qariib min aljaami3at"
      , kana = ""
      , arabic = "بيته قريب من الجامعة"
      , meaning = "His house is close to the university"
      }
    , { latin  = "ismhaa arabyy"
      , kana = ""
      , arabic = "إسمها عربي"
      , meaning = "Her name is arabic."
      }
    , { latin  = "Sadiiqathu ruuzaa qariibhu min baythu"
      , kana = ""
      , arabic = "صديقته روزا قريبه من بيته"
      , meaning = "His friend Rosa is close to his house."
      }
    , { latin  = "ismhu Tawiil"
      , kana = ""
      , arabic = "إسمه طويل"
      , meaning = "His name is long."
      }
    , { latin  = "riim Sadiiqat Sa3bat"
      , kana = ""
      , arabic = "ريم صديقة صعبة"
      , meaning = "Reem is a difficult friend."
      }      
    , { latin  = "ismhu bashiir"
      , kana = ""
      , arabic = "إسمه بشير"
      , meaning = "HIs name is Bashir."
      }      
    , { latin  = "ismhaa Tawiil"
      , kana = ""
      , arabic = "إسمها طويل"
      , meaning = "Her name is long."
      }      
    , { latin  = "Sadiiqhaa buub qariib min baythaa"
      , kana = ""
      , arabic = "صديقها بوب قريب من بيتها"
      , meaning = "Her friend Bob is close to her house."
      } 
    , { latin  = "ismhu bob"
      , kana = ""
      , arabic = "إسمه بوب"
      , meaning = "His name is Bob."
      }
    , { latin  = "baythu qariib min baythaa"
      , kana = ""
      , arabic = "بيته قريب من بيتها"
      , meaning = "His house is close to her house."
      }
    , { latin  = "hadhaa shay2 Sa3b"
      , kana = ""
      , arabic = "هذا شيء صعب"
      , meaning = "This is a difficult thing."
      }
    , { latin  = "3alaaqa"
      , kana = ""
      , arabic = "عَلاقَة"
      , meaning = "relationship"
      }
    , { latin  = "alqiTTa"
      , kana = ""
      , arabic = "اَلْقِطّة"
      , meaning = "the cat"
      }
    , { latin  = "la 2uhib"
      , kana = ""
      , arabic = "لا أُحِب"
      , meaning = "I do not like"
      }
    , { latin  = "al2akl mumti3"
      , kana = ""
      , arabic = "اَلْأَكْل مُمْتع"
      , meaning = "Eating is fun."
      }
    , { latin  = "alqiraa2a"
      , kana = ""
      , arabic = "اَلْقِراءة"
      , meaning = "reading"
      }
    , { latin  = "alkitaaba"
      , kana = ""
      , arabic = "الْكِتابة"
      , meaning = "writing"
      }
    , { latin  = "alkiraa2a wa-alkitaaba"
      , kana = ""
      , arabic = "اَلْقِراءة وَالْكِتابة"
      , meaning = "reading and writing"
      }
    , { latin  = "muhimm"
      , kana = ""
      , arabic = "مُهِمّ"
      , meaning = "important"
      }
    , { latin  = "alkiaaba shay2 muhimm"
      , kana = ""
      , arabic = "اَلْكِتابة شَيْء مُهِمّ"
      , meaning = "Writing is an important thing."
      }
    , { latin  = "aljara wa-alqiTTa"
      , kana = ""
      , arabic = "اَلْجارة وَالْقِطّة"
      , meaning = "the neighbor and the cat"
      }
    , { latin  = "qiTTa wa-alqiTTa"
      , kana = ""
      , arabic = "قِطّة وَالْقِطّة"
      , meaning = "a cat and the cat"
      }
    , { latin  = "2ayDaan"
      , kana = ""
      , arabic = "أَيْضاً"
      , meaning = "also"
      }
    , { latin  = "almaT3m"
      , kana = ""
      , arabic = "الْمَطْعْم"
      , meaning = "the restaurant"
      }
    , { latin  = "aljarii"
      , kana = ""
      , arabic = "اَلْجَري"
      , meaning = "the running"
      }
    , { latin  = "maa2"
      , kana = ""
      , arabic = "ماء"
      , meaning = "water"
      }
    , { latin  = "maT3am"
      , kana = ""
      , arabic = "مَطْعَم"
      , meaning = "a restaurant"
      }
    , { latin  = "alttaSwiir"
      , kana = ""
      , arabic = "اَلْتَّصْوير"
      , meaning = "photography"
      }
    , { latin  = "alnnawm"
      , kana = ""
      , arabic = "اَلْنَّوْم"
      , meaning = "sleeping"
      }
    , { latin  = "as-sibaaha"
      , kana = ""
      , arabic = "اَلْسِّباحة"
      , meaning = "swimming"
      }
    , { latin  = "Sabaahaan 2uhibb al2akl hunaa"
      , kana = ""
      , arabic = "صَباحاً أُحِبّ اَلْأَكْل هُنا"
      , meaning = "Inn the morning, I like eating here."
      }
    , { latin  = "kathiiraan"
      , kana = ""
      , arabic = "كَثيراً"
      , meaning = "much"
      }
    , { latin  = "hunaa"
      , kana = ""
      , arabic = "هُنا"
      , meaning = "here"
      }
    , { latin  = "jiddan"
      , kana = ""
      , arabic = "جِدَّاً"
      , meaning = "very"
      }
    , { latin  = "3an"
      , kana = ""
      , arabic = "عَن"
      , meaning = "about"
      }      
    , { latin  = "2uhibb al-ssafar 2ilaa 2iiiTaaliiaa"
      , kana = ""
      , arabic = "أُحِبّ اَلْسَّفَر إِلى إيطالْيا"
      , meaning = "I like traveling to Italy."
      }      
    , { latin  = "alkalaam ma3a 2abii"
      , kana = ""
      , arabic = "اَلْكَلام مَعَ أَبي"
      , meaning = "talking with my father"
      }      
    , { latin  = "alkalaam ma3a 2abii ba3d alDHDHahr"
      , kana = ""
      , arabic = "اَلْكَلام معَ أَبي بَعْد اَلْظَّهْر"
      , meaning = "talking with my father in the afternoon"
      }
    , { latin  = "2uHibb aljarii bialllyl"
      , kana = ""
      , arabic = "أُحِبّ اَلْجَري بِالْلَّيْل"
      , meaning = "I like running at night."
      }
    , { latin  = "2uriidu"
      , kana = ""
      , arabic = "أُريدُ"
      , meaning = "I want"
      }
    , { latin  = "2uHibb 2iiiTaaliiaa 2ayDan"
      , kana = ""
      , arabic = "أُحِبّ إيطاليا أَيْضاً"
      , meaning = "I like Italy also."
      }
    , { latin  = "2uHibb alnnawm ba3d alDHDHhr"
      , kana = ""
      , arabic = "أحِبّ اَلْنَّوْم بَعْد اَلْظَّهْر"
      , meaning = "I like sleeping in the afternoon."
      }
    , { latin  = "2uHibb alqiraa2a 3an kuubaa biaalllayl"
      , kana = ""
      , arabic = "أُحِبّ اَلْقِراءة عَن كوبا بِالْلَّيْل"
      , meaning = "I like to read about Cuba at night."
      }
    , { latin  = "2uHibb alkalaam 3an alkitaaba"
      , kana = ""
      , arabic = "أحِبّ اَلْكَلام عَن اَلْكِتابة"
      , meaning = "I like talking about writing."
      }
    , { latin  = "alqur2aan"
      , kana = ""
      , arabic = "اَلْقُرْآن"
      , meaning = "Koran"
      }
    , { latin  = "bayt jamiil"
      , kana = ""
      , arabic = "بَيْت جَميل"
      , meaning = "a pretty house"
      }
    , { latin  = "bint suuriyya"
      , kana = ""
      , arabic = "بِنْت سورِيّة"
      , meaning = "a Syrian girl"
      }
    , { latin  = "mutarjim mumtaaz"
      , kana = ""
      , arabic = "مُتَرْجِم مُمْتاز"
      , meaning = "an amazing translator"
    }
    , { latin  = "jaami3a mashhuura"
      , kana = ""
      , arabic = "جامِعة مَشْهورة"
      , meaning = "a famous university"
      }
    , { latin  = "al-bayt al-jamiil"
      , kana = ""
      , arabic = "اَلْبَيْت اَلْجَميل"
      , meaning = "the pretty house"
      }
    , { latin  = "al-bint al-ssuuriyya"
      , kana = ""
      , arabic = "اَلْبِنْت اَلْسّورِيّة"
      , meaning = "a Syrian girl"
      }
    , { latin  = "al-mutarjim al-mumtaaz"
      , kana = ""
      , arabic = "اَلْمُتَرْجِم اَلْمُمْتاز"
      , meaning = "the amazing translator"
      }
    , { latin  = "al-jaami3a al-mashhuura"
      , kana = ""
      , arabic = "اَلْجامِعة اَلْمَشْهورة"
      , meaning = "the famous university"
      }
    , { latin  = "al-bayt jamiil"
      , kana = ""
      , arabic = "اَلْبَيْت جَميل"
      , meaning = "The house is pretty."
      }
    , { latin  = "al-bint suuriyya"
      , kana = ""
      , arabic = "البنت سورِيّة"
      , meaning = "The girl is Syrian."
      }
    , { latin  = "al-mutarjim mumtaaz"
      , kana = ""
      , arabic = "اَلْمُتَرْجِم مُمْتاز"
      , meaning = "The translator is amazing."
      }
    , { latin  = "al-jaami3a mashhuura"
      , kana = ""
      , arabic = "اَلْجامِعة مَشْهورة"
      , meaning = ""
      }
    , { latin  = "Haarr"
      , kana = ""
      , arabic = "حارّ"
      , meaning = "hot"
      }
    , { latin  = "maTar"
      , kana = ""
      , arabic = "مَطَر"
      , meaning = "rain"
      }
    , { latin  = "yawm Tawiil"
      , kana = ""
      , arabic = "يَوْم طَويل"
      , meaning = "a long day"
      }
    , { latin  = "Taqs baarid"
      , kana = ""
      , arabic = "طَقْس بارِد"
      , meaning = "cold weather"
      }
    , { latin  = "haathaa yawm Tawiil"
      , kana = ""
      , arabic = "هَذا يَوْم طَويل"
      , meaning = "This is a long day."
      }
    , { latin  = "shanTa fafiifa"
      , kana = ""
      , arabic = "شَنْطة خَفيفة"
      , meaning = "a light bag"
      }
    , { latin  = "mi3Taf khafiif"
      , kana = ""
      , arabic = "مِعْطَف خَفيف"
      , meaning = "a light coat"
      }
    , { latin  = "al-maTar al-ththaqiil mumtaaz"
      , kana = ""
      , arabic = "اَلْمَطَر اَلْثَّقيل مُمْتاز"
      , meaning = "The heavy rain is amazing."
      }
    , { latin  = "Taqs ghariib"
      , kana = ""
      , arabic = "طَقْس غَريب"
      , meaning = "a weird weather"
      }
    , { latin  = "yawm Haarr"
      , kana = ""
      , arabic = "يَوْم حارّ"
      , meaning = "a hot day"
      }
    , { latin  = "maTar khafiif"
      , kana = ""
      , arabic = "مَطَر خفيف"
      , meaning = "a light rain"
      }
    , { latin  = "Taawila khafiifa"
      , kana = ""
      , arabic = "طاوِلة خَفيفة"
      , meaning = "a light table"
      }
    , { latin  = "Taqs jamiil"
      , kana = ""
      , arabic = "طَقْس جَميل"
      , meaning = "a pretty weather"
      }
    , { latin  = "al-maTar al-ththaqiil mumtaaz"
      , kana = ""
      , arabic = "اَلْمَطَر اَلْثَّقيل مُمْتاز"
      , meaning = "The heavy rain is amazing."
      }
    , { latin  = "haathaa yawm Haarr"
      , kana = ""
      , arabic = "هَذا يَوْم حارّ"
      , meaning = "This is a hot day."
      }
    , { latin  = "shanTa khafiifa"
      , kana = ""
      , arabic = "شَنْطة خَفيفة"
      , meaning = "a light bag"
      }
    , { latin  = "hunaak maTar baarid jiddan"
      , kana = ""
      , arabic = "هُناك مَطَر بارِد جِدّاً"
      , meaning = "There is a very cold rain."
      }
    , { latin  = "Sayf"
      , kana = "サイフ"
      , arabic = "صّيْف"
      , meaning = "summer"
      }
    , { latin  = "shitaa2"
      , kana = ""
      , arabic = "شِتاء"
      , meaning = "winter"
      }
    , { latin  = "thitaa2 baarid"
      , kana = ""
      , arabic = "شِتاء بارِد"
      , meaning = "cold winter"
      }
    , { latin  = "binaaya 3aalya"
      , kana = ""
      , arabic = "بِناية عالْية"
      , meaning = "a high building"
      }
    , { latin  = "yawm baarid"
      , kana = ""
      , arabic = "يَوْم بارِد"
      , meaning = "a cold day"
      }
    , { latin  = "ruTwwba 3aalya"
      , kana = ""
      , arabic = "رُطوبة عالْية"
      , meaning = "high humidity"
      }
    , { latin  = "al-rruTuuba al-3aalya"
      , kana = ""
      , arabic = "اَلْرَّطوبة الْعالْية"
      , meaning = "the high humidity"
      }
    , { latin  = "Sayf mumTir"
      , kana = ""
      , arabic = "صَيْف مُمْطِر"
      , meaning = "a rainy summer"
      }
    , { latin  = "al-rruTuuba al3aalya"
      , kana = ""
      , arabic = "اَلْرُّطوبة الْعالْية"
      , meaning = "the high humidity"
      }
    , { latin  = "al-TTaqs al-mushmis"
      , kana = ""
      , arabic = "اّلْطَّقْس الّْمُشْمِس"
      , meaning = "the sunny weather"
      }
    , { latin  = "shitaa2 mumTir"
      , kana = ""
      , arabic = "شِتاء مُمْطِر"
      , meaning = "a rainy winter"
      }      
    , { latin  = "Sayf Haarr"
      , kana = ""
      , arabic = "صَيْف حارّ"
      , meaning = "a hot summer"
      }      
    , { latin  = "al-yawm yawm Tawiil"
      , kana = ""
      , arabic = "اَلْيَوْم يَوْم طَويل"
      , meaning = "Today is a long day."
      }      
    , { latin  = "laa 2uhibb al-Taqs al-mushmis"
      , kana = ""
      , arabic = "لا أُحِبّ اَلْطَقْس اَلْمُشْمِس"
      , meaning = "I do not like sunny weather."
      }      
    , { latin  = "al-Taqs mumTir jiddan al-yawm"
      , kana = ""
      , arabic = "اَلْطَقْس مُمْطِر جِدّاً اَلْيَوْم"
      , meaning = "The weather is very rainy today."
      }
    , { latin  = "laa 2uhibb al-TTaqs al-mumTir"
      , kana = ""
      , arabic = "لا أحِبّ اَلْطَّقْس اَلْمُمْطِر"
      , meaning = "I do not like the rainy weather."
      }
    , { latin  = "al-TTaqs mushmis al-yawm"
      , kana = ""
      , arabic = "اَلْطَّقْس مُشْمِس اَلْيَوْم"
      , meaning = "The weather is sunny today."
      }
    , { latin  = "khariif"
      , kana = "ハリーフ"
      , arabic = "خَريف"
      , meaning = "fall, autumn"
      }
    , { latin  = "qamar"
      , kana = ""
      , arabic = "قَمَر"
      , meaning = "moon"
      }
    , { latin  = "rabiir"
      , kana = ""
      , arabic = "رَبيع"
      , meaning = "spring"
      }
    , { latin  = "al-shishitaa2 mumTir"
      , kana = ""
      , arabic = "اَلْشِّتاء مُمْطِر"
      , meaning = "The winter is rainy."
      }
    , { latin  = "al-SSayf al-baarid"
      , kana = ""
      , arabic = "اَلْصَّيْف اَلْبارِد"
      , meaning = "the cold summer"
      }
    , { latin  = "al-qamar al-2abyab"
      , kana = ""
      , arabic = "اَلْقَمَر اَلْأَبْيَض"
      , meaning = "the white moon"
      }
    , { latin  = "al-shishitaa2 Tawiil wa-baarid"
      , kana = ""
      , arabic = "اَلْشِّتاء طَويل وَبارِد"
      , meaning = "The winter is long and cold."
      }
    , { latin  = "al-rrabii3 mumTir al-aan"
      , kana = ""
      , arabic = "اَلْرَّبيع مُمْطِر اَلآن"
      , meaning = "The winter is rainy now"
      }
    , { latin  = "Saghiir"
      , kana = ""
      , arabic = "صَغير"
      , meaning = "small"
      }
    , { latin  = "kashiiran"
      , kana = ""
      , arabic = "كَثيراً"
      , meaning = "a lot, much"
      }
    , { latin  = "al-ssuudaan"
      , kana = ""
      , arabic = "اَلْسّودان"
      , meaning = "Sudan"
      }
    , { latin  = "as-siin"
      , kana = ""
      , arabic = "اَلْصّين"
      , meaning = "China"
      }
    , { latin  = "al-qaahira"
      , kana = ""
      , arabic = "اَلْقاهِرة"
      , meaning = "Cairo"
      }
    , { latin  = "al-bunduqiyya"
      , kana = ""
      , arabic = "اَلْبُنْدُقِية"
      , meaning = "Venice"
      }
    , { latin  = "filasTiin"
      , kana = ""
      , arabic = "فِلَسْطين"
      , meaning = "Palestine"
      }
    , { latin  = "huulandaa"
      , kana = ""
      , arabic = "هولَنْدا"
      , meaning = "Netherlands"
      }
    , { latin  = "baghdaad"
      , kana = ""
      , arabic = "بَغْداد"
      , meaning = "Bagdad"
      }
    , { latin  = "Tuukyuu"
      , kana = ""
      , arabic = "طوكْيو"
      , meaning = "Tokyo"
      }
    , { latin  = "al-yaman"
      , kana = ""
      , arabic = "اَلْيَمَن"
      , meaning = "Yemen"
      }
    , { latin  = "SaaHil Tawiil"
      , kana = ""
      , arabic = "ساحَل طَويل"
      , meaning = "a long coast"
      }
    , { latin  = "al-2urdun"
      , kana = ""
      , arabic = "اَلْأُرْدُن"
      , meaning = "Jordan"
      }      
    , { latin  = "haathaa al-balad"
      , kana = ""
      , arabic = "هَذا الْبَلَد"
      , meaning = "this country"
      }      
    , { latin  = "2ayn baladik yaa riim"
      , kana = ""
      , arabic = "أَيْن بَلَدِك يا ريم"
      , meaning = "Where is your country, Reem?"
      }      
    , { latin  = "baldii mumtaaz"
      , kana = ""
      , arabic = "بَلَدي مُمْتاز"
      , meaning = "My country is amazing."
      }      
    , { latin  = "haathaa balad-haa"
      , kana = ""
      , arabic = "هَذا بَلَدها"
      , meaning = "This is her country."
      }      
    , { latin  = "hal baladak jamiil yaa juurj?"
      , kana = ""
      , arabic = "هَل بَلَدَك جَميل يا جورْج"
      , meaning = "Is your country pretty, George"
      }
    , { latin  = "al-yaman balad Saghiir"
      , kana = ""
      , arabic = "اَلْيَمَن بَلَد صَغير"
      , meaning = "Yemen is a small country."
      }
    , { latin  = "qaari2"
      , kana = ""
      , arabic = "قارِئ"
      , meaning = "reader"
      }
    , { latin  = "ghaa2ib"
      , kana = ""
      , arabic = "غائِب"
      , meaning = "absent"
      }
    , { latin  = "mas2uul"
      , kana = ""
      , arabic = "مَسْؤول"
      , meaning = "responsoble, administrator"
      }
    , { latin  = "jaa2at"
      , kana = ""
      , arabic = "جاءَت"
      , meaning = "she came"
      }
    , { latin  = "3indii"
      , kana = ""
      , arabic = "عِنْدي"
      , meaning = "I have"
      }
    , { latin  = "3indik"
      , kana = ""
      , arabic = "عِنْدِك"
      , meaning = "you have"
      }
    , { latin  = "ladii kitaab"
      , kana = ""
      , arabic = "لَدي كِتاب"
      , meaning = "I have a book."
      }
    , { latin  = "3indhaa"
      , kana = ""
      , arabic = "عِنْدها"
      , meaning = "she has"
      }      
    , { latin  = "3indhu"
      , kana = ""
      , arabic = "عِنْدهُ"
      , meaning = "he has"
      }      
    , { latin  = "laysa 3indhu"
      , kana = ""
      , arabic = "لَيْسَ عِنْدهُ"
      , meaning = "he does not have"
      }      
    , { latin  = "laysa 3indhaa"
      , kana = ""
      , arabic = "لَيْسَ عِنْدها"
      , meaning = "she does not have"
      }      
    , { latin  = "hunaak maTar thaqiil"
      , kana = ""
      , arabic = "هُناك مَطَر ثَقيل"
      , meaning = "There is a heavy rain."
      }
    , { latin  = "hunaak wishaaH fii shanTatii"
      , kana = ""
      , arabic = "هُناك وِشاح في شَنْطتي"
      , meaning = "There is a scarf in my bag."
      }
    , { latin  = "laysa hunaak lugha Sa3ba"
      , kana = ""
      , arabic = "لَيْسَ هُناك لُغة صَعْبة"
      , meaning = "There is no difficult language."
      }
    , { latin  = "2amaamii rajul ghariib"
      , kana = ""
      , arabic = "أَمامي رَجُل غَريب"
      , meaning = "There is a weird man in front of me."
      }
    , { latin  = "fii al-khalfiyya bayt"
      , kana = ""
      , arabic = "في الْخَلفِيْة بَيْت"
      , meaning = "There is a house in the background."
      }      
    , { latin  = "fii shanTatii wishaaH"
      , kana = ""
      , arabic = "في شَنْطَتي وِشاح"
      , meaning = "There is a scarf in my bag."
      }
    , { latin  = "asad"
      , kana = ""
      , arabic = "أَسَد"
      , meaning = "a lion"
      }
    , { latin  = "2uHibb 2asadii laakibb la 2uHibb 2usadhaa"
      , kana = ""
      , arabic = "أحِبَ أَسَدي لَكِنّ لا أُحِبّ أَسَدها"
      , meaning = "I like my lion but I do not like her lion."
      }
    , { latin  = "laysa 3indhu"
      , kana = ""
      , arabic = "لَيْسَ عِنْدهُ"
      , meaning = "he does not have"
      }
    , { latin  = "3indhaa kalb wa-qiTTa"
      , kana = ""
      , arabic = "عِنْدها كَلْب وَقِطّة"
      , meaning = "She has a doc and a cat."
      }
    , { latin  = "Sadiiqatu"
      , kana = ""
      , arabic = "صَديقَتهُ سامْية غَنِيّة"
      , meaning = "His friend Samia is rich."
      }
    , { latin  = "taariikhiyya"
      , kana = ""
      , arabic = "تاريخِيّة"
      , meaning = "historical"
      }
    , { latin  = "juurj 3indhu 3amal mumtaaz"
      , kana = ""
      , arabic = "جورْج عِنْدهُ عَمَل مُمْتاز"
      , meaning = "George has an amazing work."
      }
    , { latin  = "Sadiiqii taamir ghaniyy jiddan"
      , kana = ""
      , arabic = "صَديقي تامِر غَنِيّ جِدّاً"
      , meaning = "My friend Tamer is very rich"
      }
    , { latin  = "laa 2a3rif haadhaa l-2asad"
      , kana = ""
      , arabic = "لا أَعْرِف هَذا الْأَسّد"
      , meaning = "I do not know this lion."
      }
    , { latin  = "laysa 3indhu mi3Taf"
      , kana = ""
      , arabic = "لَيْسَ عِنْدهُ مِعْطَف"
      , meaning = "He does not have a coat."
      }
    , { latin  = "fii l-khalfiyya zawjatak ya siith"
      , kana = ""
      , arabic = "في الْخَلْفِيّة زَوْجَتَك يا سيث"
      , meaning = "There is your wife in background, Seth"
      }
    , { latin  = "su2uaal"
      , kana = ""
      , arabic = "سُؤال"
      , meaning = "a question"
      }
    , { latin  = "Sadiiqat-hu saamya laabisa tannuura"
      , kana = ""
      , arabic = "صدَيقَتهُ سامْية لابِسة تّنّورة"
      , meaning = "His friend Samia is wering a skirt."
      }
    , { latin  = "wa-hunaa fii l-khalfitta rajul muDHik"
      , kana = ""
      , arabic = "وَهُنا في الْخَلْفِتّة رَجُل مُضْحِك"
      , meaning = "And here in the background there is a funny man."
      }
    , { latin  = "man haadhaa"
      , kana = ""
      , arabic = "مَن هَذا"
      , meaning = "Who is this?"
      }
    , { latin  = "hal 2anti labisa wishaaH ya lamaa"
      , kana = ""
      , arabic = "هَل أَنْتِ لابِسة وِشاح يا لَمى"
      , meaning = "Are you wering a scarf, Lama?"
      }
    , { latin  = "2akhii bashiir mashghuul"
      , kana = ""
      , arabic = "أَخي بَشير مَشْغول"
      , meaning = "My brother Bashir is busy."
      }
    , { latin  = "fii haadhihi l-s-Suura imraa muDHika"
      , kana = ""
      , arabic = "في هَذِهِ الْصّورة اِمْرأة مُضْحِكة"
      , meaning = "Thre is a funny woman in this picture."
      }
    , { latin  = "hal 2anta laabis qubb3a ya siith"
      , kana = ""
      , arabic = "هَل أَنْتَ لابِس قُبَّعة يا سيث"
      , meaning = "Are you wearing a hat, Seth?"
      }
    , { latin  = "fii l-khalfiyya rajul muDHik"
      , kana = ""
      , arabic = "في الْخَلْفِيّة رَجُل مُضْحِك"
      , meaning = "There is a funny man in the background."
      }
    , { latin  = "shubbaak"
      , kana = ""
      , arabic = "شُبّاك"
      , meaning = "a window"
      }
    , { latin  = "sariir"
      , kana = ""
      , arabic = "سَرير"
      , meaning = "a bed"
      }
    , { latin  = "muHammad 2ustaadhii"
      , kana = ""
      , arabic = "مُحَمَّد أُسْتاذي"
      , meaning = "Muhammed is my teacher."
      }
    , { latin  = "saadii 2ustaadhii"
      , kana = ""
      , arabic = "شادي أُسْتاذي"
      , meaning = "Sadie is my teacher."
      }
    , { latin  = "2ummhu"
      , kana = ""
      , arabic = "أُمّهُ"
      , meaning = "his mother"
      }
    , { latin  = "tilfaaz"
      , kana = ""
      , arabic = "تِلْفاز"
      , meaning = "a television"
      }
    , { latin  = "ma haadhaa as-sawt"
      , kana = ""
      , arabic = "ما هَذا الْصَّوْت"
      , meaning = "What is this noise"
      }
    , { latin  = "2adkhul al-Hammaam"
      , kana = ""
      , arabic = "أَدْخُل اَلْحَمّام"
      , meaning = "I enter the bathroom."
      }
    , { latin  = "2uHibb al-ssariir al-kabiir"
      , kana = ""
      , arabic = "أُحِبّ اَلْسَّرير اَلْكَبير"
      , meaning = "I love the big bed."
      }
    , { latin  = "hunaak mushkila ma3 lt-tilfaaz"
      , kana = ""
      , arabic = "هُناك مُشْكِلة مَعَ الْتِّلْفاز"
      , meaning = "There is a problem with the television."
      }
    , { latin  = "al-haatif mu3aTTal wa-lt-tilfaaz 2ayDan"
      , kana = ""
      , arabic = "اَلْهاتِف مُعَطَّل وَالْتَّلْفاز أَيضاً"
      , meaning = "The telephone is out of order and the television also."
      }
    , { latin  = "hunaak Sawt ghariib fii l-maTbakh"
      , kana = ""
      , arabic = "هُناك صَوْت غَريب في الْمَطْبَخ"
      , meaning = "There is a weird nose in the kitchen."
      }
    , { latin  = "2anaam fii l-ghurfa"
      , kana = ""
      , arabic = "أَنام في الْغُرْفة"
      , meaning = "I sleep in the room."
      }
    , { latin  = "tilfaaz Saghiir fii Saaluun kabiir"
      , kana = ""
      , arabic = "تِلْفاز صَغير في صالون كَبير"
      , meaning = "a small television in a big living room"
      }
    , { latin  = "2anaam fii sariir maksuur"
      , kana = ""
      , arabic = "أَنام في سَرير مَكْسور"
      , meaning = "I sleep in a broken bed."
      }
    , { latin  = "as-sariir al-kabiir"
      , kana = ""
      , arabic = "اَلْسَّرير اَلْكَبير"
      , meaning = "the big bed"
      }
    , { latin  = "maa haadhaa aSSwut"
      , kana = ""
      , arabic = "ما هَذا الصّوُت"
      , meaning = "What is this noise?"
      }
    , { latin  = "sariirii mumtaaz al-Hamdu lila"
      , kana = ""
      , arabic = "سَريري مُمتاز اَلْحَمْدُ لِله"
      , meaning = "My bed is amazing, praise be to God"
      }
    , { latin  = "2anaam kathiiran"
      , kana = ""
      , arabic = "أَنام كَشيراً"
      , meaning = "I sleep a lot"
      }
    , { latin  = "hunaak Sawt ghariib"
      , kana = ""
      , arabic = "هُناك صَوْت غَريب"
      , meaning = "There is a weird noise."
      }
    , { latin  = "shubbaak"
      , kana = ""
      , arabic = "شُبّاك"
      , meaning = "a window"
      }
    , { latin  = "2anaam fii sariir Saghiir"
      , kana = ""
      , arabic = "أَنام في سَرير صَغير"
      , meaning = "I sleep in a small bed."
      }
    , { latin  = "muHammad 2ustaadhii"
      , kana = ""
      , arabic = "مُحَمَّد أُسْتاذي"
      , meaning = "Muhammad is my teacher."
      }
    , { latin  = "mahaa 2ummhu"
      , kana = ""
      , arabic = "مَها أُمّهُ"
      , meaning = "Maha is his mother."
      }
    , { latin  = "fii haadhaa lsh-shaari3 Sawt ghariib"
      , kana = ""
      , arabic = "في هٰذا ٱلْشّارِع صَوْت غَريب"
      , meaning = "There is a weird nose on this street"
      }
    , { latin  = "2askun fii ls-saaluun"
      , kana = ""
      , arabic = "أَسْكُن في الْصّالون"
      , meaning = "I live in the living room."
      }
    , { latin  = "haadhaa lsh-shaar3"
      , kana = ""
      , arabic = "هَذا الْشّارِع"
      , meaning = "this street"
      }
    , { latin  = "fii lT-Taabiq al-2awwal"
      , kana = ""
      , arabic = "في الْطّابِق اَلْأَوَّل"
      , meaning = "on the first floor"
      }
    , { latin  = "alsh-shaanii"
      , kana = ""
      , arabic = "اَلْثّاني"
      , meaning = "the second"
      }
    , { latin  = "3and-hu ghurfa nawm Saghiira"
      , kana = ""
      , arabic = "عِندهُ غُرْفة نَوْم صَغيرة"
      , meaning = "He has a small bedroom."
      }
    , { latin  = "laa 2aftaH albaab bisabab lT-Taqs"
      , kana = ""
      , arabic = "لا أَفْتَح اَلْباب بِسَبَب اّلْطَّقْس"
      , meaning = "I do not open the door because of the weather."
      }
    , { latin  = "Sifr"
      , kana = ""
      , arabic = "صِفْر"
      , meaning = "zero"
      }
    , { latin  = "3ashara"
      , kana = ""
      , arabic = "عَشَرَة"
      , meaning = "ten"
      }
    , { latin  = "waaHid"
      , kana = ""
      , arabic = "وَاحِد"
      , meaning = "one"
      }
    , { latin  = "2ithnaan"
      , kana = ""
      , arabic = "اِثْنان"
      , meaning = "two"
      }
    , { latin  = "kayf ta3uddiin min waaHid 2ilaa sitta"
      , kana = ""
      , arabic = "كَيْف تَعُدّين مِن ١ إِلى ٦"
      , meaning = "How do you count from one to six?"
      }
    , { latin  = "bil-lugha"
      , kana = ""
      , arabic = "بِالْلُّغة"
      , meaning = "in language"
      }
    , { latin  = "bil-lugha l-3arabiya"
      , kana = ""
      , arabic = "بِالْلُّغة الْعَرَبِيّة"
      , meaning = "in the arabic language"
      }
    , { latin  = "ta3rifiin"
      , kana = ""
      , arabic = "تَعْرِفين"
      , meaning = "you know"
      }    
    , { latin  = "hal ta3rifiin kull shay2 yaa mahaa"
      , kana = ""
      , arabic = "هَل تَعْرِفين كُلّ شَيء يا مَها"
      , meaning = "Do you know everything Maha?"
      }    
    , { latin  = "kayf ta3udd yaa 3umar"
      , kana = ""
      , arabic = "كَيْف تَعُدّ يا عُمَر"
      , meaning = "How do you count Omar?"
      }
    , { latin  = "Kayf ta3udd min Sifr 2ilaa 2ashara yaa muHammad"
      , kana = ""
      , arabic = "كَيْف تَعُدّ مِن٠ إِلى ١٠ يا مُحَمَّد"
      , meaning = "How do you count from 0 to 10 , Mohammed?"
      }
    , { latin  = "hal ta3rif yaa siith"
      , kana = ""
      , arabic = "هَل تَعْرِف يا سيث"
      , meaning = "Do you know Seth?"
      }
    , { latin  = "bayt buub"
      , kana = ""
      , arabic = "بَيْت بوب"
      , meaning = "Bob's house"
      }
    , { latin  = "maT3am muHammad"
      , kana = ""
      , arabic = "مَطْعَم مُحَمَّد"
      , meaning = "Mohammed's restaurant"
      }
    , { latin  = "SaHiifat al-muhandis"
      , kana = ""
      , arabic = "صَحيفة اَلْمُهَنْدِس"
      , meaning = "the enginner's newspaper"
      }
    , { latin  = "madiinat diitruuyt"
      , kana = ""
      , arabic = "مَدينة ديتْرويْت"
      , meaning = "the city of Detroit"
      }
    , { latin  = "wilaayat taksaas"
      , kana = ""
      , arabic = "وِلاية تَكْساس"
      , meaning = "the state of Texas"
      }
    , { latin  = "jaami3at juurj waashinTun"
      , kana = ""
      , arabic = "جامِعة جورْج واشِنْطُن"
      , meaning = "George Washinton University"
      }
    , { latin  = "shukuran"
      , kana = ""
      , arabic = "شُكْراً"
      , meaning = "thank you"
      }
    , { latin  = "SabaaHan"
      , kana = ""
      , arabic = "صَباحاً"
      , meaning = "in the morning"
      }
    , { latin  = "masaa-an"
      , kana = ""
      , arabic = "مَساءً"
      , meaning = "in the evening"
      }
    , { latin  = "wayaatak"
      , kana = ""
      , arabic = "وِلايَتَك"
      , meaning = "your state"
      }
    , { latin  = "madiina saaHiliyya"
      , kana = ""
      , arabic = "مَدينة ساحِلِيّة"
      , meaning = "a coastal city"
      }
    , { latin  = "muzdaHima"
      , kana = ""
      , arabic = "مُزْدَحِمة"
      , meaning = "crowded"
      }
    , { latin  = "wilaaya kaaliifuurniyaa"
      , kana = ""
      , arabic = "وِلاية كاليفورْنْيا"
      , meaning = "the state of California"
      }
    , { latin  = "luus 2anjiaalis"
      , kana = ""
      , arabic = "لوس أَنْجِلِس"
      , meaning = "Los Angeles"
      }
    , { latin  = "baHr"
      , kana = ""
      , arabic = "بَحْر"
      , meaning = "sea"
      }
    , { latin  = "al-baHr al-2abyaD al-mutawassaT"
      , kana = ""
      , arabic = "اَاْبَحْر اَلْأَبْيَض اَلْمُتَوَسِّط"
      , meaning = "the Meditteranean Sea"
      }
    , { latin  = "lil2asaf"
      , kana = ""
      , arabic = "لٍلْأَسَف"
      , meaning = "unfortunately"
      }
    , { latin  = "DawaaHii"
      , kana = ""
      , arabic = "ضَواحي"
      , meaning = "suburbs"
      }
    , { latin  = "taskuniin"
      , kana = ""
      , arabic = "تَسْكُنين"
      , meaning = "you live"
      }
    , { latin  = "nyuuyuurk"
      , kana = ""
      , arabic = "نْيويورْك"
      , meaning = "New York"
      }
    , { latin  = "qaryatik"
      , kana = ""
      , arabic = "قَرْيَتِك"
      , meaning = "your village"
      }
    , { latin  = "shubbaak"
      , kana = ""
      , arabic = "شُبّاك"
      , meaning = "a window"
      }
    , { latin  = "jaziira"
      , kana = ""
      , arabic = "جَزيرة"
      , meaning = "an island"
      }
    , { latin  = "Tabii3a"
      , kana = ""
      , arabic = "طَبيعة"
      , meaning = "nature"
      }
    , { latin  = "al-2iskandariyya"
      , kana = ""
      , arabic = "اَلْإِسْكَندَرِيّة"
      , meaning = "Alexandria"
      }
    , { latin  = "miSr"
      , kana = ""
      , arabic = "مِصْر"
      , meaning = "Egypt"
      }
    , { latin  = "na3am"
      , kana = ""
      , arabic = "نَعَم"
      , meaning = "yes"
      }
    , { latin  = "SabaaH l-khayr"
      , kana = ""
      , arabic = "صَباح اَلْخَيْر"
      , meaning = "Good morning."
      }
    , { latin  = "SabaaH an-nuur"
      , kana = ""
      , arabic = "صَباح اَلْنّور"
      , meaning = "Good morning."
      }
    , { latin  = "masaa2 al-khayr"
      , kana = ""
      , arabic = "مَساء اَلْخَيْر"
      , meaning = "Good evening"
      }
    , { latin  = "masaa2 an-nuur"
      , kana = ""
      , arabic = "مَساء اَلْنّور"
      , meaning = "Good evening."
      }
    , { latin  = "as-salaamu 3alaykum"
      , kana = ""
      , arabic = "اَلْسَّلامُ عَلَيْكُم"
      , meaning = "Peace be upon you."
      }
    , { latin  = "wa-3alaykumu as-salaam"
      , kana = ""
      , arabic = "وَعَلَيْكُمُ ٲلْسَّلام"
      , meaning = ""
      }
    , { latin  = "tasharrafnaa"
      , kana = ""
      , arabic = "تَشَرَّفْنا"
      , meaning = "It's a pleasure to meet you."
      }
    , { latin  = "hal 2anta bikhyr"
      , kana = ""
      , arabic = "هَل أَنْتَ بِخَيْر"
      , meaning = "Are you well?"
      }
    , { latin  = "kayfak"
      , kana = ""
      , arabic = "كَيْفَك"
      , meaning = "How are you?"
      }
    , { latin  = "al-yawm"
      , kana = ""
      , arabic = "اَلْيَوْم"
      , meaning = "today"
      }
    , { latin  = "kayfik al-yawm"
      , kana = ""
      , arabic = "كَيْفِك اَلْيَوْم"
      , meaning = "How are you today?"
      }
    , { latin  = "marHaban ismii buub"
      , kana = ""
      , arabic = "مَرْحَباً اِسْمي بوب"
      , meaning = "Hello, my name is Bob."
      }
    , { latin  = "Haziin"
      , kana = ""
      , arabic = "حَزين"
      , meaning = "sad"
      }
    , { latin  = "mariiD"
      , kana = ""
      , arabic = "مَريض"
      , meaning = "sick"
      }
    , { latin  = "yawm sa3iid"
      , kana = ""
      , arabic = "يَوْم سَعيد"
      , meaning = "Have a nice day."
      }
    , { latin  = "sa3iid"
      , kana = ""
      , arabic = "سَعيد"
      , meaning = "happy"
      }
    , { latin  = "2anaa Haziinat l-yawm"
      , kana = ""
      , arabic = "أَنا حَزينة الْيَوْم"
      , meaning = "I am sad today."
      }
    , { latin  = "2anaa Haziin jiddan"
      , kana = ""
      , arabic = "أَنا حَزين جِدّاً"
      , meaning = "I am very sad."
      }
    , { latin  = "2anaa mariiDa lil2asaf"
      , kana = ""
      , arabic = "أَنا مَريضة لِلْأَسَف"
      , meaning = "I am sick unfortunately."
      }
    , { latin  = "2ilaa l-laqaa2 yaa Sadiiqii"
      , kana = ""
      , arabic = "إِلى الْلِّقاء يا صَديقي"
      , meaning = "Until next time, my friend."
      }
    , { latin  = "na3saana"
      , kana = ""
      , arabic = "نَعْسانة"
      , meaning = "sleepy"
      }
    , { latin  = "mutaHammis"
      , kana = ""
      , arabic = "مُتَحَمِّس"
      , meaning = "excited"
      }
    , { latin  = "maa 2ismak"
      , kana = ""
      , arabic = "ما إِسْمَك"
      , meaning = "What is your name?"
      }
    , { latin  = "2ana na3saan"
      , kana = ""
      , arabic = "أَنا نَعْسان"
      , meaning = "I am sleepy."
      }
    , { latin  = "yallaa 2ilaa l-liqaa2"
      , kana = ""
      , arabic = "يَلّإِ إِلى الْلَّقاء"
      , meaning = "Alriht, until next time."
      }
    , { latin  = "ma3a as-alaama"
      , kana = ""
      , arabic = "مَعَ الْسَّلامة"
      , meaning = "Goodbye."
      }
    , { latin  = "tamaam"
      , kana = ""
      , arabic = "تَمام"
      , meaning = "OK"
      }
    , { latin  = "2ana tamaam al-Hamdu lillah"
      , kana = ""
      , arabic = "أَنا تَمام اَلْحَمْدُ لِله"
      , meaning = "I am OK , praise be to God."
      }
     , { latin  = "maa al2akhbaar"
       , arabic = "ما الْأَخْبار"
       , meaning = "What is new?"
       }
    , { latin  = "al-bathu alhii"
      , kana = ""
      , arabic = "اَلْبَثُ اَلْحي"
      , meaning = "live broadcast"
      }
    , { latin  = "2ikhtar"
      , kana = ""
      , arabic = "إِخْتَر"
      , meaning = "choose"
      }
    , { latin  = "sayyaara"
      , kana = ""
      , arabic = "سَيّارة"
      , meaning = "a car"
      }
    , { latin  = "2ahlan wa-sahlan"
      , kana = ""
      , arabic = "أَهْلاً وَسَهْلاً"
      , meaning = "welcom"
      }
    , { latin  = "2akh ghariib"
      , kana = ""
      , arabic = "أَخ غَريب"
      , meaning = "a weird brother"
      }
    , { latin  = "2ukht muhimma"
      , kana = ""
      , arabic = "أُخْت مُهِمّة"
      , meaning = "an important sister"
      }
    , { latin  = "ibn kariim wa-mumtaaz"
      , kana = ""
      , arabic = "اِبْن كَريم وَمُمْتاز"
      , meaning = "a generous and amazing son"
      }
    , { latin  = "2ab"
      , kana = ""
      , arabic = "أَب"
      , meaning = "a father"
      }      
    , { latin  = "2umm"
      , kana = ""
      , arabic = "أُمّ"
      , meaning = "a mother"
      }
    , { latin  = "ibn"
      , kana = "イブン"
      , arabic = "اِبْن"
      , meaning = "a son"
      }
    , { latin  = "mumti3"
      , kana = ""
      , arabic = "مُمْتِع"
      , meaning = "fun"
      }
    , { latin  = "muHaasib"
      , kana = ""
      , arabic = "مُحاسِب"
      , meaning = "an accountant"
      }
    , { latin  = "ma-smika ya 2ustaadha"
      , kana = ""
      , arabic = "ما اسْمِك يا أُسْتاذة"
      , meaning = "Whatis your name ma'am?"
      }
    , { latin  = "qiTTatak malika"
      , kana = ""
      , arabic = "قِطَّتَك مَلِكة"
      , meaning = "Your cat is a queen."
      }
    , { latin  = "jadda laTiifa wa-jadd laTiif"
      , kana = ""
      , arabic = "جَدّة لَطيفة وَجَدّ لَطيف"
      , meaning = "a kind grandmother and a kind grandfather"
      }
    , { latin  = "qiTTa jadiida"
      , kana = ""
      , arabic = "قِطّة جَديدة"
      , meaning = "a new cat"
      }
    , { latin  = "hal jaddatak 2ustaadha"
      , kana = ""
      , arabic = "هَل جَدَّتَك أُسْتاذة"
      , meaning = "Is your grandmother a professor?"
      }
     , { latin  = "hal zawjatak 2urduniyya"
       , arabic = "هَل زَوْجَتَك أُرْدُنِتّة"
       , meaning = "Is your wife a Jordanian?"
       }
    , { latin  = "mu3allim"
      , kana = ""
      , arabic = "مُعَلِّم"
      , meaning = "a teacher"
      }
    , { latin  = "dhakiyya"
      , kana = ""
      , arabic = "ذَكِيّة"
      , meaning = "smart"
      }
    , { latin  = "jaaratii"
      , kana = ""
      , arabic = "جارَتي"
      , meaning = "my neighbor"
      }
    , { latin  = "ma3Taf"
      , kana = ""
      , arabic = "مَعْطَف"
      , meaning = "a coat"
      }
    , { latin  = "qubba3a zarqaa2 wa-bunniyya"
      , kana = ""
      , arabic = "قُبَّعة زَرْقاء وَبُنّية"
      , meaning = "a blue ad brown hat"
      }
    , { latin  = "bayDaa2"
      , kana = ""
      , arabic = "بَيْضاء"
      , meaning = "white"
      }
    , { latin  = "al-2iijaar jayyd al-Hamdu lila"
      , kana = ""
      , arabic = "اَلْإِيجار جَيِّد اَلْحَمْدُ لِله"
      , meaning = "The rent is good, praise be to God."
      }
    , { latin  = "jaami3a ghaalya"
      , kana = ""
      , arabic = "جامِعة غالْية"
      , meaning = "an expensive university"
      }
    , { latin  = "haadhaa Saaluun qadiim"
      , kana = ""
      , arabic = "هَذا صالون قَديم"
      , meaning = "This is an old living room."
      }
    , { latin  = "haadhihi Hadiiqa 3arabiyya"
      , kana = ""
      , arabic = "هَذِهِ حَديقة عَرَبِيّة"
      , meaning = ""
      }
    , { latin  = "al-HaaiT"
      , kana = ""
      , arabic = "اَلْحائِط"
      , meaning = "the wall"
      }
    , { latin  = "hunaak shanTa Saghiira"
      , kana = ""
      , arabic = "هُناك شَنطة صَغيرة"
      , meaning = "There is a small bag."
      }
    , { latin  = "2abii hunaak"
      , kana = ""
      , arabic = "أَبي هُناك"
      , meaning = "My father is there."
      }
    , { latin  = "haatifak hunaak yaa buub"
      , kana = ""
      , arabic = "هاتِفَك هُناك يا بوب"
      , meaning = "Your telephone is there, Bob."
      }
    , { latin  = "haatifii hunaak"
      , kana = ""
      , arabic = "هاتِفي هُناك"
      , meaning = "My telephone is there."
      }
    , { latin  = "hunaak 3ilka wa-laab tuub fii shanTatik"
      , kana = ""
      , arabic = "هُناك عِلكة وَلاب توب في شَنطَتِك"
      , meaning = "There is a chewing gum and a laptop in your bag."
      }
    , { latin  = "raSaaS"
      , kana = ""
      , arabic = "رَصاص"
      , meaning = "lead"
      }
    , { latin  = "qalam raSaaS"
      , kana = ""
      , arabic = "قَلَم رَصاص"
      , meaning = "a pencil"
      }
    , { latin  = "mu2al-lif"
      , kana = ""
      , arabic = "مُؤَلِّف"
      , meaning = "an author"
      }
    , { latin  = "shaahid al-bath il-Hayy"
      , kana = ""
      , arabic = "شاهد البث الحي"
      , meaning = "Watch the live braodcast"
      }
    , { latin  = "Tayyib"
      , kana = ""
      , arabic = "طَيِّب"
      , meaning = "Ok, good"
      }
    , { latin  = "2ahlan wa-sahlan"
      , kana = ""
      , arabic = "أَهْلاً وَسَهْلاً"
      , meaning = "Welcome."
      }
    , { latin  = "2a3iish"
      , kana = ""
      , arabic = "أَعيش"
      , meaning = "I live"
      }
    , { latin  = "2a3iish fi l-yaabaan"
      , kana = ""
      , arabic = "أَعيش في لايابان"
      , meaning = "I live in Japan."
      }
    , { latin  = "2ana 2ismii faaTima"
      , kana = ""
      , arabic = "أَنا إِسمي فاطِمة"
      , meaning = "My name is Fatima."
      }
     , { latin  = "2a3iish fii miSr"
       , arabic = "أَعيش في مِصر"
       , meaning = "I live in Egypt."
       }
    , { latin  = "al3mr"
      , kana = ""
      , arabic = "العمر"
      , meaning = "age"
      }
    , { latin  = "2ukhtii wa-Sadiiqhaa juurj"
      , kana = ""
      , arabic = "أُخْتي وَصَديقهل جورْج"
      , meaning = "my sister and her friend George"
      }
    , { latin  = "3amalii wa-eamala"
      , kana = ""
      , arabic = "عَمَلي وَعَمَله"
      , meaning = "my work and his work"
      }
    , { latin  = "haadhihi Sadiiqat-hu saamiya"
      , kana = ""
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
    , { latin  = "al-2aan"
      , kana = "アル アーン"
      , arabic = "اَلآن"
      , meaning = "right now"
      }
    , { latin = "kayfa"
      , kana = ""
      , arabic = "كَيْفَ"
      , meaning = "how"
      }
    , { latin  = "kaifa Haaluka"
      , kana = "カイファ ハールカ"
      , arabic = "كَيْفَ حالُكَ"
      , meaning = "How are you?"
      }
    , { latin  = "Hammaam"
      , kana = "ハムマーム"
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
    , { latin  = "hiyya "
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
      , meaning = "Standard Arabic "
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
      , kana = "ハーリー"
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
      , kana = "ウムム"
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
      , kana = "ウムミー"
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
    , { latin  = "naDHiir"
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
      , meaning = "a (female) neighbor"
      }
    , { latin  = "jaaratii"
      , kana = "ジャーラティ"
      , arabic = "جارَتي"
      , meaning = "my (female) neighbor"
      }
    , { latin  = "jaaratak"
      , kana = "ジャラタク"
      , arabic = "جارَتَك"
      , meaning = "your (female) neighbor (to a male)"
      }
    , { latin  = "jaaratik"
      , kana = "ジャラティク"
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
      , meaning = "You have a house. (to a man)"
      }
    , { latin  = "3indika bayt"
      , kana = "アインディカ バイト"
      , arabic = "عِنْدِك بَيْت"
      , meaning = "You have a house. (to a woman)"
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
      , kana = "アルバイト ザルカー"
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





    ]
