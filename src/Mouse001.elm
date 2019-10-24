module Main exposing (main)
-- This is https://ellie-app.com/qPWtPP4f9fa1 which is written withan older verrsion 
import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as JD


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
    H.div []
        [ H.div
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
            [ H.text "This is layer 1... Hover over me!"
            , H.div
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
                [ H.text "This is layer 2... Hover over me!"
                ]
            ]
        , H.button [ HE.onClick Reset ] [ H.text "Reset" ]
        , H.button [ HE.onClick ToggleStopPropagationEnterLeave ] [ H.text ("stopPropagation for Enter/Leave is " ++ toString model.stopPropagationEnterLeave ++ " ... Toggle!") ]
        , H.button [ HE.onClick ToggleStopPropagationOverOut ] [ H.text ("stopPropagation for Over/Out is " ++ toString model.stopPropagationOverOut ++ " ... Toggle!") ]
        , H.div
            [ HA.style
                [ ( "display", "flex" )
                , ( "flex-direction", "row" )
                ]
            ]
            [ H.div
                [ HA.style
                    [ ( "display", "flex" )
                    , ( "flex", "1" )
                    ]
                ]
                [ H.text "Enter / Leave"
                , H.ul [] (model.enterLeave |> List.map (\msg -> H.li [] [ H.text (toString msg) ]))
                ]
            , H.div
                [ HA.style
                    [ ( "display", "flex" )
                    , ( "flex", "1" )
                    ]
                ]
                [ H.text "Over / Out"
                , H.ul [] (model.overOut |> List.map (\msg -> H.li [] [ H.text (toString msg) ]))
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
    H.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
