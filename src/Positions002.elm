module Positions002 exposing (main)

-- rewrite Positions program an example elm-lang.org

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { x : Int
    , y : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 100 100
    , Cmd.none
    )



-- UPDATE


type Msg
    = Clicked
    | NewPosition ( Int, Int )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Clicked ->
            ( model
            , Random.generate NewPosition positionGenerator
            )

        NewPosition ( x, y ) ->
            ( Model x y
            , Cmd.none
            )


positionGenerator : Random.Generator ( Int, Int )
positionGenerator =
    Random.map2 Tuple.pair
        (Random.int 50 350)
        (Random.int 50 350)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    button
        [ style "position" "absolute"
        , style "top" (String.fromInt model.x ++ "px")
        , style "left" (String.fromInt model.y ++ "px")
        , onClick Clicked
        ]
        [ text "Click me!" ]
