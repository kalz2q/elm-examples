module Board001 exposing (Model, Msg(..), init, main, update, view)

-- default is chess board 9 x 9
-- using counter to increase and decrease rows and columns

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
    { rows : Int
    , columns : Int
    }


init : Model
init =
    Model 9 9



-- UPDATE


type Msg
    = IncrementRows
    | DecrementRows
    | IncrementColumns
    | DecrementColumns


update : Msg -> Model -> Model
update msg model =
    case msg of
        IncrementRows ->
            { model | rows = model.rows + 1 }

        DecrementRows ->
            { model | rows = model.rows - 1 }

        IncrementColumns ->
            { model | columns = model.columns + 1 }

        DecrementColumns ->
            { model | columns = model.columns - 1 }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ text "columns"
            , button [ onClick DecrementColumns ] [ text "-" ]
            , text (String.fromInt model.columns)
            , button [ onClick IncrementColumns ] [ text "+" ]
            ]
        , div []
            [ text "rows"
            , button [ onClick DecrementRows ] [ text "-" ]
            , text (String.fromInt model.rows)
            , button [ onClick IncrementRows ] [ text "+" ]
            ]
        -- , td
        --     [ style "border" "solid thin"
        --     , style "width" (String.fromInt (2 * model.columns) ++ "px")
        --     ]
        --     []
        --     |> List.repeat model.columns
        --     |> tr [ style "height" (String.fromInt (2 * model.rows) ++ "px") ]
        --     |> List.repeat model.columns
        --     |> table
        --         [ style "border" "solid thin"
        --         , style "border-collapse" "collapse"
        --         ]
        ]
