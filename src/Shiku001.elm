module Main exposing (main)

import Browser exposing (Document, document)
import Html exposing (Html, div, input, li, text, ul)
import Html.Attributes exposing (max, min, type_, value)
import Html.Events exposing (onInput)


constMax : Int
constMax =
    100


main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Model =
    { n : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { n = 9 }, Cmd.none )


type Msg
    = NoOp
    | UpdateMax Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateMax n ->
            ( { model | n = n }, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "シクシク素数"
    , body = viewBody model
    }


viewBody : Model -> List (Html Msg)
viewBody model =
    [ div []
        [ input [ type_ "range", min "1", max <| String.fromInt constMax, value <| String.fromInt model.n, onInput inputMax ] []
        , text <| String.fromInt model.n
        ]
    , show49Primes model
    ]


inputMax : String -> Msg
inputMax v =
    case String.toInt v of
        Just n ->
            if n > 0 && n <= constMax then
                UpdateMax n

            else
                NoOp

        Nothing ->
            NoOp


show49Primes : Model -> Html Msg
show49Primes model =
    div []
        [ list49Primes model.n
            |> List.map (\n -> String.fromInt n)
            |> String.join ","
            |> text
        ]


list49Primes : Int -> List Int
list49Primes n =
    list49Primes_ n 2 []


list49Primes_ : Int -> Int -> List Int -> List Int
list49Primes_ n i xs =
    case n of
        0 ->
            List.reverse xs

        _ ->
            if isPrime i && hasFourOrNine i then
                list49Primes_ (n - 1) (i + 1) (i :: xs)

            else
                list49Primes_ n (i + 1) xs


isPrime : Int -> Bool
isPrime n =
    List.range 2 (floor <| sqrt <| toFloat n)
        |> List.all (\i -> modBy i n /= 0)


hasFourOrNine : Int -> Bool
hasFourOrNine n =
    String.fromInt n
        |> (\s -> String.contains "4" s || String.contains "9" s)
