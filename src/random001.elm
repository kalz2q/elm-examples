module Random001 exposing (Model, Msg(..), init, main, subscriptions, update, view)

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
    { randomNumber : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1
    , Random.generate NewFace (Random.int 1 100000)
    )


type Msg
    = NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewFace newFace ->
            ( Model newFace
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div
        [ style "text-align" "center"
        , style "margin" "60px auto"
        , style "width" "400px"
        ]
        [ h3 [] [ text "Following is a random number " ]
        , h3 [] [ text "between 1 and 100000." ]
        , h3 [] [ text "If you don't like the number," ]
        , h3 [] [ text "reload the page" ]
        , h3 [] [ text "and a new number will appear.       " ]
        , h1
            [ style "color" "red"
            , style "margin" "0"
            ]
            [ text (String.fromInt model.randomNumber) ]
        ]
