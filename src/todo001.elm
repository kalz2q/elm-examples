module Todo001 exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { text : String
    , todos : List String
    }


init =
    Model "" []



-- UPDATE


type Msg
    = NewTodo String
    | AddTodo


update : Msg -> Model -> Model
update msg model =
    case msg of
        NewTodo newTodo ->
            { model | text = newTodo }

        AddTodo ->
            { model | text = "", todos = model.todos ++ [ model.text ] }


view : Model -> Html Msg
view model =
    div [ ]
        [ input [ HE.onInput NewTodo, HA.value model.text, HA.autofocus True ] []
        , button [ HE.onClick AddTodo] [ text "Add Todo" ]
        , div [] (List.map (\todo -> div [] [ text todo ]) model.todos)
        ]
