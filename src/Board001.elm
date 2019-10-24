module Board001 exposing (..)


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
    { size : Int
    , length : Int
    }


init : Model
init =
    Model 1 1



-- UPDATE


type Msg
    = Size Int
    | Length Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Size val ->
            { model | size = model.size + val }

        Length val ->
            { model | length = model.length + val }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ text "length"
            , button [ onClick (Length -1) ] [ text "-" ]
            , text (String.fromInt model.length)
            , button [ onClick (Length 1) ] [ text "+" ]
            ]
        , div []
            [ text "size"
            , button [ onClick (Size -1) ] [ text "-" ]
            , text (String.fromInt model.size)
            , button [ onClick (Size 1) ] [ text "+" ]
            ]
        , td [ style "border" "solid thin", style "width" (String.fromInt model.size ++ "px") ] []
            |> List.repeat model.length
            |> tr [ style "height" (String.fromInt model.size ++ "px") ]
            |> List.repeat model.length
            |> table [ style "border" "solid thin", style "border-collapse" "collapse" ]
        ]