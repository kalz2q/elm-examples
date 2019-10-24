module Rverse001 exposing (main)

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }



type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }



view : Model -> Html.Html Msg
view model =
    Html.div
        [ HA.style "background-color" "lemonchiffon"
        , HA.style "width" "600px"
        , HA.style "height" "200px"
        , HA.style "margin" "auto"
        , HA.style "textAlign" "center"
        , HA.style "font-size" "32px"
        , HA.style "position" "relative"
        ]
        [ Html.p 
          [
              HA.style "textAlign" "center"
        ]
          [Html.text "Type a text to reverse"]
        , Html.input
            [ HA.style "background" "pink"
            , HA.placeholder "Text to reverse"
            , HA.value model.content
            , HE.onInput Change
            ]
            []
        , Html.div [] [ Html.text (String.reverse model.content) ]
        ]
