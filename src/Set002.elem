module Set002 exposing (main)

-- refactor Seto001.elm
-- Combine ToggleTomatoes, ToggleCucumbers, and ToggleOnions into one ToggleTopping constructor
-- ToggleTopping Topping Bool

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
                , HE.onCheck (ToggleTopping Tomatoes)
                ]
                []
            , text "Tomatoes"
            ]
        , label []
            [ input
                [ HA.type_ "checkbox"
                , HA.checked (Set.member (toppingToString Cucumbers) model.toppings)
                , HE.onCheck (ToggleTopping Cucumbers)
                ]
                []
            , text "Cucumbers"
            ]
        , label []
            [ input
                [ HA.type_ "checkbox"
                , HA.checked (Set.member (toppingToString Onions) model.toppings)
                , HE.onCheck (ToggleTopping Onions)
                ]
                []
            , text "Onions"
            ]
        ]



---- UPDATE ----


type Msg
    = ToggleTopping Topping Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleTopping topping add ->
            let
                updater =
                    if add then
                        Set.insert

                    else
                        Set.remove
            in
            { model | toppings = updater (toppingToString topping) model.toppings }



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
