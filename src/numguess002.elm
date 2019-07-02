module NumGuess002 exposing (main)

-- this version of number guessing game is from learn discourse
-- fairly simple but a bit too safe about inputting
-- 001 is working, mission for 002 is
-- simplify input logic
-- 反応しないことよりちゃんと反応することの方が親切だと思います


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
    { typedGuess : Maybe Int -- Nothing if invalid Int
    , submittedGuess : Maybe Int
    , answer : Int
    , totalGuesses : Int
    }


type Msg
    = RandomNumberReceived Int
    | TypedText String
    | SubmitGuess






init : () -> ( Model, Cmd Msg )
init _ =
    ( { typedGuess = Nothing
      , submittedGuess = Nothing
      , answer = 0 -- Default to 0 for now. There are better ways to model this
      , totalGuesses = 0
      }
    , Random.generate RandomNumberReceived (Random.int 1 10)
    )



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RandomNumberReceived answer ->
            ( { model | answer = answer }
            , Cmd.none
            )

        TypedText inputString ->
            ( { model | typedGuess = String.toInt inputString }
            , Cmd.none
            )

        SubmitGuess ->
            ( { model
                | typedGuess = Nothing
                , submittedGuess = model.typedGuess
                , totalGuesses = model.totalGuesses + 1
              }
            , Cmd.none
            )



-- View


view : Model -> Html.Html Msg
view model =
    Html.div
        []
        [ Html.div
            []
            [ Html.input
                [ HA.type_ "text"
                , HE.onInput TypedText
                , model.typedGuess |> Maybe.map String.fromInt |> Maybe.withDefault "" |> HA.value
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
    case model.submittedGuess of
        Just guess ->
            if guess == model.answer then
                Html.div [] [ Html.text  ( "You correctly guessed " ++ String.fromInt model.answer )]

            else if guess > model.answer then
                Html.div [] [ Html.text "Too high!" ]

            else
                Html.div [] [ Html.text "Too low!" ]

        Nothing ->
            Html.text ""
