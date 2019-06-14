

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

type alias Msg  =
  String

update : Msg -> Model -> Model
update msg model =
    case msg of
        _ ->
            " "

-- view : Model -> Html.Html Msg
view =
    Html.div [] [Html.text "Hello, world!!"]
