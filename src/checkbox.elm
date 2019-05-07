module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { notifications : Bool
    , autoplay : Bool
    , location : Bool
    }


init : Model
init =
    { notifications = False
    , autoplay = True
    , location = True
    }



-- UPDATE


type Msg
    = ToggleNotifications
    | ToggleAutoplay
    | ToggleLocation


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleNotifications ->
            { model | notifications = not model.notifications }

        ToggleAutoplay ->
            { model | autoplay = not model.autoplay }

        ToggleLocation ->
            { model | location = not model.location }



-- VIEW


view : Model -> Html Msg
view model =
    fieldset []
        [ label []
            [ input [ type_ "checkbox", onClick ToggleNotifications ] []
            , text "Email Notifications"
            ]
        , label []
            [ input [ type_ "checkbox", onClick ToggleAutoplay ] []
            , text "Video Autoplay"
            ]
        , label []
            [ input [ type_ "checkbox", onClick ToggleLocation ] []
            , text "Use Location"
            ]
        ]
checkbox : msg -> String -> Html msg
checkbox msg name =
  label []
    [ input [ type_ "checkbox", onClick msg ] []
    , text name
    ]