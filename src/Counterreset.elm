module CounterReset exposing (Model, Msg(..), init, main, update, view)

-- counter program with addtional reset buttun

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    Int


init : Model
init =
    0


type Msg
    = Increment
    | Decrement
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0



-- VIEW


view : Model -> Html.Html Msg
view model =
    Html.div
        [ HA.style "background-color" "gainsboro"
        , HA.style "width" "600px"
        , HA.style "margin" "auto"
        , HA.style "textAlign" "center"
        , HA.style "font-size" "32px"
        , HA.style "position" "relative"
        ]
        [ Html.button [ HE.onClick Decrement ] [ Html.text "Decrement" ]
        , Html.div [] [ Html.text (String.fromInt model) ]
        , Html.button [ HE.onClick Increment ] [ Html.text "Increment" ]
        , Html.p [] []
        , Html.button [ HE.onClick Reset ] [ Html.text "Reset to zero" ]
        ]
