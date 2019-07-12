module Form001 exposing (main)

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }


view : Model -> Html.Html Msg
view model =
    Html.div
        [ HA.style "background-color" "lightpink"
        , HA.style "width" "600px"
        , HA.style "height" "200px"
        , HA.style "margin" "auto"
        , HA.style "textAlign" "center"
        , HA.style "font-size" "32px"
        , HA.style "position" "relative"
        ]
        [ Html.text "Enter your name and password"
        , viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html.Html msg
viewInput t p v toMsg =
    Html.input [ HA.type_ t, HA.placeholder p, HA.value v, HE.onInput toMsg ] []


viewValidation : Model -> Html.Html msg
viewValidation model =
    if model.password == model.passwordAgain then
        Html.div [ HA.style "color" "green" ] [ Html.text "OK" ]

    else
        Html.div [ HA.style "color" "red" ] [ Html.text "Passwords do not match!" ]
