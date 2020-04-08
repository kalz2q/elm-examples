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


      كبيرة
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
    , { latin = "tannuurah"
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
      , meaning = "good, nice"
      }
    , { latin = "kalb"
      , arabic = "كَلْب"
      , meaning = "a dog"
      }
    , { latin = "2azraq"
      , arabic = "أَزْرَق"
      , meaning = "blue"
      }
    , { latin = "2abyad"
      , arabic = "أَبْيَض "
      , meaning = "white"
      }
    , { latin = "qubb3ah"
      , arabic = "قُبَّعة"
      , meaning = "a hat"
      }
    , { latin = "bunniyy"
      , arabic = "بُنِّيّ"
      , meaning = "brown"
      }

    , { latin  = "mruu2a"
      , arabic = "مْروءة"
      , meaning = "chivalry"
      }

    , { latin  = "kitaab"
      , arabic = "كِتاب"
      , meaning = "a book"
      }



    , { latin  = "Taawilah"
      , arabic = "طاوِلة"
      , meaning = "a table"
      }

    , { latin  = "haadhihi"
      , arabic = "هاذِهِ"
      , meaning = "this is"
      }
    , { latin  = "hadhihi madiinA qadiinA"
      , arabic = "هَذِهِ مَدينة قَديمة"
      , meaning = "This is an ancient city"
      }


    , { latin  = "HadiiqA"
      , arabic = "حَديقة"
      , meaning = "garden"
      }


    , { latin  = "hadhihi HadiiqA 2arabyyA"
      , arabic = "هَذِهِ حَديقة عَرَبيّة"
      , meaning = "this is an Arab garden"
      }

    , { latin  = "hadhihi binaayA jamiilA"
      , arabic = "هَذِهِ بِناية جَميلة"
      , meaning = "this is a beautiful building"
      }

    , { latin  = "hadhaa muhammad"
      , arabic = "هَذا مُحَمَّد"
      , meaning = "this is mohamed"
      }

    , { latin  = "hadhaa Saaluun ghaalii"
      , arabic = "هَذا صالون غالي"
      , meaning = "this is an expensive living room"
      }

    , { latin  = "hadhihi HadiiqA jamiilA"
      , arabic = "هَذِهِ حَديقة جَميلة"
      , meaning = "this is a pretty garden"
      }


        , { latin  = "hadhihi HadiiqA qadiima"
      , arabic = "هَذِهِ حَديقة قَديمة"
      , meaning = "this is an old garden"
      }


    , { latin  = "alHa2iT"
      , arabic = "الْحائط"
      , meaning = "the wall"
      }
    , { latin  = "Ha2iT"
      , arabic = "حائِط"
      , meaning = "wall"
      }

    , { latin  = "hadhaa alHaa2iT kabiir"
      , arabic = "هَذا الْحائِط كَبير "
      , meaning = "this wall is big"
      }

    , { latin = "alkalb"
      , arabic = "الْكَلْب"
      , meaning = "the dog"
      }

    , { latin  = "hadhihi albinaayA"
      , arabic = "هذِهِ الْبِناية "
      , meaning = "this building"
      }

    , { latin  = "alghurfA"
      , arabic = "اَلْغُرفة"
      , meaning = "the room"
      }
    , { latin  = "alghurfA kaBiirA"
      , arabic = "اَلْغرْفة كَبيرة"
      , meaning = "the room is big"
      }

    , { latin  = "hadhihi alghurfA kabiirA"
      , arabic = "هَذِهِ الْغُرْفة كَبيرة"
      , meaning = "this room is big"
      }
    , { latin  = "hadhaa alkalb kalbii"
      , arabic = "هَذا  الْكَلْب كَْلبي"
      , meaning = "this dog is my dog"
      }

    , { latin  = "hadhaa alkalb jaw3aan"
      , arabic = "هَذا الْكَلْب جَوْعان"
      , meaning = "this dog is hungry"
      }
    , { latin  = "hadhihi albinaayA waas3A"
      , arabic = "هَذِهِ الْبناية واسِعة"
      , meaning = "this building is spacious"
      }
    , { latin  = "alkalb ghariib"
      , arabic = "اَلْكَلْب غَريب"
      , meaning = "the dog is weird"
      }
    , { latin  = "alkalb kalbii"
      , arabic = "اَلْكَلْب كَلْبي"
      , meaning = "the dog is my dog"
      }



    -- , { latin  = ""
    --   , arabic = ""
    --   , meaning = ""
    --   }
    -- , { latin  = ""
    --   , arabic = ""
    --   , meaning = ""
    --   }


    -- , { latin  = ""
    --   , arabic = ""
    --   , meaning = ""
    --   }
    -- , { latin  = ""
    --   , arabic = ""
    --   , meaning = ""
    --   }

    ]
