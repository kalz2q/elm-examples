module MouseOver exposing (main)

-- I am studyign https://ellie-app.com/qPWtPP4f9fa1 wghichi is written in with an older version of the elm compiler

import Browser
import Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (..)



-- MAIN


main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { enterLeave : List Msg
    , overOut : List Msg
    , stopPropagationEnterLeave : Bool
    , stopPropagationOverOut : Bool
    }


initialModel : Model
initialModel =
    { enterLeave = []
    , overOut = []
    , stopPropagationEnterLeave = False
    , stopPropagationOverOut = False
    }


type Msg
    = MouseEnter Int
    | MouseLeave Int
    | MouseOver Int
    | MouseOut Int
    | Reset
    | ToggleStopPropagationEnterLeave
    | ToggleStopPropagationOverOut


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            initialModel

        MouseEnter _ ->
            { model | enterLeave = model.enterLeave ++ [ msg ] }

        MouseLeave _ ->
            { model | enterLeave = model.enterLeave ++ [ msg ] }

        MouseOver _ ->
            { model | overOut = model.overOut ++ [ msg ] }

        MouseOut _ ->
            { model | overOut = model.overOut ++ [ msg ] }

        ToggleStopPropagationEnterLeave ->
            { model | stopPropagationEnterLeave = not model.stopPropagationEnterLeave }

        ToggleStopPropagationOverOut ->
            { model | stopPropagationOverOut = not model.stopPropagationOverOut }



view : Model -> Html Msg
view model =
    div []
        [ div
            [ style "background" "#cbf" 
            , style "padding"  "20px"  ]

                [ text "This is layer 2... Hover over me!" ]
        , button [ onClick Reset ] [ text "Reset" ]
        , button [ onClick ToggleStopPropagationEnterLeave ] [ text ("stopPropagation for Enter/Leave is " ++ Debug.toString model.stopPropagationEnterLeave ++ " ... Toggle!") ]
        , button [ onClick ToggleStopPropagationOverOut ] [ text ("stopPropagation for Over/Out is " ++ Debug.toString model.stopPropagationOverOut ++ " ... Toggle!") ]
        , div
            [ style "display" "flex" 
            , style "flex-direction" "row" 
             ]
            [ div
                [ style "display" "flex" 
                , style  "flex" "1" 
                ]
                [ text "Enter / Leave"
                , ul [] (model.enterLeave |> List.map (\msg -> li [] [ text (Debug.toString msg) ]))
                ]
            , div
                [ style "display" "flex" 
                , style "flex" "1" 
                ]
                [ text "Over / Out"
                , ul [] (model.overOut |> List.map (\msg -> li [] [ text (Debug.toString msg) ]))
                ]
            ]
        ]
