module Todo002 exposing (..)

-- add remove button

module Main exposing (Model, Msg(..), init, main, update, view)

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
    | RemoveTodo Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        NewTodo newTodo ->
            { model | text = newTodo }

        AddTodo ->
            { model | text = "", todos = model.todos ++ [ model.text ] }

        RemoveTodo index ->
            let
                beforeTodos =
                    List.take index model.todos

                afterTodos =
                    List.drop (index + 1) model.todos

                newTodos =
                    beforeTodos ++ afterTodos
            in
            { model | todos = newTodos }


view : Model -> Html Msg
view model =
    div []
        [ input [ HE.onInput NewTodo, HA.value model.text, HA.autofocus True ] []
        , button [ HE.onClick AddTodo ] [ text "Add Todo" ]
        , div []
            (List.indexedMap
                (\index todo ->
                    div []
                        [ span [ HE.onClick (RemoveTodo index) ] [ text "☒   " ]
                        , text todo
                        ]
                )
                model.todos
            )
        ]
