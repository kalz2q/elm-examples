port module Main exposing (main)

-- todofire002.elm
-- rewrite according to todo006.elm which is a localStorage version

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as Json



--MAIN


type alias Flags =
    { todos : List String }


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



---- MODEL ----


type alias Model =
    { text : String
    , todos : List String
    }



-- fromJsonModel : Json.Decoder Model
-- fromJsonModel =
--     Json.map2 Model
--         (Json.field "newTodo" Json.string)
--         (Json.field "todoList" (Json.list Json.string))
-- emptyModel : Model
-- emptyModel =
--     { newTodo = ""
--     , todoList = []
-- }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model "" flags.todos
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = UpdateText String
    | AddTodo
    | RemoveTodo Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText newText ->
            ( { model | text = newText }
            , Cmd.none
            )

        AddTodo ->
            ( { model
                | todos = model.text :: model.todos
                , text = ""
              }
            , saveTodos model.todos
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
            ( { model | todos = newTodos }, saveTodos model.todos )


port saveTodos : List String -> Cmd msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ HA.style "margin" "60px auto"
        , HA.style "width" "400px"
        ]
        [ h1 [] [ text "Enter itmes to do" ]
        , section []
            [ form [ HE.onSubmit AddTodo ]
                [ input
                    [ HA.type_ "text"
                    , HE.onInput UpdateText
                    , HA.placeholder "input your todo"
                    , HA.autofocus True
                    , HA.value model.text
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

        -- renderTodo : Int -> String -> Html Msg
        -- renderTodo index todo =
        --     li
        --         []
        --         [ a
        --             [ HE.onClick (Delete index)
        --             ]
        --             [ text "(___)    " ]
        --         , span [] [ text todo ]
        --         ]
        ]
