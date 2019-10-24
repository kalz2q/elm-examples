module NumGuess001 exposing (main)

-- this version of number guessing game is from learn discourse
-- fairly simple but a bit too safe about inputting
-- using |> and |< is confusing for me
-- I am now thinking the way how to deal with new elm programs
-- 1.simplify import bu using `as` HA, HE, etc.
-- 2.simplify screen
-- 3.simplify logic
--  4.don't destruct working 


import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)
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


view : Model -> Html Msg
view model =
    div
        []
        [ div
            []
            [ input
                [ type_ "text"
                , onInput TypedText
                , model.typedGuess |> Maybe.map String.fromInt |> Maybe.withDefault "" |> value
                ]
                []
            , button
                [ onClick SubmitGuess ]
                [ text "Guess!" ]
            ]
        , div [] [ text <| "Guesses: " ++ String.fromInt model.totalGuesses ]
        , feedbackText model
        ]


feedbackText : Model -> Html Msg
feedbackText model =
    case model.submittedGuess of
        Just guess ->
            if guess == model.answer then
                div [] [ text <| "You correctly guessed " ++ String.fromInt model.answer ]

            else if guess > model.answer then
                div [] [ text "Too high!" ]

            else
                div [] [ text "Too low!" ]

        Nothing ->
            text ""
