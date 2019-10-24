module Board001 exposing (Model, Msg(..), init, main, update, view)

-- default is 24px 3 x 3 board
-- using counter to increase and decrease boxSize and boardSize
-- based on negiboudu "elm de masume wo byougasuru"


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { boxSize : Int
    , boardSize : Int
    }


init : Model
init =
    Model 24 3



-- UPDATE


type Msg
    = IncrementBoxSize
    | DecrementBoxSize
    | IncrementBoardSize
    | DecrementBoardSize


update : Msg -> Model -> Model
update msg model =
    case msg of
        IncrementBoxSize ->
            { model | boxSize = model.boxSize + 1 }

        DecrementBoxSize ->
            { model | boxSize = model.boxSize - 1 }

        IncrementBoardSize ->
            { model | boardSize = model.boardSize + 1 }

        DecrementBoardSize ->
            { model | boardSize = model.boardSize - 1 }



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style "max-width" "400px"
        , style "margin" "auto"
        ]
        [ div []
            [ div [style "font-weight" "bold"]
                [ text "boxSize:  "
                , button [ onClick DecrementBoxSize ] [ text " - " ]
                , text ("  " ++ String.fromInt model.boxSize ++ " px ")
                , button [ onClick IncrementBoxSize ] [ text " + " ]
                ]
            , div [style "font-weight" "bold"]
                [ text "boardSize:  "
                , button [ onClick DecrementBoardSize ] [ text " - " ]
                , text ( "  " 
                    ++ String.fromInt model.boardSize
                    ++ "  x  "
                    ++ String.fromInt model.boardSize
                    ++ "  " )
                , button [ onClick IncrementBoardSize ] [ text " + " ]
                ]

            , table
                [ style "border" "solid thin"
                , style "border-collapse" "collapse"
                ]
              <|
                List.repeat model.boardSize <|
                    tr [ style "height" (String.fromInt model.boxSize ++ "px") ] <|
                        List.repeat model.boardSize <|
                            td
                                [ style "border" "solid thin"
                                , style "width" (String.fromInt model.boxSize ++ "px")
                                ]
                                []
            ]
        ]
