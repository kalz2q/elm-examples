module Shuffle002 exposing (Flags, Model, Msg(..), main)

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- rewrite shuffle001 to pickup only part 3 which is my focus now

import Browser
import Html as H
import Random


type alias Model =
    { partFour : String
    }


type Msg
    = GotFour (List Int)


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.element
        { init =
            always
                ( { partFour = [] }
                , Cmd.batch
                    [ Random.generate GotFour partFour
                    ]
                )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotFour intList ->
            ( { model | partFour = intList }, Cmd.none )


view : Model -> H.Html Msg
view m =
    let
        concatedPartFour =
            List.map String.fromInt m.partFour |> String.join ", "
    in
    H.table []
        [ .tr
            []
            [ H.td [] [ H.text "Part4" ]
            , H.td [] [ H.text concatedPartFour ]
            ]
        ]


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
