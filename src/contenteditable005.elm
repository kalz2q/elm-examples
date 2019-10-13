module EditableTodo005 exposing (main)

-- this is todosedoitable005
-- make editable at the line sight -> 簡単ではないのでとりあえずやめる
-- 次回このファイルから変更してオッケー
-- アイデア自体がよくない気もする


import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { input : String
    , todos : List String
    , editing : Maybe TodoEdit
    }


init : Model
init =
    { input = ""
    , todos = []
    , editing = Nothing
    }



-- UPDATE


type Msg
    = Input String
    | Submit
    | EditTodo Int
    | RemoveTodo Int


type alias TodoEdit =
    { index : Int
    , text : String
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model | input = input }

        Submit ->
            let
                newTodos =
                    model.todos ++ [ model.input ]
            in
            { model
                | input = ""
                , todos = newTodos
            }

        EditTodo index ->
            let
                beforeTodos =
                    List.take index model.todos

                afterTodos =
                    List.drop (index + 1) model.todos

                newTodos =
                    beforeTodos ++ afterTodos
                
                todoToEdit = List.head (List.drop index model.todos)
            in
            case todoToEdit of
              Nothing  ->
                { model | input = ""
                       , todos = newTodos }
              Just toEdit  ->
                { model | input = toEdit
                       , todos = newTodos }

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



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div
            [ HA.style "background-color" "#aaa"
            , HA.style "padding-bottom" "10px"
            , HA.style "padding-top" "10px"
            , HA.style "text-align" "center"
            ]
            [ h1 [] [ text "EditableTodo" ] ]
        , form
            [ HA.class "todos-flow"
            , HA.style "margin" "auto"
            , HA.style "width" "400px"
            -- , HA.contenteditable True
            , HE.onSubmit Submit
            ]
            [ input
                [ HA.type_ "todos"
                , HA.placeholder "Add a todo item"
                , HA.value model.input
                , HE.onInput Input
                ]
                []
            , button
                [ HA.disabled (String.isEmpty (String.trim model.input))
                ]
                [ text "Submit" ]]
        , div [HA.style "margin" "auto"
            , HA.style "width" "400px"]
            (List.indexedMap
                (\index todo ->
                    div [ HA.style "padding" "2px" ]
                        [ text todo
                        , span
                            [ HE.onClick (RemoveTodo index)
                            ]
                            [ button [ HA.style "float" "right" ] [ text "Remove" ] ]
                        , span
                            [ HE.onClick (EditTodo index)
                            ]
                            [ button [ HA.style "float" "right" ] [ text "Edit" ] ]
                        ]
                )
                model.todos
            )
        ]
