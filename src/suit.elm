module Suit exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Random exposing (Generator)


-- main : Program Never Model Msg
main : Program {} Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



type alias Model =
    Maybe Suit


init _ =
    ( Nothing, Cmd.none )


type Msg
    = PickRandomSuit
    | RandomResult Suit


type Suit
    = Hearts
    | Diamonds
    | Spades
    | Clubs


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PickRandomSuit ->
            ( model
            ,  Random.generate RandomResult suitGenerator 
            )

        RandomResult suit ->
            ( Just suit
            , Cmd.none
            )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

numToSuit : Int -> Suit
numToSuit num =
    case num of
        0 ->
            Hearts

        1 ->
            Diamonds

        2 ->
            Spades

        _ ->
            Clubs


suitGenerator : Generator Suit
suitGenerator =
    Random.map numToSuit (Random.int 0 3)



-- Views


view : Model -> Html Msg
view model =
    div
        []
        [ button
            [ onClick PickRandomSuit ]
            [ text "Random Suit" ]
        , suitView model
        ]


suitView : Maybe Suit -> Html Msg
suitView suit_ =
    suit_
        |> Maybe.map withSuit
        |> Maybe.withDefault noSuit


noSuit : Html Msg
noSuit =
    text "No suit! Click the button!"


withSuit : Suit -> Html Msg
withSuit suit =
    case suit of
        Hearts ->
            text "Hearts"

        Diamonds ->
            text "Diamonds"

        Spades ->
            text "Spades"

        Clubs ->
            text "Clubs"
