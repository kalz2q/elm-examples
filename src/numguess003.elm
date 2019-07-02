module NumGuess003 exposing (main)


-- 001 is working, mission for 002 is
-- simplify input logic
-- numguess.elmと並べて変更する
-- modelをinput : String => Maybe Intにする
-- modelをtypedGuess , submittedGuessをひとつにする
-- guess : Maybe Intにしよう



import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE
import Random

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { guess : Maybe Int -- Nothing if invalid Int
    -- , submittedGuess : Maybe Int
    , answer : Int
    , totalGuesses : Int
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( { guess = Nothing
    --   , submittedGuess = Nothing
      , answer = 0 -- Default to 0 for now. There are better ways to model this
      , totalGuesses = 0
      }
    , Random.generate NewRandom (Random.int 1 10)
    )

type Msg
    = NewRandom Int
    | TypedText String
    | SubmitGuess




update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewRandom answer ->
            ( { model | answer = answer }
            , Cmd.none
            )

        TypedText inputString ->
            ( { model | guess = String.toInt inputString }
            , Cmd.none
            )

        SubmitGuess ->
            ( { model
                | guess = Nothing
                -- , submittedGuess = model.typedGuess
                , totalGuesses = model.totalGuesses + 1
              }
            , Cmd.none
            )



view : Model -> Html.Html Msg
view model =
    Html.div
        []
        [ Html.div
            []
            [ Html.input
                [ HA.type_ "text"
                , HE.onInput TypedText
                ,  HA.value (Maybe.withDefault "" (Maybe.map String.fromInt  model.guess))
                ]
                []
            , Html.button
                [ HE.onClick SubmitGuess ]
                [ Html.text "Guess!" ]
            ]
        , Html.div [] [ Html.text ( "Guesses: " ++ String.fromInt model.totalGuesses ) ]
        , feedbackText model
        ]


feedbackText : Model -> Html.Html Msg
feedbackText model =
    case model.guess of
        Just guess ->
            if guess == model.answer then
                Html.div [] [ Html.text  ( "You correctly guessed " ++ String.fromInt model.answer )]

            else if guess > model.answer then
                Html.div [] [ Html.text "Too high!" ]

            else
                Html.div [] [ Html.text "Too low!" ]

        Nothing ->
            Html.text ""
