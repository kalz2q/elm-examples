module Radio001 exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE



-- MODEL


type alias Model =
    { fontSize : FontSize
    , content : String
    }


type FontSize
    = Small
    | Medium
    | Large


init : Model
init =
    Model Small "This is a sample content."


type Msg
    = SwitchTo FontSize



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ fieldset []
            [ radio (SwitchTo Small) "Small"
            , radio (SwitchTo Medium) "Medium"
            , radio (SwitchTo Large) "Large"
            ]
        , section [] [ text model.content ]
        ]


radio : msg -> String -> Html msg
radio msg name =
    label []
        [ input [ HA.type_ "radio", HE.onClick msg ] []
        , text name
        ]



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        SwitchTo newFontSize ->
            { model | fontSize = newFontSize }



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
