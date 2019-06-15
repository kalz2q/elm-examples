

import Browser
import Html


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



type alias Model =
    String

init : Model 
init = ""


type Msg = NoMsg

update : Msg -> Model -> Model
update msg model =
    case msg of
        _ ->
            "hello world!"

-- view : Model -> Html.Html Msg
view =
    Html.div [] [Html.text model ]
