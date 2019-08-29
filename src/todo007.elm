port module Main exposing (main)

-- port module Todo007 exposing (main)
-- link to todolocal002.html
-- mission is use port both  way (no flags)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Jason.Decode as Json



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    readTodo Read



-- MODEL


type alias Model =
    { text : String
    , todos : List String

    -- , editing : Maybe TodoEdit
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" []
    , Cmd.none
    )


port saveTodos : List String -> Cmd msg


port readTodos : (String -> msg) -> Sub msg

-- UPDATE


type Msg
    = UpdateText String
    | AddTodo
    | RemoveTodo Int
    | Read String



-- type alias TodoEdit =
--     { index : Int
--     , text : String
--     }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText newText ->
            ( { model | text = newText }, Cmd.none )

        AddTodo ->
            let
                newTodos =
                    model.todos ++ [ model.text ]
            in
            ( { model | text = "", todos = newTodos }
            , saveTodos newTodos
            )

        RemoveTodo index ->
            let
                beforeTodos =
                    List.take index model.todos

                afterTodos =
                    List.drop (index + 1) model.todos

                newTodos =
                    beforeTodos ++ afterTodos
            in
            ( { model | todos = newTodos }, saveTodos newTodos )




view : Model -> Html Msg
view model =
    div
        [ HA.style "margin" "60px auto"
        , HA.style "width" "400px"
        ]
        [ h1 [] [ text "Enter itmes to do" ]
        , form [ HE.onSubmit AddTodo ]
            [ input
                [ HE.onInput UpdateText
                , HA.value model.text
                , HA.autofocus True
                , HA.style "width" "70%"
                , HA.placeholder "Enter a todo"
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
                            [ button [ HA.style "float" "right" ] [ text "Remove" ] ]
                        ]
                )
                model.todos
            )
        ]
