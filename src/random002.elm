module Random002 exposing (Model, Msg(..), init, main, str, subscriptions, update, view)

-- 36進法の数字(文字列)を作って表示する

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
    { random36 : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model ""
    -- , Random.generate NewRandom36 (String.fromInt (Random.int 1 36))
    , Cmd.none
    )


type Msg
    = NewRandom36 String
    | Roll


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
          (model
          , generateNewRandom36)

        NewRandom36 newRandom36 ->
            ( Model newRandom36
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
        [ h3 [] [ text "Following is a string using randomly chosen characters from" ]
        , h3 [] [ text "0123456789abcdefghijklmnopqrstuvwxyz" ]
        , h3 [] [ text "If you don't like it, reload the page" ]
        , h3 [] [ text "and a new string will be generated       " ]
        , h1
            [ style "color" "red"
            , style "margin" "0"
            ]
            [ text model.random36 ]
        ,  button [ onClick Roll ] [ text "Roll" ]
        ]


str =
    "0123456789abcdefghijklmnopqrstuvwxyz"


generateNewRandom36 : 
generateNewRandom36