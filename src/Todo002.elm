module Todo002 exposing (Model, Msg(..), init, main, update, view)

-- add remove button
-- next mission is to implement localstorage like 21

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
    div
        [ HA.style "margin" "60px auto"
        , HA.style "width" "400px"
        ]
        [ h1 [] [ text "Enter itmes to do" ]
        , Html.form [ HE.onSubmit AddTodo ]
            [ input
                [ HE.onInput NewTodo
                , HA.value model.text
                , HA.autofocus True
                , HA.style "width" "70%"
                ]
                []
            , button
                [ HA.disabled (String.isEmpty (String.trim model.text))
                , HA.style "width" "27%"
                ]
                [ text "Add Todo" ]
            ]
        , div []
            (List.indexedMap
                (\index todo ->
                    div [ HA.style "padding" "2px" ]
                        [ text todo
                        , span
                            [ HE.onClick (RemoveTodo index)
                            ]
                            [ button [ HA.style "float" "right" ] [ text "Delete" ] ]
                        ]
                )
                model.todos
            )
        ]
