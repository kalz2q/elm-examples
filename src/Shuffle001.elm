module Shuffle001 exposing (Flags, Model, Msg(..), main)

import Browser exposing (element)
import Html as H
import Random


type alias Model =
    { partOne : Int
    , partTwo : Int
    , partThree : List String
    , partFour : List Int
    , partFive : String
    }


type Msg
    = GotOne Int
    | GotTwo Int
    | GotThree (List String)
    | GotFour (List Int)
    | GotFive String


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    element
        { init =
            always
                ( { partOne = 0, partTwo = 0, partThree = [], partFour = [], partFive = "" }
                , Cmd.batch
                    [ Random.generate GotOne partOne
                    , Random.generate GotTwo partTwo
                    , Random.generate GotThree <| partThree [ "aaaa", "bbbb", "cccc", "dddd" ]
                    , Random.generate GotFour partFour
                    , Random.generate GotFive <| partFive
                    ]
                )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotOne int ->
            ( { model | partOne = int }, Cmd.none )

        GotTwo int ->
            ( { model | partTwo = int }, Cmd.none )

        GotThree stringList ->
            ( { model | partThree = stringList }, Cmd.none )

        GotFour intList ->
            ( { model | partFour = intList }, Cmd.none )

        GotFive string ->
            ( { model | partFive = string }, Cmd.none )


view : Model -> H.Html Msg
view m =
    let
        concatedPartFour =
            List.map String.fromInt m.partFour |> String.join ", "
    in
    H.table []
        [ H.tr
            []
            [ H.td [] [ H.text "Part1" ]
            , H.td [] [ H.text <| String.fromInt m.partOne ]
            ]
        , H.tr
            []
            [ H.td [] [ H.text "Part2" ]
            , H.td [] [ H.text <| String.fromInt m.partTwo ]
            ]
        , H.tr
            []
            [ H.td [] [ H.text "Part3" ]
            , H.td [] [ H.text <| String.join ", " m.partThree ]
            ]
        , H.tr
            []
            [ H.td [] [ H.text "Part4" ]
            , H.td [] [ H.text concatedPartFour ]
            ]
        , H.tr
            []
            [ H.td [] [ H.text "Part5" ]
            , H.td [] [ H.text <| m.partFive ]
            ]
        ]


partOne : Random.Generator Int
partOne =
    Random.int 1 10


partTwo : Random.Generator Int
partTwo =
    let
        gen =
            Random.int 1 50

        double =
            \n -> n * 2
    in
    Random.map double gen


partThree : List a -> Random.Generator (List a)
partThree list =
    let
        randomNumbers : Random.Generator (List Int)
        randomNumbers =
            Random.list (List.length list) <| Random.int Random.minInt Random.maxInt

        zipWithList : List Int -> List ( a, Int )
        zipWithList intList =
            List.map2 Tuple.pair list intList

        listWithRandomNumbers : Random.Generator (List ( a, Int ))
        listWithRandomNumbers =
            Random.map zipWithList randomNumbers

        sortedGenerator : Random.Generator (List ( a, Int ))
        sortedGenerator =
            Random.map (List.sortBy Tuple.second) listWithRandomNumbers
    in
    Random.map (List.map Tuple.first) sortedGenerator


partFour : Random.Generator (List Int)
partFour =
    let
        listLengthGen : Random.Generator Int
        listLengthGen =
            Random.int 5 10

        evenGen : Random.Generator Int
        evenGen =
            Random.int 1 50 |> Random.map ((*) 2)

        listGen : Int -> Random.Generator (List Int)
        listGen len =
            Random.list len evenGen
    in
    listLengthGen |> Random.andThen listGen


type Zundoko
    = Zun
    | Doko


showZundoko : Zundoko -> String
showZundoko zundoko =
    case zundoko of
        Zun ->
            "ズン"

        Doko ->
            "ドコ"


zundokoLast =
    List.reverse [ Zun, Zun, Zun, Zun, Doko ]


isZundokoLast : List Zundoko -> Bool
isZundokoLast list =
    List.take 5 list == zundokoLast


partFive : Random.Generator String
partFive =
    let
        zundokoGen : Random.Generator Zundoko
        zundokoGen =
            Random.uniform Zun [ Doko ]

        loop : Random.Generator (List Zundoko) -> Random.Generator (List Zundoko)
        loop acc =
            acc
                |> Random.andThen
                    (\list ->
                        if isZundokoLast list then
                            Random.constant list

                        else
                            Random.map (\newElem -> newElem :: list) zundokoGen
                                |> loop
                    )

        finalize : List Zundoko -> String
        finalize zundokoList =
            zundokoList
                |> List.map showZundoko
                |> (\x -> "キヨシ!" :: x)
                |> List.reverse
                |> String.join "・"
    in
    loop (Random.constant []) |> Random.map finalize


myMap : (a -> b) -> Random.Generator a -> Random.Generator b
myMap f gen =
    gen |> Random.andThen (\val -> f val |> Random.constant)


myMap2 : (a -> b -> c) -> Random.Generator a -> Random.Generator b -> Random.Generator c
myMap2 f gen1 gen2 =
    gen1
        |> Random.andThen
            (\val1 ->
                gen2
                    |> Random.andThen
                        (\val2 -> f val1 val2 |> Random.constant)
            )
