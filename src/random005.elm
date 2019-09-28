module Random005 exposing (main)

-- idea is to make a random number generater
-- using random001.elm and random004.elm

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Random



-- import Array


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


type alias Model =
    { number : Int
    , memos : List String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1 []
    , Cmd.none
    )


type Msg
    = GenerateRandom
    | NewRandom Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateRandom ->
            ( model, Random.generate NewRandom (Random.int 1 10000) )

        NewRandom newRandom ->
            ( { model
                | number = newRandom
                , memos =
                    model.memos
                        ++ (String.fromInt newRandom ++ feedbackText newRandom)
                        :: []
              }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div
        [ HA.style "textAlign" "center"
        , HA.style "width" "400px"
        , HA.style "margin" "60px auto"
        ]
        [ text "Generate a random number between 1 and 10000"
        , button [ HE.onClick GenerateRandom ] [ text "Generate" ]
        , ul [ HA.style "textAlign" "left" ] (List.map viewMemo model.memos)
        ]


viewMemo : String -> Html Msg
viewMemo memo =
    li [] [ Html.text memo ]


feedbackText : Int -> String
feedbackText number =
    if isPrime number then
        " which is a PRIME number!!"

    else
        "   which is not a prime number."


isPrime : Int -> Bool
isPrime n =
    List.range 2 (floor <| sqrt <| toFloat n)
        |> List.all (\i -> modBy i n /= 0)
