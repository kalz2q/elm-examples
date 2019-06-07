module MouseOver exposing (main)
-- I am studyign https://ellie-app.com/qPWtPP4f9fa1 wghichi is written in with an older version of the elm compiler



import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (..)


type Msg
    = MouseEnter Int
    | MouseLeave Int
    | MouseOver Int
    | MouseOut Int
    | Reset
    | ToggleStopPropagationEnterLeave
    | ToggleStopPropagationOverOut


view : Model -> Html Msg
view model =
    div []
        [ div
            [ HE.onWithOptions
                "mouseenter"
                { stopPropagation = model.stopPropagationEnterLeave
                , preventDefault = False
                }
                (JD.succeed (MouseEnter 1))
            , HE.onWithOptions
                "mouseleave"
                { stopPropagation = model.stopPropagationEnterLeave
                , preventDefault = False
                }
                (JD.succeed (MouseLeave 1))
            , HE.onWithOptions
                "mouseover"
                { stopPropagation = model.stopPropagationOverOut
                , preventDefault = False
                }
                (JD.succeed (MouseOver 1))
            , HE.onWithOptions
                "mouseout"
                { stopPropagation = model.stopPropagationOverOut
                , preventDefault = False
                }
                (JD.succeed (MouseOut 1))
            , HA.style
                [ ( "background", "#fcb" )
                , ( "padding", "20px" )
                ]
            ]
            [ text "This is layer 1... Hover over me!"
            , div
                [ HE.onWithOptions
                    "mouseenter"
                    { stopPropagation = model.stopPropagationEnterLeave
                    , preventDefault = False
                    }
                    (JD.succeed (MouseEnter 2))
                , HE.onWithOptions
                    "mouseleave"
                    { stopPropagation = model.stopPropagationEnterLeave
                    , preventDefault = False
                    }
                    (JD.succeed (MouseLeave 2))
                , HE.onWithOptions
                    "mouseover"
                    { stopPropagation = model.stopPropagationOverOut
                    , preventDefault = False
                    }
                    (JD.succeed (MouseOver 2))
                , HE.onWithOptions
                    "mouseout"
                    { stopPropagation = model.stopPropagationOverOut
                    , preventDefault = False
                    }
                    (JD.succeed (MouseOut 2))
                , HA.style
                    [ ( "background", "#cbf" )
                    , ( "padding", "20px" )
                    ]
                ]
                [ text "This is layer 2... Hover over me!"
                ]
            ]
        , button [ HE.onClick Reset ] [ text "Reset" ]
        , button [ HE.onClick ToggleStopPropagationEnterLeave ] [ text ("stopPropagation for Enter/Leave is " ++ toString model.stopPropagationEnterLeave ++ " ... Toggle!") ]
        , button [ HE.onClick ToggleStopPropagationOverOut ] [ text ("stopPropagation for Over/Out is " ++ toString model.stopPropagationOverOut ++ " ... Toggle!") ]
        , div
            [ HA.style
                [ ( "display", "flex" )
                , ( "flex-direction", "row" )
                ]
            ]
            [ div
                [ HA.style
                    [ ( "display", "flex" )
                    , ( "flex", "1" )
                    ]
                ]
                [ text "Enter / Leave"
                , ul [] (model.enterLeave |> List.map (\msg -> li [] [ text (toString msg) ]))
                ]
            , div
                [ HA.style
                    [ ( "display", "flex" )
                    , ( "flex", "1" )
                    ]
                ]
                [ text "Over / Out"
                , ul [] (model.overOut |> List.map (\msg -> li [] [ text (toString msg) ]))
                ]
            ]
        ]


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


main : Program Never Model Msg
main =
    Browser.sandbox
        { model = initialModel
        , view = view
        , update = update
        }
