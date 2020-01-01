module Counter003 exposing (main)

-- The original program is elm guide sample Counter001
-- exercise : rewrite using ".." and "as" => Counter002
-- exercise : Use Browser.element => Counter003

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { currentNumber : Int }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 0
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Increment ->
            ( Model (model.currentNumber + 1)
            , Cmd.none
            )

        Decrement ->
            ( Model (model.currentNumber - 1)
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


viewFormat : List (Html msg) -> Html msg
viewFormat children =
    div
        [ HA.style "background-color" "bisque"
        , HA.style "color" "darkcyan"
        , HA.style "font-size" "200%"
        , HA.style "text-align" "center"
        ]
        children


view : Model -> Html Msg
view model =
    viewFormat
        [ button [ HE.onClick Decrement ] [ text "-1" ]
        , div [] [ text (String.fromInt model.currentNumber) ]
        , button [ HE.onClick Increment ] [ text "+1" ]
        ]
