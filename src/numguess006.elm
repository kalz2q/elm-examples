module NumGuess006 exposing (main)

-- simple number guessing game

import Browser
import Debug
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
    , memos : List String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { input = ""
      , guess = Nothing
      , answer = 0
      , memos = []
      }
    , Random.generate NewRandom (Random.int 1 100)
    )


type Msg
    = NewRandom Int
    | Input String
    | Submit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewRandom answer ->
            ( { model | answer = answer }
            , Cmd.none
            )

        Input input ->
            ( { model | input = input }
            , Cmd.none
            )

        Submit ->
            ( { model
                | input = ""
                , guess = String.toInt model.input
                , memos = model.memos ++ ("your guess is " ++ model.input ++ feedbackText model.input model.answer) :: []
              }
            , Cmd.none
            )


view : Model -> Html.Html Msg
view model =
    Html.div
        [ HA.style "textAlign" "center"
        , HA.style "width" "400px"
        , HA.style "margin" "60px auto"
        ]
        [ Html.text "Please enter your guess number between 1 and 100"
        , Html.form
            [ HE.onSubmit Submit ]
            [ Html.input
                [ HE.onInput Input
                , HA.value model.input
                ]
                []
            , Html.button
                [ HA.disabled (String.isEmpty (String.trim model.input))
                , HA.hidden True
                ]
                [ Html.text "Submit" ]
            ]
        , Html.ul [ HA.style "textAlign" "left" ] (List.map viewMemo model.memos)
        ]


viewMemo : String -> Html.Html Msg
viewMemo memo =
    Html.li [] [ Html.text memo ]


feedbackText : String -> Int -> String
feedbackText input answer =
    let
        guessnum =
            String.toInt input
    in
    case guessnum of
        Just guess ->
            if guess == answer then
                " correct!!"

            else if guess > answer then
                " which is too high!"

            else
                " which is too low!"

        Nothing ->
            " invalid!"
