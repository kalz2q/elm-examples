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
    , arabic : String
    , meaning : String
    , showanswer : Bool
    , list : List Arabicdata
    }


type alias Arabicdata =
    { latin : String
    , arabic : String
    , meaning : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" "" "" False dict
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
      , arabic = "اَلسَّلَامُ"
      , meaning = "peace"
      }
    , { latin = "2alaykum"
      , arabic = "عَلَيْكُمْ"
      , meaning = "on you"
      }
    , { latin = "SabaaH"
      , arabic = "صَبَاح"
      , meaning = "morning"
      }
    , { latin = "marhaban"
      , arabic = "مَرْحَبًا"
      , meaning = "Hello"
      }
    , { latin = "thaqaafah"
      , arabic = "ثَقافَة"
      , meaning = "culture"
      }
    , { latin = "2anaa bikhayr"
      , arabic = "أَنا بِخَيْر"
      , meaning = "I'm fine"
      }
    , { latin = "kabir"
      , arabic = "كَبير"
      , meaning = "large, big"
      }
    , { latin = "kabirah"
      , arabic = "كبيرة"
      , meaning = "large, big"
      }
    , { latin = "bayt"
      , arabic = "بَيْت"
      , meaning = "a house"
      }
    , { latin = "laysa"
      , arabic = "لِيْسَ"
      , meaning = "do not"
      }
    , { latin = "3and"
      , arabic = "عَنْد"
      , meaning = "have"
      }
    , { latin = "siith"
      , arabic = "سيث"
      , meaning = "Seth(male name)"
      }
    , { latin = "baluuzah"
      , arabic = "بَلوزة"
      , meaning = "blouse"
      }
    , { latin = "tii shiirt"
      , arabic = "تي شيرْت"
      , meaning = "T-shirt"
      }
    , { latin = "mi3Taf"
      , arabic = "مِعْطَف"
      , meaning = "a coat"
      }
    , { latin = "riim"
      , arabic = "ريم"
      , meaning = "Reem(name)"
      }
    , { latin = "tannuura"
      , arabic = "تَنّورة"
      , meaning = "a skirt"
      }
    , { latin = "jadiid"
      , arabic = "جَديد"
      , meaning = "new"
      }
    , { latin = "wishshaaH"
      , arabic = "وِشَاح"
      , meaning = "a scarf"
      }
    , { latin = "judii"
      , arabic = "جودي"
      , meaning = "Judy(name)"
      }
    , { latin = "jamiil"
      , arabic = "جَميل"
      , meaning = "good, nice, pretty, beautiful"
      }
    , { latin = "kalb"
      , arabic = "كَلْب"
      , meaning = "a dog"
      }
    , { latin = "2azraq"
      , arabic = "أَزْرَق"
      , meaning = "blue"
      }
    , { latin = "2abyaD"
      , arabic = "أَبْيَض "
      , meaning = "white"
      }
    , { latin = "qubb3a"
      , arabic = "قُبَّعة"
      , meaning = "a hat"
      }
    , { latin = "bunniyy"
      , arabic = "بُنِّيّ"
      , meaning = "brown"
      }
    , { latin = "mruu2a"
      , arabic = "مْروءة"
      , meaning = "chivalry"
      }
    , { latin = "kitaab"
      , arabic = "كِتاب"
      , meaning = "a book"
      }
    , { latin = "Taawilah"
      , arabic = "طاوِلة"
      , meaning = "a table"
      }
    , { latin = "hadhihi madiinA qadiima"
      , arabic = "هَذِهِ مَدينة قَديمة"
      , meaning = "This is an ancient city"
      }
    , { latin = "Hadiiqa"
      , arabic = "حَديقة"
      , meaning = "garden"
      }
    , { latin = "hadhihi HadiiqA 3arabyya"
      , arabic = "هَذِهِ حَديقة عَرَبيّة"
      , meaning = "This is an Arab garden"
      }
    , { latin = "hadhihi binaaya jamiila"
      , arabic = "هَذِهِ بِناية جَميلة"
      , meaning = "This is a beautiful building"
      }
    , { latin = "hadhaa muhammad"
      , arabic = "هَذا مُحَمَّد"
      , meaning = "This is mohamed"
      }
    , { latin = "hadhaa Saaluun ghaalii"
      , arabic = "هَذا صالون غالي"
      , meaning = "This is an expensive living room"
      }
    , { latin = "hadhihi HadiiqA jamiila"
      , arabic = "هَذِهِ حَديقة جَميلة"
      , meaning = "This is a pretty garden"
      }
    , { latin = "hadhihi HadiiqA qadiima"
      , arabic = "هَذِهِ حَديقة قَديمة"
      , meaning = "This is an old garden"
      }
    , { latin = "alHa2iT"
      , arabic = "الْحائط"
      , meaning = "the wall"
      }
    , { latin = "Ha2iT"
      , arabic = "حائِط"
      , meaning = "wall"
      }
    , { latin = "hadhaa alHaa2iT kabiir"
      , arabic = "هَذا الْحائِط كَبير "
      , meaning = "this wall is big"
      }
    , { latin = "alkalb"
      , arabic = "الْكَلْب"
      , meaning = "the dog"
      }
    , { latin = "hadhihi albinaaya"
      , arabic = "هذِهِ الْبِناية "
      , meaning = "this building"
      }
    , { latin = "al-ghurfa"
      , arabic = "اَلْغُرفة"
      , meaning = "the room"
      }
    , { latin = "alghurfA kaBiira"
      , arabic = "اَلْغرْفة كَبيرة"
      , meaning = "Theroom is big"
      }
    , { latin = "hadhihi alghurfa kabiira"
      , arabic = "هَذِهِ الْغُرْفة كَبيرة"
      , meaning = "this room is big"
      }
    , { latin = "hadhaa alkalb kalbii"
      , arabic = "هَذا  الْكَلْب كَْلبي"
      , meaning = "this dog is my dog"
      }
    , { latin = "hadhaa alkalb jaw3aan"
      , arabic = "هَذا الْكَلْب جَوْعان"
      , meaning = "this dog is hungry"
      }
    , { latin = "hadhihi albinaaya waas3a"
      , arabic = "هَذِهِ الْبناية واسِعة"
      , meaning = "this building is spacious"
      }
    , { latin = "alkalb ghariib"
      , arabic = "اَلْكَلْب غَريب"
      , meaning = "The dog is weird"
      }
    , { latin = "alkalb kalbii"
      , arabic = "اَلْكَلْب كَلْبي"
      , meaning = "The dog is my dog"
      }
    , { latin = "hunaak"
      , arabic = "هُناك"
      , meaning = "there"
      }
    , { latin = "hunaak bayt"
      , arabic = "هُناك بَيْت"
      , meaning = "There is a house"
      }
    , { latin = "albayt hunaak"
      , arabic = "اَلْبَيْت هُناك"
      , meaning = "The house is there"
      }
    , { latin = "hunaak wishaaH 2abyaD"
      , arabic = "هُناك وِشاح أبْيَض"
      , meaning = "There is a white scarf"
      }
    , { latin = "alkalb munaak"
      , arabic = "اَلْكَلْب مُناك"
      , meaning = "The dog is there"
      }
    , { latin = "fii shanTatii"
      , arabic = "في شَنْطَتي"
      , meaning = "in my bag"
      }
    , { latin = "hal 3indak maHfaDHA yaa juurj"
      , arabic = "هَل عِنْدَك مَحْفَظة يا جورْج"
      , meaning = "do you have a wallet , george"
      }
    , { latin = "3indii shanTa ghaalya"
      , arabic = "عِنْدي شَنْطة غالْية"
      , meaning = "I have an expensive bag"
      }
    , { latin = "shanTatii fii shanTatik ya raanya"
      , arabic = "شِنْطَتي في شَنْطتِك يا رانْيا"
      , meaning = "my bag is in your bag rania"
      }
    , { latin = "huunak maHfaDhA Saghiira"
      , arabic = "هُناك مَحْفَظة صَغيرة"
      , meaning = "There is a small wallet"
      }
    , { latin = "hunaak kitab jadiid"
      , arabic = "هَناك كِتاب جَديد"
      , meaning = "There is a new book"
      }
    , { latin = "hunaak kitaab Saghiir"
      , arabic = "هُناك كِتاب صَغير"
      , meaning = "There is a small book"
      }
    , { latin = "hunaak qubba3A fii shanTatak yaa bob"
      , arabic = "هُناك قُبَّعة في شَنْطَتَك يا بوب"
      , meaning = "There is a hat in your bag bob"
      }
    , { latin = "hunaak shanTa Saghiira"
      , arabic = "هُناك شَنْطة صَغيرة"
      , meaning = "There is a small bag"f
      }
    , { latin = "shanTatii hunaak"
      , arabic = "شَنْطَتي هُناك"
      , meaning = "my bag is over there"
      }
    , { latin = "hunaak kitaab Saghiir wawishaaH Kabiir fii ShanTatii"
      , arabic = "هُناك كِتاب صَغير وَوِشاح كَبير في شَنْطَتي"
      , meaning = "There is a small book and a big scarf in my bag"
      }
    , { latin = "hunaak maHfaTa Saghiir fii ShanTatii"
      , arabic = "هُناك مَحْفَظة صَغيرة في شَنْطَتي"
      , meaning = "There is a small wallet in my bag"
      }
    , { latin = "aljaami3a hunaak"
      , arabic = "اَلْجامِعة هُناك"
      , meaning = "The university is there"
      }
    , { latin = "hunaak kitaab"
      , arabic = "هُناك كِتاب"
      , meaning = "There is a book"
      }
    , { latin = "almadiina hunaak"
      , arabic = "اَلْمَدينة هُناك"
      , meaning = "Thecity is there"
      }
    , { latin = "hal 3indik shanTa ghaalya ya Riim"
      , arabic = "هَل عِندِك شَنْطة غالْية يا ريم"
      , meaning = "do you have an expensive bag Reem"
      }
    , { latin = "hal 3indik mashruub ya saamya"
      , arabic = "هَل عِنْدِك مَشْروب يا سامْية"
      , meaning = "do you have a drink samia"
      }
    , { latin = "hunaak daftar rakhiiS"
      , arabic = "هُناك دَفْتَر رَخيص"
      , meaning = "There is a cheep notebook"
      }
    , { latin = "laysa 3indii daftar"
      , arabic = "لَيْسَ عِنْدي دَفْتَر"
      , meaning = "I do not have a notebook"
      }
    , { latin = "laysa hunaak masharuub fii shanTatii"
      , arabic = "لَيْسَ هُناك مَشْروب في شَنْطَتي"
      , meaning = "There is no drink in my bag"
      }
    , { latin = "laysa hunaak kitaab qaSiir fii baytii"
      , arabic = "لَيْسَ هُناك كِتاب قَصير في بَيْتي"
      , meaning = "There is no short book in my house"
      }
    , { latin = "laysa hunaak daftar rakhiiS"
      , arabic = "لَيْسَ هُناك دَفْتَر رَخيص"
      , meaning = "There is no cheap notebook"
      }
    , { latin = "laysa 3indii sii dii"
      , arabic = "لَيْسَ عَنْدي سي دي"
      , meaning = "I do not have a CD"
      }
    , { latin = "laysa hunaak qalam fii shanTatii"
      , arabic = "لَيْسَ هُناك قَلَم في شَنْطَتي"
      , meaning = "There is no pen in my bag"
      }
    , { latin = "laysa hunaak kitaab qaSiir fii shanTatii"
      , arabic = "لَيْسَ هُناك كِتاب قَصير في شَنْطَتي"
      , meaning = "There is no short book in my bag"
      }
    , { latin = "laysa hunaak daftar 2abyaD"
      , arabic = "لَيْسَ هُناك دَفْتَر أَبْيَض"
      , meaning = "There is no white notebook."
      }
    , { latin = "maTbakh"
      , arabic = "مَطْبَخ"
      , meaning = "a kitchen"
      }
    , { latin = "3ilka"
      , arabic = "عِلْكة"
      , meaning = "gum"
      }
    , { latin = "miftaaH"
      , arabic = "مفْتاح"
      , meaning = "a key"
      }
    , { latin = "tuub"
      , arabic = "توب"
      , meaning = "top"
      }
    , { latin = "nuquud"
      , arabic = "نُقود"
      , meaning = "money"
      }
    , { latin = "aljazeera"
      , arabic = "الجزيرة"
      , meaning = "Al Jazeera"
      }
    , { latin = "kayfa"
      , arabic = "كَيْفَ"
      , meaning = "how"
      }
    , { latin = "kursii"
      , arabic = "كَرْسي"
      , meaning = "a chair"
      }
    , { latin = "sari3"
      , arabic = "سَريع"
      , meaning = "fast"
      }
    , { latin = "Haasuub"
      , arabic = "حاسوب"
      , meaning = "a computer"
      }
    , { latin = "maktab"
      , arabic = "مَكْتَب"
      , meaning = "office"
      }
    , { latin = "hadhaa maktab kabiir"
      , arabic = "هَذا مَِكْتَب كَبير"
      , meaning = "This is a big office"
      }
    , { latin = "kursii alqiTTa"
      , arabic = "كُرْسي الْقِطّة"
      , meaning = "the cat's chair"
      }
    , { latin = "Haasuub al2ustaadha"
      , arabic = "حاسوب اَلْأُسْتاذة"
      , meaning = "professor's computer"
      }
    , { latin = "kursii jadiid"
      , arabic = "كُرْسي جَديد"
      , meaning = "a new chair"
      }
    , { latin = "alHamdu lilh"
      , arabic = "اَلْحَمْدُ لِله"
      , meaning = "Praise be to God"
      }
    , { latin = "SaHiifa"
      , arabic = "صَحيفة"
      , meaning = "newspaper"
      }
    , { latin = "raqam"
      , arabic = "رَقَم"
      , meaning = "number"
      }
    , { latin = "haatif"
      , arabic = "هاتِف"
      , meaning = "phone"
      }
    , { latin = "2amriikiyy"
      , arabic = "أمْريكِي"
      , meaning = "American"
      }
    , { latin  = "2amriikaa wa-as-siin"
      , arabic = "أَمْريكا وَالْصّين"
      , meaning = "America and China"
      }
    , { latin  = "qahwa"
      , arabic = "قَهْوة"
      , meaning = "coffee"
      }
    , { latin  = "Haliib"
      , arabic = "حَليب"
      , meaning = "milk"
      }
    , { latin  = "muuza"
      , arabic = "موزة"
      , meaning = "a banana"
      }
    , { latin  = "2akl"
      , arabic = "أَكْل"
      , meaning = "food"
      }
    , { latin  = "2akl 3arabyy waqahwA 3arabyy"
      , arabic = "أَكْل عَرَبيّ وَقَهْوة عَرَبيّة"
      , meaning = "Arabic food and Arabic coffee"
      }
    , { latin  = "ruzz"
      , arabic = "رُزّ"
      , meaning = "rice"
      }
    , { latin  = "ruzzii waqahwatii"
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
      , arabic = "صَديقَتها"
      , meaning = "her friend"
      }
    , { latin  = "jaarat-haa"
      , arabic = "جارَتها"
      , meaning = "her neighbor"
      }
    , { latin  = "2a3rif"
      , arabic = "أَعْرِف"
      , meaning = "I know ..."
      }
    , { latin  = "2ukhtii"
      , arabic = "أُخْتي"
      , meaning = "my sister"
      }
    , { latin  = "Sadiiqa Jayyida"
      , arabic = "صَديقة  جَيِّدة"
      , meaning = "a good friend"
      }أ
     , { latin  = "2a3rif"
       , arabic = "أَعْرِف"
       , meaning = "I know"
       }
    , { latin  = "2anaa 2a3rifhu"
      , arabic = "أَنا أَعْرِفه"
      , meaning = "I know him"
      }
    , { latin  = "Taaawila Tawiila"
      , arabic = "طاوِلة طَويلة"
      , meaning = "long table"
      }
    , { latin  = "baytik wabaythaa"
      , arabic = "بَيْتِك وَبَيْتها"
      , meaning = "your house and her house"
      }
    , { latin  = "ism Tawiil"
      , arabic = "اِسْم طَويل"
      , meaning = "long name"
      }
    , { latin  = "baytii wabaythaa"
      , arabic = "بَيْتي وَبَيْتها"
      , meaning = "my house and her house"
      }
    , { latin  = "laysa hunaak lugha Sa3ba"
      , arabic = "لَيْسَ هُناك لُغة صَعْبة"
      , meaning = "There is no diffcult language."
      }
    , { latin  = "hadhaa shay2 sa3b"
      , arabic = "هَذا شَيْء صَعْب"
      , meaning = "This is a difficult thing."
      }
    , { latin  = "ismhu taamir"
      , arabic = "اِسْمهُ تامِر"
      , meaning = "His name is Tamer."
      }
    , { latin  = "laa 2a3rif 2ayn bayt-hu"
      , arabic = "لا أَعْرِف أَيْن بَيْته"
      , meaning = "I don't know where his house is"
      }
    , { latin  = "laa 2a3rif 2ayn 2anaa"
      , arabic = "لا أعرف أين أنا."
      , meaning = "I don't know where I am."
      }
    , { latin  = "baythu qariib min aljaami3at"
      , arabic = "بيته قريب من الجامعة"
      , meaning = "His house is close to the university"
      }
    , { latin  = "ismhaa arabyy"
      , arabic = "إسمها عربي"
      , meaning = "Her name is arabic."
      }
    , { latin  = "Sadiiqathu ruuzaa qariibhu min baythu"
      , arabic = "صديقته روزا قريبه من بيته"
      , meaning = "His friend Rosa is close to his house."
      }
    , { latin  = "ismhu Tawiil"
      , arabic = "إسمه طويل"
      , meaning = "His name is long."
      }
    , { latin  = "riim Sadiiqat Sa3bat"
      , arabic = "ريم صديقة صعبة"
      , meaning = "Reem is a difficult friend."
      }      
    , { latin  = "ismhu bashiir"
      , arabic = "إسمه بشير"
      , meaning = "HIs name is Bashir."
      }      
    , { latin  = "ismhaa Tawiil"
      , arabic = "إسمها طويل"
      , meaning = "Her name is long."
      }      
    , { latin  = "Sadiiqhaa buub qariib min baythaa"
      , arabic = "صديقها بوب قريب من بيتها"
      , meaning = "Her friend Bob is close to her house."
      } 
    , { latin  = "ismhu bob"
      , arabic = "إسمه بوب"
      , meaning = "His name is Bob."
      }
    , { latin  = "baythu qariib min baythaa"
      , arabic = "بيته قريب من بيتها"
      , meaning = "His house is close to her house."
      }
    , { latin  = "hadhaa shay2 Sa3b"
      , arabic = "هذا شيء صعب"
      , meaning = "This is a difficult thing."
      }
    , { latin  = "3alaaqa"
      , arabic = "عَلاقَة"
      , meaning = "relationship"
      }
    , { latin  = "alqiTTa"
      , arabic = "اَلْقِطّة"
      , meaning = "the cat"
      }
    , { latin  = "la 2uhib"
      , arabic = "لا أُحِب"
      , meaning = "I do not like"
      }
    , { latin  = "al2akl mumti3"
      , arabic = "اَلْأَكْل مُمْتع"
      , meaning = "Eating is fun."
      }
    , { latin  = "alqiraa2a"
      , arabic = "اَلْقِراءة"
      , meaning = "reading"
      }
    , { latin  = "alkitaaba"
      , arabic = "الْكِتابة"
      , meaning = "writing"
      }
    , { latin  = "alkiraa2a wa-alkitaaba"
      , arabic = "اَلْقِراءة وَالْكِتابة"
      , meaning = "reading and writing"
      }
    , { latin  = "muhimm"
      , arabic = "مُهِمّ"
      , meaning = "important"
      }
    , { latin  = "alkiaaba shay2 muhimm"
      , arabic = "اَلْكِتابة شَيْء مُهِمّ"
      , meaning = "Writing is an important thing."
      }
    , { latin  = "aljara wa-alqiTTa"
      , arabic = "اَلْجارة وَالْقِطّة"
      , meaning = "the neighbor and the cat"
      }
    , { latin  = "qiTTa wa-alqiTTa"
      , arabic = "قِطّة وَالْقِطّة"
      , meaning = "a cat and the cat"
      }
    , { latin  = "2ayDaan"
      , arabic = "أَيْضاً"
      , meaning = "also"
      }
    , { latin  = "almaT3m"
      , arabic = "الْمَطْعْم"
      , meaning = "the restaurant"
      }
    , { latin  = "aljarii"
      , arabic = "اَلْجَري"
      , meaning = "the running"
      }
    , { latin  = "maa2"
      , arabic = "ماء"
      , meaning = "water"
      }
    , { latin  = "maT3am"
      , arabic = "مَطْعَم"
      , meaning = "a restaurant"
      }
    , { latin  = "alttaSwiir"
      , arabic = "اَلْتَّصْوير"
      , meaning = "photography"
      }
    , { latin  = "alnnawm"
      , arabic = "اَلْنَّوْم"
      , meaning = "sleeping"
      }
    , { latin  = "as-sibaaha"
      , arabic = "اَلْسِّباحة"
      , meaning = "swimming"
      }
    , { latin  = "Sabaahaan 2uhibb al2akl hunaa"
      , arabic = "صَباحاً أُحِبّ اَلْأَكْل هُنا"
      , meaning = "Inn the morning, I like eating here."
      }
    , { latin  = "kathiiraan"
      , arabic = "كَثيراً"
      , meaning = "much"
      }
    , { latin  = "hunaa"
      , arabic = "هُنا"
      , meaning = "here"
      }
    , { latin  = "jiddan"
      , arabic = "جِدَّاً"
      , meaning = "very"
      }
    , { latin  = "3an"
      , arabic = "عَن"
      , meaning = "about"
      }      
    , { latin  = "2uhibb al-ssafar 2ilaa 2iiiTaaliiaa"
      , arabic = "أُحِبّ اَلْسَّفَر إِلى إيطالْيا"
      , meaning = "I like traveling to Italy."
      }      
    , { latin  = "alkalaam ma3a 2abii"
      , arabic = "اَلْكَلام مَعَ أَبي"
      , meaning = "talking with my father"
      }      
    , { latin  = "alkalaam ma3a 2abii ba3d alDHDHahr"
      , arabic = "اَلْكَلام معَ أَبي بَعْد اَلْظَّهْر"
      , meaning = "talking with my father in the afternoon"
      }
    , { latin  = "2uhibb alssafar 2ilaa 2almaaniiaa"
      , arabic = "أُحِب اَلْسَّفَر إِلى أَلْمانيا"
      , meaning = "I like travelling to Germany"
      }
    , { latin  = "2uHibb aljarii bialllyl"
      , arabic = "أُحِبّ اَلْجَري بِالْلَّيْل"
      , meaning = "I like running at night."
      }
    , { latin  = "2uriidu"
      , arabic = "أُريدُ"
      , meaning = "I want"
      }
    , { latin  = "2uHibb 2iiiTaaliiaa 2ayDan"
      , arabic = "أُحِبّ إيطاليا أَيْضاً"
      , meaning = "I like Italy also."
      }
    , { latin  = "2uHibb alnnawm ba3d alDHDHhr"
      , arabic = "أحِبّ اَلْنَّوْم بَعْد اَلْظَّهْر"
      , meaning = "I like sleeping in the afternoon."
      }
    , { latin  = "2uHibb alqiraa2a 3an kuubaa biaalllayl"
      , arabic = "أُحِبّ اَلْقِراءة عَن كوبا بِالْلَّيْل"
      , meaning = "I like to read about Cuba at night."
      }
    , { latin  = "2uHibb alkalaam 3an alkitaaba"
      , arabic = "أحِبّ اَلْكَلام عَن اَلْكِتابة"
      , meaning = "I like talking about writing."
      }
    , { latin  = "alqur2aan"
      , arabic = "اَلْقُرْآن"
      , meaning = "Koran"
      }
    , { latin  = "bayt jamiil"
      , arabic = "بَيْت جَميل"
      , meaning = "a pretty house"
      }
    , { latin  = "bint suuriyya"
      , arabic = "بِنْت سورِيّة"
      , meaning = "a Syrian girl"
      }
    , { latin  = "mutarjim mumtaaz"
      , arabic = "مُتَرْجِم مُمْتاز"
      , meaning = "an amazing translator"
    }
    , { latin  = "jaami3a mashhuura"
      , arabic = "جامِعة مَشْهورة"
      , meaning = "a famous university"
      }
    , { latin  = "al-bayt al-jamiil"
      , arabic = "اَلْبَيْت اَلْجَميل"
      , meaning = "the pretty house"
      }
    , { latin  = "al-bint al-ssuuriyya"
      , arabic = "اَلْبِنْت اَلْسّورِيّة"
      , meaning = "a Syrian girl"
      }
    , { latin  = "al-mutarjim al-mumtaaz"
      , arabic = "اَلْمُتَرْجِم اَلْمُمْتاز"
      , meaning = "the amazing translator"
      }
    , { latin  = "al-jaami3a al-mashhuura"
      , arabic = "اَلْجامِعة اَلْمَشْهورة"
      , meaning = "the famous university"
      }
    , { latin  = "al-bayt jamiil"
      , arabic = "اَلْبَيْت جَميل"
      , meaning = "The house is pretty."
      }
    , { latin  = "al-bint suuriyya"
      , arabic = "البنت سورِيّة"
      , meaning = "The girl is Syrian."
      }
    , { latin  = "al-mutarjim mumtaaz"
      , arabic = "اَلْمُتَرْجِم مُمْتاز"
      , meaning = "The translator is amazing."
      }
    , { latin  = "al-jaami3a mashhuura"
      , arabic = "اَلْجامِعة مَشْهورة"
      , meaning = ""
      }
    , { latin  = "Haarr"
      , arabic = "حارّ"
      , meaning = "hot"
      }
    , { latin  = "maTar"
      , arabic = "مَطَر"
      , meaning = "rain"
      }
    , { latin  = "yawm Tawiil"
      , arabic = "يَوْم طَويل"
      , meaning = "a long day"
      }
    , { latin  = "Taqs baarid"
      , arabic = "طَقْس بارِد"
      , meaning = "cold weather"
      }
    , { latin  = "haathaa yawm Tawiil"
      , arabic = "هَذا يَوْم طَويل"
      , meaning = "This is a long day."
      }
    , { latin  = "shanTa fafiifa"
      , arabic = "شَنْطة خَفيفة"
      , meaning = "a light bag"
      }
    , { latin  = "mi3Taf khafiif"
      , arabic = "مِعْطَف خَفيف"
      , meaning = "a light coat"
      }
    , { latin  = "al-maTar al-ththaqiil mumtaaz"
      , arabic = "اَلْمَطَر اَلْثَّقيل مُمْتاز"
      , meaning = "The heavy rain is amazing."
      }
    , { latin  = "Taqs ghariib"
      , arabic = "طَقْس غَريب"
      , meaning = "a weird weather"
      }
    , { latin  = "yawm Haarr"
      , arabic = "يَوْم حارّ"
      , meaning = "a hot day"
      }
    , { latin  = "maTar khafiif"
      , arabic = "مَطَر خفيف"
      , meaning = "a light rain"
      }
    , { latin  = "Taawila khafiifa"
      , arabic = "طاوِلة خَفيفة"
      , meaning = "a light table"
      }
    , { latin  = "Taqs jamiil"
      , arabic = "طَقْس جَميل"
      , meaning = "a pretty weather"
      }
    , { latin  = "al-maTar al-ththaqiil mumtaaz"
      , arabic = "اَلْمَطَر اَلْثَّقيل مُمْتاز"
      , meaning = "The heavy rain is amazing."
      }
    , { latin  = "haathaa yawm Haarr"
      , arabic = "هَذا يَوْم حارّ"
      , meaning = "This is a hot day."
      }
    , { latin  = "shanTa khafiifa"
      , arabic = "شَنْطة خَفيفة"
      , meaning = "a light bag"
      }
    , { latin  = "hunaak maTar baarid jiddan"
      , arabic = "هُناك مَطَر بارِد جِدّاً"
      , meaning = "There is a very cold rain."
      }
    , { latin  = "Sayf"
      , arabic = "صّيْف"
      , meaning = "summer"
      }
    , { latin  = "shitaa2"
      , arabic = "شِتاء"
      , meaning = "winter"
      }
    , { latin  = "thitaa2 baarid"
      , arabic = "شِتاء بارِد"
      , meaning = "cold winter"
      }
    , { latin  = "binaaya 3aalya"
      , arabic = "بِناية عالْية"
      , meaning = "a high building"
      }
    , { latin  = "yawm baarid"
      , arabic = "يَوْم بارِد"
      , meaning = "a cold day"
      }
    , { latin  = "alyawm yawm baarid"
      , arabic = "اَلْيَوْم  يَوْم بارِد"
      , meaning = "Today is a cold day."
      }
    , { latin  = "ruTwwba 3aalya"
      , arabic = "رُطوبة عالْية"
      , meaning = "high humidity"
      }
    , { latin  = "al-rruTuuba al-3aalya"
      , arabic = "اَلْرَّطوبة الْعالْية"
      , meaning = "the high humidity"
      }
    , { latin  = "Sayf mumTir"
      , arabic = "صَيْف مُمْطِر"
      , meaning = "a rainy summer"
      }
    , { latin  = "al-rruTuuba al3aalya"
      , arabic = "اَلْرُّطوبة الْعالْية"
      , meaning = "the high humidity"
      }
    , { latin  = "al-TTaqs al-mushmis"
      , arabic = "اّلْطَّقْس الّْمُشْمِس"
      , meaning = "the sunny weather"
      }
    , { latin  = "shitaa2 mumTir"
      , arabic = "شِتاء مُمْطِر"
      , meaning = "a rainy winter"
      }      
    , { latin  = "Sayf Haarr"
      , arabic = "صَيْف حارّ"
      , meaning = "a hot summer"
      }      
    , { latin  = "al-yawm yawm Tawiil"
      , arabic = "اَلْيَوْم يَوْم طَويل"
      , meaning = "Today is a long day."
      }      
    , { latin  = "laa 2uhibb al-Taqs al-mushmis"
      , arabic = "لا أُحِبّ اَلْطَقْس اَلْمُشْمِس"
      , meaning = "I do not like sunny weather."
      }      
    , { latin  = "al-Taqs mumTir jiddan al-yawm"
      , arabic = "اَلْطَقْس مُمْطِر جِدّاً اَلْيَوْم"
      , meaning = "The weather is very rainy today."
      }
    , { latin  = "laa 2uhibb al-TTaqs al-mumTir"
      , arabic = "لا أحِبّ اَلْطَّقْس اَلْمُمْطِر"
      , meaning = "I do not like the rainy weather."
      }
    , { latin  = "al-TTaqs mushmis al-yawm"
      , arabic = "اَلْطَّقْس مُشْمِس اَلْيَوْم"
      , meaning = "The weather is sunny today."
      }
    , { latin  = "khariif"
      , arabic = "خَريف"
      , meaning = "fall, autumn"
      }
    , { latin  = "qamar"
      , arabic = "قَمَر"
      , meaning = "moon"
      }
    , { latin  = "rabiir"
      , arabic = "رَبيع"
      , meaning = "spring"
      }
    , { latin  = "al-shishitaa2 mumTir"
      , arabic = "اَلْشِّتاء مُمْطِر"
      , meaning = "The winter is rainy."
      }
    , { latin  = "al-SSayf al-baarid"
      , arabic = "اَلْصَّيْف اَلْبارِد"
      , meaning = "the cold summer"
      }
    , { latin  = "al-qamar al-2abyab"
      , arabic = "اَلْقَمَر اَلْأَبْيَض"
      , meaning = "the white moon"
      }
    , { latin  = "al-shishitaa2 Tawiil wa-baarid"
      , arabic = "اَلْشِّتاء طَويل وَبارِد"
      , meaning = "The winter is long and cold."
      }
    , { latin  = "al-rrabii3 mumTir al-aan"
      , arabic = "اَلْرَّبيع مُمْطِر اَلآن"
      , meaning = "The winter is rainy now"
      }
    , { latin  = "Saghiir"
      , arabic = "صَغير"
      , meaning = "small"
      }
    , { latin  = "kashiiran"
      , arabic = "كَثيراً"
      , meaning = "a lot, much"
      }
    , { latin  = "al-ssuudaan"
      , arabic = "اَلْسّودان"
      , meaning = "Sudan"
      }
    , { latin  = "as-siin"
      , arabic = "اَلْصّين"
      , meaning = "China"
      }
    , { latin  = "al-qaahira"
      , arabic = "اَلْقاهِرة"
      , meaning = "Cairo"
      }
    , { latin  = "al-bunduqiyya"
      , arabic = "اَلْبُنْدُقِية"
      , meaning = "Venice"
      }
    , { latin  = "filasTiin"
      , arabic = "فِلَسْطين"
      , meaning = "Palestine"
      }
    , { latin  = "huulandaa"
      , arabic = "هولَنْدا"
      , meaning = "Netherlands"
      }
    , { latin  = "baghdaad"
      , arabic = "بَغْداد"
      , meaning = "Bagdad"
      }
    , { latin  = "Tuukyuu"
      , arabic = "طوكْيو"
      , meaning = "Tokyo"
      }
    , { latin  = "al-yaman"
      , arabic = "اَلْيَمَن"
      , meaning = "Yemen"
      }
    , { latin  = "SaaHil Tawiil"
      , arabic = "ساحَل طَويل"
      , meaning = "a long coast"
      }
    , { latin  = "al-2urdun"
      , arabic = "اَلْأُرْدُن"
      , meaning = "Jordan"
      }      
    , { latin  = "haathaa al-balad"
      , arabic = "هَذا الْبَلَد"
      , meaning = "this country"
      }      
    , { latin  = "2ayn baladik yaa riim"
      , arabic = "أَيْن بَلَدِك يا ريم"
      , meaning = "Where is your country, Reem?"
      }      
    , { latin  = "baldii mumtaaz"
      , arabic = "بَلَدي مُمْتاز"
      , meaning = "My country is amazing."
      }      
    , { latin  = "haathaa balad-haa"
      , arabic = "هَذا بَلَدها"
      , meaning = "This is her country."
      }      
    , { latin  = "hal baladak jamiil yaa juurj?"
      , arabic = "هَل بَلَدَك جَميل يا جورْج"
      , meaning = "Is your country pretty, George"
      }
    , { latin  = "al-yaman balad Saghiir"
      , arabic = "اَلْيَمَن بَلَد صَغير"
      , meaning = "Yemen is a small country."
      }
    , { latin  = "qaari2"
      , arabic = "قارِئ"
      , meaning = "reader"
      }
    , { latin  = "ghaa2ib"
      , arabic = "غائِب"
      , meaning = "absent"
      }
    , { latin  = "mas2uul"
      , arabic = "مَسْؤول"
      , meaning = "responsoble, administrator"
      }
    , { latin  = "jaa2at"
      , arabic = "جاءَت"
      , meaning = "she came"
      }
    , { latin  = "3indii"
      , arabic = "عِنْدي"
      , meaning = "I have"
      }
    , { latin  = "3indik"
      , arabic = "عِنْدِك"
      , meaning = "you have"
      }
    , { latin  = "ladii kitaab"
      , arabic = "لَدي كِتاب"
      , meaning = "I have a book."
      }
    , { latin  = "3indhaa"
      , arabic = "عِنْدها"
      , meaning = "she has"
      }      
    , { latin  = "3indhu"
      , arabic = "عِنْدهُ"
      , meaning = "he has"
      }      
    , { latin  = "laysa 3indhu"
      , arabic = "لَيْسَ عِنْدهُ"
      , meaning = "he does not have"
      }      
    , { latin  = "laysa 3indhaa"
      , arabic = "لَيْسَ عِنْدها"
      , meaning = "she does not have"
      }      
    , { latin  = "hunaak maTar thaqiil"
      , arabic = "هُناك مَطَر ثَقيل"
      , meaning = "There is a heavy rain."
      }
    , { latin  = "hunaak wishaaH fii shanTatii"
      , arabic = "هُناك وِشاح في شَنْطتي"
      , meaning = "There is a scarf in my bag."
      }
    , { latin  = "laysa hunaak lugha Sa3ba"
      , arabic = "لَيْسَ هُناك لُغة صَعْبة"
      , meaning = "There is no difficult language."
      }
    , { latin  = "2amaamii rajul ghariib"
      , arabic = "أَمامي رَجُل غَريب"
      , meaning = "There is a weird man in front of me."
      }
    , { latin  = "fii al-khalfiyya bayt"
      , arabic = "في الْخَلفِيْة بَيْت"
      , meaning = "There is a house in the background."
      }      
    , { latin  = "fii shanTatii wishaaH"
      , arabic = "في شَنْطَتي وِشاح"
      , meaning = "There is a scarf in my bag."
      }
    , { latin  = "asad"
      , arabic = "أَسَد"
      , meaning = "a lion"
      }
    , { latin  = "2uHibb 2asadii laakibb la 2uHibb 2usadhaa"
      , arabic = "أحِبَ أَسَدي لَكِنّ لا أُحِبّ أَسَدها"
      , meaning = "I like my lion but I do not like her lion."
      }
    , { latin  = "laysa 3indhu"
      , arabic = "لَيْسَ عِنْدهُ"
      , meaning = "he does not have"
      }
    , { latin  = "3indhaa kalb wa-qiTTa"
      , arabic = "عِنْدها كَلْب وَقِطّة"
      , meaning = "She has a doc and a cat."
      }
    , { latin  = "Sadiiqatu"
      , arabic = "صَديقَتهُ سامْية غَنِيّة"
      , meaning = "His friend Samia is rich."
      }
    , { latin  = "taariikhiyya"
      , arabic = "تاريخِيّة"
      , meaning = "historical"
      }
    , { latin  = "juurj 3indhu 3amal mumtaaz"
      , arabic = "جورْج عِنْدهُ عَمَل مُمْتاز"
      , meaning = "George has an amazing work."
      }
    , { latin  = "Sadiiqii taamir ghaniyy jiddan"
      , arabic = "صَديقي تامِر غَنِيّ جِدّاً"
      , meaning = "My friend Tamer is very rich"
      }
    , { latin  = "laa 2a3rif haadhaa l-2asad"
      , arabic = "لا أَعْرِف هَذا الْأَسّد"
      , meaning = "I do not know this lion."
      }
    , { latin  = "laysa 3indhu mi3Taf"
      , arabic = "لَيْسَ عِنْدهُ مِعْطَف"
      , meaning = "He does not have a coat."
      }
    , { latin  = "fii l-khalfiyya zawjatak ya siith"
      , arabic = "في الْخَلْفِيّة زَوْجَتَك يا سيث"
      , meaning = "There is your wife in background, Seth"
      }
    , { latin  = "su2uaal"
      , arabic = "سُؤال"
      , meaning = "a question"
      }
    , { latin  = "Sadiiqat-hu saamya laabisa tannuura"
      , arabic = "صدَيقَتهُ سامْية لابِسة تّنّورة"
      , meaning = "His friend Samia is wering a skirt."
      }
    , { latin  = "wa-hunaa fii l-khalfitta rajul muDHik"
      , arabic = "وَهُنا في الْخَلْفِتّة رَجُل مُضْحِك"
      , meaning = "And here in the background there is a funny man."
      }
    , { latin  = "man haadhaa"
      , arabic = "مَن هَذا"
      , meaning = "Who is this?"
      }
    , { latin  = "hal 2anti labisa wishaaH ya lamaa"
      , arabic = "هَل أَنْتِ لابِسة وِشاح يا لَمى"
      , meaning = "Are you wering a scarf, Lama?"
      }
    , { latin  = "2akhii bashiir mashghuul"
      , arabic = "أَخي بَشير مَشْغول"
      , meaning = "My brother Bashir is busy."
      }
    , { latin  = "fii hathihi lssuura aimraa muDHika"
      , arabic = "في هَذِهِ الْصّورة اِمْرأة مُضْحِكة"
      , meaning = "Thre is a funny woman in this picture."
      }
    , { latin  = "hal 2anta laabis qubb3a ya siith"
      , arabic = "هَل أَنْتَ لابِس قُبَّعة يا سيث"
      , meaning = "Are you wearing a hat, Seth?"
      }
    , { latin  = "fii l-khalfiyya rajul muDHik"
      , arabic = "في الْخَلْفِيّة رَجُل مُضْحِك"
      , meaning = "There is a funny man in the background."
      }
    , { latin  = "shubbaak"
      , arabic = "شُبّاك"
      , meaning = "a window"
      }
    , { latin  = "sariir"
      , arabic = "سَرير"
      , meaning = "a bed"
      }
    , { latin  = "muHammad 2ustaadhii"
      , arabic = "مُحَمَّد أُسْتاذي"
      , meaning = "Muhammed is my teacher."
      }
    , { latin  = "saadii 2ustaadhii"
      , arabic = "شادي أُسْتاذي"
      , meaning = "Sadie is my teacher."
      }
    , { latin  = "2ummhu"
      , arabic = "أُمّهُ"
      , meaning = "his mother"
      }
    , { latin  = "tilfaaz"
      , arabic = "تِلْفاز"
      , meaning = "a television"
      }
    , { latin  = "ma haadhaa as-sawt"
      , arabic = "ما هَذا الْصَّوْت"
      , meaning = "What is this noise"
      }
    , { latin  = "2adkhul al-Hammaam"
      , arabic = "أَدْخُل اَلْحَمّام"
      , meaning = "I enter the bathroom."
      }
    , { latin  = "2uHibb al-ssariir al-kabiir"
      , arabic = "أُحِبّ اَلْسَّرير اَلْكَبير"
      , meaning = "I love the big bed."
      }
    , { latin  = "hunaak mushkila ma3 lt-tilfaaz"
      , arabic = "هُناك مُشْكِلة مَعَ الْتِّلْفاز"
      , meaning = "There is a problem with the television."
      }
    , { latin  = "al-haatif mu3aTTal wa-lt-tilfaaz 2ayDan"
      , arabic = "اَلْهاتِف مُعَطَّل وَالْتَّلْفاز أَيضاً"
      , meaning = "The telephone is out of order and the television also."
      }
    , { latin  = "hunaak Sawt ghariib fii l-maTbakh"
      , arabic = "هُناك صَوْت غَريب في الْمَطْبَخ"
      , meaning = "There is a weird nose in the kitchen."
      }
    , { latin  = "2anaam fii l-ghurfa"
      , arabic = "أَنام في الْغُرْفة"
      , meaning = "I sleep in the room."
      }
    , { latin  = "tilfaaz Saghiir fii Saaluun kabiir"
      , arabic = "تِلْفاز صَغير في صالون كَبير"
      , meaning = "a small television in a big living room"
      }
    , { latin  = "2anaam fii sariir maksuur"
      , arabic = "أَنام في سَرير مَكْسور"
      , meaning = "I sleep in a broken bed."
      }
    , { latin  = "as-sariir al-kabiir"
      , arabic = "اَلْسَّرير اَلْكَبير"
      , meaning = "the big bed"
      }
    , { latin  = "maa haadhaa aSSwut"
      , arabic = "ما هَذا الصّوُت"
      , meaning = "What is this noise?"
      }
    , { latin  = "sariirii mumtaaz al-Hamdu lila"
      , arabic = "سَريري مُمتاز اَلْحَمْدُ لِله"
      , meaning = "My bed is amazing, praise be to God"
      }
    , { latin  = "2anaam kathiiran"
      , arabic = "أَنام كَشيراً"
      , meaning = "I sleep a lot"
      }
    , { latin  = "hunaak Sawt ghariib"
      , arabic = "هُناك صَوْت غَريب"
      , meaning = "There is a weird noise."
      }
    , { latin  = "shubbaak"
      , arabic = "شُبّاك"
      , meaning = "a window"
      }
    , { latin  = "2anaam fii sariir Saghiir"
      , arabic = "أَنام في سَرير صَغير"
      , meaning = "I sleep in a small bed."
      }
    , { latin  = "muHammad 2ustaadhii"
      , arabic = "مُحَمَّد أُسْتاذي"
      , meaning = "Muhammad is my teacher."
      }
    , { latin  = "mahaa 2ummhu"
      , arabic = "مَها أُمّهُ"
      , meaning = "Maha is his mother."
      }
    , { latin  = "fii haadhaa lsh-shaari3 Sawt ghariib"
      , arabic = "في هٰذا ٱلْشّارِع صَوْت غَريب"
      , meaning = "There is a weird nose on this street"
      }
    , { latin  = "2askun fii ls-saaluun"
      , arabic = "أَسْكُن في الْصّالون"
      , meaning = "I live in the living room."
      }
    , { latin  = "haadhaa lsh-shaar3"
      , arabic = "هَذا الْشّارِع"
      , meaning = "this street"
      }
    , { latin  = "fii lT-Taabiq al-2awwal"
      , arabic = "في الْطّابِق اَلْأَوَّل"
      , meaning = "on the first floor"
      }
    , { latin  = "Hammaam"
      , arabic = "حَمّام"
      , meaning = "bathroom"
      }
    , { latin  = "alsh-shaanii"
      , arabic = "اَلْثّاني"
      , meaning = "the second"
      }
    , { latin  = "3and-hu ghurfa nawm Saghiira"
      , arabic = "عِندهُ غُرْفة نَوْم صَغيرة"
      , meaning = "He has a small bedroom."
      }
    , { latin  = "laa 2aftaH albaab bisabab lT-Taqs"
      , arabic = "لا أَفْتَح اَلْباب بِسَبَب اّلْطَّقْس"
      , meaning = "I do not open the door because of the weather."
      }
    , { latin  = "Sifr"
      , arabic = "صِفْر"
      , meaning = "zero"
      }
    , { latin  = "3ashara"
      , arabic = "عَشَرَة"
      , meaning = "ten"
      }
    , { latin  = "waaHid"
      , arabic = "وَاحِد"
      , meaning = "one"
      }
    , { latin  = "2ithnaan"
      , arabic = "اِثْنان"
      , meaning = "two"
      }
    , { latin  = "kayf ta3uddiin min waaHid 2ilaa sitta"
      , arabic = "كَيْف تَعُدّين مِن ١ إِلى ٦"
      , meaning = "How do you count from one to six?"
      }
    , { latin  = "bil-lugha"
      , arabic = "بِالْلُّغة"
      , meaning = "in language"
      }
    , { latin  = "bil-lugha l-3arabyya"
      , arabic = "بِالْلُّغة الْعَرَبِيّة"
      , meaning = "in the arabic language"
      }
    , { latin  = "ta3rifiin"
      , arabic = "تَعْرِفين"
      , meaning = "you know"
      }    
    , { latin  = "hal ta3rifiin kull shay2 yaa mahaa"
      , arabic = "هَل تَعْرِفين كُلّ شَيء يا مَها"
      , meaning = "Do you know everything Maha?"
      }    
    , { latin  = "kayf ta3udd yaa 3umar"
      , arabic = "كَيْف تَعُدّ يا عُمَر"
      , meaning = "How do you count Omar?"
      }
    , { latin  = "Kayf ta3udd min Sifr 2ilaa 2ashara yaa muHammad"
      , arabic = "كَيْف تَعُدّ مِن٠ إِلى ١٠ يا مُحَمَّد"
      , meaning = "How do you count from 0 to 10 , Mohammed?"
      }
    , { latin  = "hal ta3rif yaa siith"
      , arabic = "هَل تَعْرِف يا سيث"
      , meaning = "Do you know Seth?"
      }
    , { latin  = "bayt buub"
      , arabic = "بَيْت بوب"
      , meaning = "Bob's house"
      }
    , { latin  = "maT3am muHammad"
      , arabic = "مَطْعَم مُحَمَّد"
      , meaning = "Mohammed's restaurant"
      }
    , { latin  = "SaHiifat al-muhandis"
      , arabic = "صَحيفة اَلْمُهَنْدِس"
      , meaning = "the enginner's newspaper"
      }
    , { latin  = "madiinat diitruuyt"
      , arabic = "مَدينة ديتْرويْت"
      , meaning = "the city of Detroit"
      }
    , { latin  = "wilaayat taksaas"
      , arabic = "وِلاية تَكْساس"
      , meaning = "the state of Texas"
      }
    , { latin  = "jaami3at juurj waashinTun"
      , arabic = "جامِعة جورْج واشِنْطُن"
      , meaning = "George Washinton University"
      }
    , { latin  = "shukuran"
      , arabic = "شُكْراً"
      , meaning = "thank you"
      }
    , { latin  = "SabaaHan"
      , arabic = "صَباحاً"
      , meaning = "in the morning"
      }
    , { latin  = "masaa-an"
      , arabic = "مَساءً"
      , meaning = "in the evening"
      }
    , { latin  = "wayaatak"
      , arabic = "وِلايَتَك"
      , meaning = "your state"
      }
    , { latin  = "madiina saaHiliyya"
      , arabic = "مَدينة ساحِلِيّة"
      , meaning = "a coastal city"
      }
    , { latin  = "muzdaHima"
      , arabic = "مُزْدَحِمة"
      , meaning = "crowded"
      }
    , { latin  = "wilaaya kaaliifuurniyaa"
      , arabic = "وِلاية كاليفورْنْيا"
      , meaning = "the state of California"
      }
    , { latin  = "luus 2anjiaalis"
      , arabic = "لوس أَنْجِلِس"
      , meaning = "Los Angeles"
      }
    , { latin  = "baHr"
      , arabic = "بَحْر"
      , meaning = "sea"
      }
    , { latin  = "al-baHr al-2abyaD al-mutawassaT"
      , arabic = "اَاْبَحْر اَلْأَبْيَض اَلْمُتَوَسِّط"
      , meaning = "the Meditteranean Sea"
      }
    , { latin  = "lil2asaf"
      , arabic = "لٍلْأَسَف"
      , meaning = "unfortunately"
      }
    , { latin  = "DawaaHii"
      , arabic = "ضَواحي"
      , meaning = "suburbs"
      }
    , { latin  = "taskuniin"
      , arabic = "تَسْكُنين"
      , meaning = "you live"
      }
    , { latin  = "nyuuyuurk"
      , arabic = "نْيويورْك"
      , meaning = "New York"
      }
    , { latin  = "qaryatik"
      , arabic = "قَرْيَتِك"
      , meaning = "your village"
      }
    , { latin  = "shubbaak"
      , arabic = "شُبّاك"
      , meaning = "a window"
      }
    , { latin  = "jaziira"
      , arabic = "جَزيرة"
      , meaning = "an island"
      }
    , { latin  = "Tabii3a"
      , arabic = "طَبيعة"
      , meaning = "nature"
      }
    , { latin  = "al-2iskandariyya"
      , arabic = "اَلْإِسْكَندَرِيّة"
      , meaning = "Alexandria"
      }
    , { latin  = "miSr"
      , arabic = "مِصْر"
      , meaning = "Egypt"
      }
    , { latin  = "na3am"
      , arabic = "نَعَم"
      , meaning = "yes"
      }
    , { latin  = "SabaaH l-khayr"
      , arabic = "صَباح اَلْخَيْر"
      , meaning = "Good morning."
      }
    , { latin  = "SabaaH an-nuur"
      , arabic = "صَباح اَلْنّور"
      , meaning = "Good morning."
      }
    , { latin  = "masaa2 al-khayr"
      , arabic = "مَساء اَلْخَيْر"
      , meaning = "Good evening"
      }
    , { latin  = "masaa2 an-nuur"
      , arabic = "مَساء اَلْنّور"
      , meaning = "Good evening."
      }
    , { latin  = "as-salaamu 3alaykum"
      , arabic = "اَلْسَّلامُ عَلَيْكُم"
      , meaning = "Peace be upon you."
      }
    , { latin  = "wa-3alaykumu as-salaam"
      , arabic = "وَعَلَيْكُمُ ٲلْسَّلام"
      , meaning = ""
      }
    , { latin  = "tasharrafnaa"
      , arabic = "تَشَرَّفْنا"
      , meaning = "It's a pleasure to meet you."
      }
    , { latin  = "hal 2anta bikhyr"
      , arabic = "هَل أَنْتَ بِخَيْر"
      , meaning = "Are you well?"
      }
    , { latin  = "kayfak"
      , arabic = "كَيْفَك"
      , meaning = "How are you?"
      }
    , { latin  = "al-yawm"
      , arabic = "اَلْيَوْم"
      , meaning = "today"
      }
    , { latin  = "kayfik al-yawm"
      , arabic = "كَيْفِك اَلْيَوْم"
      , meaning = "How are you today?"
      }
    , { latin  = "marHaban ismii buub"
      , arabic = "مَرْحَباً اِسْمي بوب"
      , meaning = "Hello, my name is Bob."
      }
    , { latin  = "Haziin"
      , arabic = "حَزين"
      , meaning = "sad"
      }
    , { latin  = "mariiD"
      , arabic = "مَريض"
      , meaning = "sick"
      }
    , { latin  = "yawm sa3iid"
      , arabic = "يَوْم سَعيد"
      , meaning = "Have a nice day."
      }
    , { latin  = "sa3iid"
      , arabic = "سَعيد"
      , meaning = "happy"
      }
    , { latin  = "2anaa Haziinat l-yawm"
      , arabic = "أَنا حَزينة الْيَوْم"
      , meaning = "I am sad today."
      }
    , { latin  = "2anaa Haziin jiddan"
      , arabic = "أَنا حَزين جِدّاً"
      , meaning = "I am very sad."
      }
    , { latin  = "2anaa mariiDa lil2asaf"
      , arabic = "أَنا مَريضة لِلْأَسَف"
      , meaning = "I am sick unfortunately."
      }
    , { latin  = "2ilaa l-laqaa2 yaa Sadiiqii"
      , arabic = "إِلى الْلِّقاء يا صَديقي"
      , meaning = "Until next time, my friend."
      }
    , { latin  = "na3saana"
      , arabic = "نَعْسانة"
      , meaning = "sleepy"
      }
    , { latin  = "mutaHammis"
      , arabic = "مُتَحَمِّس"
      , meaning = "excited"
      }
    , { latin  = "maa 2ismak"
      , arabic = "ما إِسْمَك"
      , meaning = "What is your name?"
      }
    , { latin  = "2ana na3saan"
      , arabic = "أَنا نَعْسان"
      , meaning = "I am sleepy."
      }
    , { latin  = "yallaa 2ilaa l-liqaa2"
      , arabic = "يَلّإِ إِلى الْلَّقاء"
      , meaning = "Alriht, until next time."
      }
    , { latin  = "ma3a as-alaama"
      , arabic = "مَعَ الْسَّلامة"
      , meaning = "Goodbye."
      }
    , { latin  = "tamaam"
      , arabic = "تَمام"
      , meaning = "OK"
      }
    , { latin  = "2ana tamaam al-Hamdu lillah"
      , arabic = "أَنا تَمام اَلْحَمْدُ لِله"
      , meaning = "I am OK , praise be to God."
      }
     , { latin  = "maa al2akhbaar"
       , arabic = "ما الْأَخْبار"
       , meaning = "What is new?"
       }
    , { latin  = "al-bathu alhii"
      , arabic = "اَلْبَثُ اَلْحي"
      , meaning = "live broadcast"
      }
    , { latin  = "2ikhtar"
      , arabic = "إِخْتَر"
      , meaning = "choose"
      }
    , { latin  = "sayyaara"
      , arabic = "سَيّارة"
      , meaning = "a car"
      }
    , { latin  = "2ahlan wa-sahlan"
      , arabic = "أَهْلاً وَسَهْلاً"
      , meaning = "welcom"
      }
    , { latin  = "2akh ghariib"
      , arabic = "أَخ غَريب"
      , meaning = "a weird brother"
      }
    , { latin  = "2ukht muhimma"
      , arabic = "أُخْت مُهِمّة"
      , meaning = "an important sister"
      }
    , { latin  = "ibn kariim wa-mumtaaz"
      , arabic = "اِبْن كَريم وَمُمْتاز"
      , meaning = "a generous and amazing son"
      }
    , { latin  = "2ab"
      , arabic = "أَب"
      , meaning = "a father"
      }      
    , { latin  = "2umm"
      , arabic = "أُمّ"
      , meaning = "a mother"
      }
    , { latin  = "abn"
      , arabic = "اِبْن"
      , meaning = "a son"
      }
    , { latin  = "mumti3"
      , arabic = "مُمْتِع"
      , meaning = "fun"
      }
    , { latin  = "muHaasib"
      , arabic = "مُحاسِب"
      , meaning = "an accountant"
      }
    , { latin  = "ma-smika ya 2ustaadha"
      , arabic = "ما اسْمِك يا أُسْتاذة"
      , meaning = "Whatis your name ma'am?"
      }
    , { latin  = "qiTTatak malika"
      , arabic = "قِطَّتَك مَلِكة"
      , meaning = "Your cat is a queen."
      }
    , { latin  = "jadda laTiifa wa-jadd laTiif"
      , arabic = "جَدّة لَطيفة وَجَدّ لَطيف"
      , meaning = "a kind grandmother and a kind grandfather"
      }
    , { latin  = "qiTTa jadiida"
      , arabic = "قِطّة جَديدة"
      , meaning = "a new cat"
      }
    , { latin  = "hal jaddatak 2ustaadha"
      , arabic = "هَل جَدَّتَك أُسْتاذة"
      , meaning = "Is your grandmother a professor?"
      }
     , { latin  = "hal zawjatak 2urduniyya"
       , arabic = "هَل زَوْجَتَك أُرْدُنِتّة"
       , meaning = "Is your wife a Jordanian?"
       }
    , { latin  = "mu3allim"
      , arabic = "مُعَلِّم"
      , meaning = "a teacher"
      }
    , { latin  = "dhakiyya"
      , arabic = "ذَكِيّة"
      , meaning = "smart"
      }
    , { latin  = "jaaratii"
      , arabic = "جارَتي"
      , meaning = "my neighbor"
      }
    , { latin  = "ma3Taf"
      , arabic = "مَعْطَف"
      , meaning = "a coat"
      }
    , { latin  = "qubba3a zarqaa2 wa-bunniyya"
      , arabic = "قُبَّعة زَرْقاء وَبُنّية"
      , meaning = "a blue ad brown hat"
      }
    , { latin  = "bayDaa2"
      , arabic = "بَيْضاء"
      , meaning = "white"
      }
    , { latin  = "al-2iijaar jayyd al-Hamdu lila"
      , arabic = "اَلْإِيجار جَيِّد اَلْحَمْدُ لِله"
      , meaning = "The rent is good, praise be to God."
      }
    , { latin  = "jaami3a ghaalya"
      , arabic = "جامِعة غالْية"
      , meaning = "an expensive university"
      }
    , { latin  = "haadhaa Saaluun qadiim"
      , arabic = "هَذا صالون قَديم"
      , meaning = "This is an old living room."
      }
    , { latin  = "haadhihi Hadiiqa 3arabiyya"
      , arabic = "هَذِهِ حَديقة عَرَبِيّة"
      , meaning = ""
      }
    , { latin  = "al-HaaiT"
      , arabic = "اَلْحائِط"
      , meaning = "the wall"
      }
    , { latin  = "hunaak shanTa Saghiira"
      , arabic = "هُناك شَنطة صَغيرة"
      , meaning = "There is a small bag."
      }
    , { latin  = "2abii hunaak"
      , arabic = "أَبي هُناك"
      , meaning = "My father is there."
      }
    , { latin  = "haatifak hunaak yaa buub"
      , arabic = "هاتِفَك هُناك يا بوب"
      , meaning = "Your telephone is there, Bob."
      }
    , { latin  = "haatifii hunaak"
      , arabic = "هاتِفي هُناك"
      , meaning = "My telephone is there."
      }
    , { latin  = "hunaak 3ilka wa-laab tuub fii shanTatik"
      , arabic = "هُناك عِلكة وَلاب توب في شَنطَتِك"
      , meaning = "There is a chewing gum and a laptop in your bag."
      }
    , { latin  = "raSaaS"
      , arabic = "رَصاص"
      , meaning = "lead"
      }
    , { latin  = "qalam raSaaS"
      , arabic = "قَلَم رَصاص"
      , meaning = "a pencil"
      }
    , { latin  = "mu2al-lif"
      , arabic = "مُؤَلِّف"
      , meaning = "an author"
      }


    ]
