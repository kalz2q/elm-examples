module NumGuess005 exposing (main)

-- next mission is 1.feebackをlistにする 2.introをつける 005にする
-- feedbackをlistにするには何を参考にすればよいか ++と::を使う

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

        Submit->
            ( { model
                | 
                input = ""
                , guess = String.toInt model.input
                , memos = model.memos ++ model.input :: []
                -- , memos = model.memos ++ (feedbackText2 model) :: []
              }
            , Cmd.none
            )


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.text "Please enter your guess number between 1 and 100"
        , Html.form
            [ HE.onSubmit Submit

            -- ,  HA.value (Maybe.withDefault "" (Maybe.map String.fromInt  model.guess))
            ]
            [ Html.input
                [ HE.onInput Input

                -- , HA.value (Maybe.withDefault "" (Maybe.map String.fromInt model.guess))
                , HA.value model.input
                ]
                []
            , Html.button
                [ HA.disabled (String.isEmpty (String.trim model.input))
                , HA.hidden True
                ]
                [ Html.text "Submit" ]
            ]
        , feedbackText model
        , Html.ul [] (List.map viewMemo model.memos)
        ]


viewMemo : String -> Html.Html Msg
viewMemo memo =
    Html.li [] [ Html.text memo ]


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

feedbackText2 : Model -> String
feedbackText2 model =
    case model.guess of
        Just guess ->
            if guess == model.answer then
                "You correctly guessed " ++ String.fromInt model.answer

            else if guess > model.answer then
                -- Html.div [] [ Html.text "Too high!" ]
                "Your input is " ++ (String.fromInt guess) ++ " which is too high!"

            else
                -- Html.div [] [ Html.text "Too low!" ]
                "Your input is " ++ (String.fromInt guess) ++ " which is too low!"

        Nothing ->
             "Your input is invalid!"
