module Todo005 exposing (main)

-- VincentCordobes/elm-todo
-- Read more about this program in the official Elm guide:

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
-- type alias Model =
--     { text : String
--     , todos : List String
--     }


type alias Model =
    { field : String
    , filter : Visibility
    , todos : List Todo
    }


type alias Todo =
    { id : Int
    , title : String
    , completed : Bool
    }


type Visibility
    = All
    | Completed
    | Active


init =
    Model "" All []



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
        [ form [ HE.onSubmit AddTodo ]
            [ div []
                [ input
                    [ HE.onInput NewTodo
                    , HA.value model.text
                    , HA.autofocus True
                    , HA.placeholder """ Enter "todo" """
                    ]
                    []
                ]
            , div []
                [ button [ HA.hidden True ]
                    [ text "+" ]
                ]
            ]
        , div []
            (List.indexedMap viewTodo model.todos)
        ]


viewTodo : Int -> String -> Html Msg
viewTodo index todo =
    div []
        [ div []
            [ text todo
            , span
                [ HE.onClick (RemoveTodo index)
                ]
                [ text "----->      ✖ (when done , click to delete from list) " ]
            ]
        ]
