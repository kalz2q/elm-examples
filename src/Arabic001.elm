module Arabic001 exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE


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
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" "" ""
    , Cmd.none
    )


type Msg
    = Delete
    | KeepNext


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Delete ->
            ( model
            , Cmd.none
            )

        KeepNext ->
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

    --, { latin  = "2alaykum"
    --   , arabic = "عَلَيْكُمْ"
    --   , meaning = "on you"
    -- }
    ]
