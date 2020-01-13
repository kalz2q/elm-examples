module Grocery002 exposing (main)

-- rewrite groceries example on https://elm-lang.org/examples/groceries

import Browser
import Html exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    {}


init : Model
init =
    {}


type Msg
    = NoMsg


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoMsg ->
            model


view : Model -> Html Msg
view model =
    div
        []
        [ h1 [] [ text "My Grocery List" ]
        , ul []
            (List.map
                (\grocery -> li [] [ text grocery ])
                groceries
            )
        ]


groceries =
    [ "Black Beans"
    , "Limes"
    , "Greek Yogurt"
    , "Cilantro"
    , "Honey"
    , "Sweet Potatoes"
    , "Cumin"
    , "Chili Powder"
    , "Quinoa"
    ]
