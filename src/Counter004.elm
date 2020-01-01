module Counter004 exposing (main)

-- The original program is elm guide sample Counter001
-- exercise : rewrite using ".." and "as" => Counter002
-- exercise : Use Browser.element => Counter003
-- exercise: Add Reset and +10 buttons => Counter004

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
    | Reset
    | PlusTen


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

        Reset ->
            ( Model 0
            , Cmd.none
            )

        PlusTen ->
            ( Model (model.currentNumber + 10)
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


viewFormat : List (Html msg) -> Html msg
viewFormat children =
    div
        [ HA.style "background-color" "bisque"
        , HA.style "color" "crimson"
        , HA.style "font-size" "200%"
        , HA.style "text-align" "center"
        ]
        children


view : Model -> Html Msg
view model =
    viewFormat
        [ h1 [ HA.style "color" "darkolivegreen" ] [ text "Counter" ]
        , div [] [ text (String.fromInt model.currentNumber) ]
        , button [ HE.onClick Decrement ] [ text "-1" ]
        , button [ HE.onClick Increment ] [ text "+1" ]
        , button [ HE.onClick Reset ] [ text "Reset" ]
        , button [ HE.onClick PlusTen ] [ text "+10" ]
        ]
