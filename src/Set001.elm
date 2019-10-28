module Set001 exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Set exposing (Set)



---- MODEL ----


type Topping
    = Tomatoes
    | Cucumbers
    | Onions


toppingToString : Topping -> String
toppingToString topping =
    case topping of
        Tomatoes ->
            "Tomatoes"

        Cucumbers ->
            "Cucumbers"

        Onions ->
            "Onions"


type alias Model =
    { toppings : Set String
    }


init : Model
init =
    { toppings = Set.empty }



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ label []
            [ input
                [ HA.type_ "checkbox"
                , HA.checked (Set.member (toppingToString Tomatoes) model.toppings)
                , HE.onCheck ToggleTomatoes
                ]
                []
            , text "Tomatoes"
            ]
        , label []
            [ input
                [ HA.type_ "checkbox"
                , HA.checked (Set.member (toppingToString Cucumbers) model.toppings)
                , HE.onCheck ToggleCucumbers
                ]
                []
            , text "Cucumbers"
            ]
        , label []
            [ input
                [ HA.type_ "checkbox"
                , HA.checked (Set.member (toppingToString Onions) model.toppings)
                , HE.onCheck ToggleOnions
                ]
                []
            , text "Onions"
            ]
        ]



---- UPDATE ----


type Msg
    = ToggleTomatoes Bool
    | ToggleCucumbers Bool
    | ToggleOnions Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleTomatoes add ->
            if add then
                { model | toppings = Set.insert (toppingToString Tomatoes) model.toppings }

            else
                { model | toppings = Set.remove (toppingToString Tomatoes) model.toppings }

        ToggleCucumbers add ->
            if add then
                { model | toppings = Set.insert (toppingToString Cucumbers) model.toppings }

            else
                { model | toppings = Set.remove (toppingToString Cucumbers) model.toppings }

        ToggleOnions add ->
            if add then
                { model | toppings = Set.insert (toppingToString Onions) model.toppings }

            else
                { model | toppings = Set.remove (toppingToString Onions) model.toppings }



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
