-- random001.elm

import Browser
import Html
import Html.Attributes as HA
-- import Html.Events HE
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
    , Random.generate NewRandom (Random.int 1 100000)
    )


type Msg
    = NewRandom Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewRandom newRandom ->
            ( Model newRandom
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html.Html Msg
view model =
   Html.div
        [ HA.style "text-align" "center"
        , HA.style "margin" "60px auto"
        , HA.style "width" "400px"
        , HA.style "background-color" "lightpink"
        ]
        [ Html.h3 [] [ Html.text "Random number between 1 and 100000." ]
        , Html.h1
            [ HA.style "color" "red"
            , HA.style "margin" "0"
            ]
            [ Html.text (String.fromInt model.randomNumber) ]
        ]
