module Result001 exposing (main)

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { name : String
    , age : String
    }


init : Model
init =
    Model "" ""


type Msg
    = Name String
    | Age String
    | Input String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input age ->
            { model | age = age }

        _ ->
            model


view : Model -> Html.Html Msg
view model =
    Html.div
        [ HA.style "width" "600px"
        , HA.style "margin" "auto"
        , HA.style "textAlign" "center"
        , HA.style "font-size" "24px"
        ]
        [ Html.p [] [ Html.text "Enter your age" ]
        , Html.p [] [ Html.text "Try -3, 10, 800,'kkk'" ]
        , Html.input
            [ HE.onInput Input
            ]
            []
        , Html.button
            [ HE.onClick Submit ]
            [ Html.text "Submit" ]
        , Html.p [] []
        , Html.text (toText (isReasonableAge model.age))
        ]



toText : (Result String String) -> String
toText result =
    case result of
        Err text ->
            "Err: " ++ text

        Ok text ->
            "Ok: " ++ text


isReasonableAge : String -> Result String String
isReasonableAge input =
    case String.toInt input of
        Nothing ->
            Err "That is not a number!"

        Just age ->
            if age < 0 then
                Err "Please try again after you are born."

            else if age > 135 then
                Err "Are you some kind of turtle?"

            else
                Ok (String.fromInt age)
