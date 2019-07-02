module NumGuess004 exposing (main)

-- 001 is working, mission for 002 is
-- simplify input logic
-- numguess.elmと並べて変更する
-- modelをinput : String => Maybe Intにする
-- modelをtypedGuess , submittedGuessをひとつにする
-- guess : Maybe Intにしよう
-- とりあえず動いたが、動きが変だが、うごいているので003は固定
-- 004で動きを直す。とりあえずguesses: nは要らない
-- HelloNameのようにonInputでinputを貯めて、onSubmitで動くようにする

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
    { input : String
    , guess : Maybe Int
    , answer : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { input = ""
      , guess = Nothing
      , answer = 0
      }
    , Random.generate NewRandom (Random.int 1 100)
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
              }
            , Cmd.none
            )


view : Model -> Html.Html Msg
view model =
    Html.div []
            [ Html.form
                [ HE.onSubmit SubmitGuess

                -- ,  HA.value (Maybe.withDefault "" (Maybe.map String.fromInt  model.guess))
                ]
                [ Html.input [ HE.onInput TypedText, HA.value (Maybe.withDefault "" (Maybe.map String.fromInt model.guess)) ] ]
            , Html.button
                [ HA.disabled (String.isEmpty (String.trim inputString)) ]
                [ Html.text "Submit" ]
        , feedbackText model
        ]


feedbackText : Model -> Html.Html Msg
feedbackText model =
    case model.guess of
        Just guess ->
            if guess == model.answer then
                Html.div [] [ Html.text ("You correctly guessed " ++ String.fromInt model.answer) ]

            else if guess > model.answer then
                Html.div [] [ Html.text "Too high!" ]

            else
                Html.div [] [ Html.text "Too low!" ]

        Nothing ->
            Html.text ""
