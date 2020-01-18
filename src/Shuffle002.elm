module Shuffle002 exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Random


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


type alias Model =
    { list : List String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model []
    , Random.generate NewList
        (shuffle listString)
    )


type Msg
    = Shuffle
    | NewList (List String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Shuffle ->
            ( model
            , Random.generate NewList
                (shuffle listString)
            )

        NewList newList ->
            ( { model
                | list = newList
              }
            , Cmd.none
            )


listString =
    [ "This", "is", "an", "apple", "and", "this", "is", "a", "pencil" ]



-- , text <| String.join "\",\" " model.list


view : Model -> Html Msg
view model =
    div []
        [ text "Let's shuffle the following sample list."
        , p [] []
        , text (Debug.toString listString)
        , br [] []
        , button [ HE.onClick Shuffle ] [ text "Shuffle" ]
        , br [] []
        , text (Debug.toString model.list)
        ]


fromListStringToString : List String -> String
fromListStringToString list =
    "[\"" ++ String.join ", " list ++ "\"]"


shuffle : List a -> Random.Generator (List a)
shuffle list =
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
