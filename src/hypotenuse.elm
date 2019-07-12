module Hypotenuse exposing (main)

-- calculate a hypotenuse of a triangle

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { sideA : Float
    , sideB : Float
    }


init : Model
init =
    Model 0 0


type Msg
    = SideA String
    | SideB String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SideA sideA ->
            { model | sideA = Maybe.withDefault 0 (String.toFloat sideA) }

        SideB sideB ->
            { model | sideB = Maybe.withDefault 0 (String.toFloat sideB) }


view : Model -> Html.Html Msg
view model =
    Html.div
        [ HA.style "background-color" "lightpink"
        , HA.style "width" "600px"
        , HA.style "height" "300px"
        , HA.style "margin" "auto"
        , HA.style "textAlign" "center"
        , HA.style "font-size" "32px"
        , HA.style "position" "relative"
        ]
        [ Html.p [] [ Html.text "Calculate hypotenuse of a triangle" ]
        , Html.p [] [ Html.text "Enter two numbers" ]
        , Html.input [ HA.type_ "text", HA.placeholder "SideA", HE.onInput SideA ] []
        , Html.input [ HA.type_ "text", HA.placeholder "SideB", HE.onInput SideB ] []
        , viewCalculate model
        ]


viewCalculate : Model -> Html.Html msg
viewCalculate model =
    Html.div [ HA.style "color" "green" ]
        [ Html.text
            ("Hypotenuse is "
                ++ String.fromFloat
                    (sqrt (model.sideA ^ 2 + model.sideB ^ 2))
            )
        ]
