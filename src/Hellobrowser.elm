module Hellobrowser exposing (main)

import Browser
import Html



-- import Html.Events as HE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    String



-- Because there is no interaction on the browser, only init is shown


init : Model
init =
    "hello, world!"



-- Because there is no interaction on the browser, there is no msg


type Msg
    = NoMsg



-- update is not really used but sandbox template need it and it must conform to the type signature


update : Msg -> Model -> Model
update msg model =
    case msg of
        _ ->
            ""



-- in this view model is shown but it is really defined by init


view : Model -> Html.Html Msg
view model =
    Html.div [] [ Html.text model ]
