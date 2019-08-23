-- port module Main exposing (main)


module TodoFire002 exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as Json



---- MODEL ----


type alias Model =
    { newTodo : String
    , todoList : List String
    }


fromJsonModel : Json.Decoder Model
fromJsonModel =
    Json.map2 Model
        (Json.field "newTodo" Json.string)
        (Json.field "todoList" (Json.list Json.string))


emptyModel : Model
emptyModel =
    { newTodo = ""
    , todoList = []
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( emptyModel
    , Cmd.none
    )



---- UPDATE ----


type
    Msg
    -- = Change String
    -- | Add
    -- | Delete Int
    -- | KeyDown Int
    -- | Read String
    = Add
    | Delete Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add ->
            ( { model
                | todoList = model.newTodo :: model.todoList
                , newTodo = ""
              }
            , Cmd.none
            )

        Delete n ->
            let
                t =
                    model.todoList
            in
            ( { model
                | todoList = List.take n t ++ List.drop (n + 1) t
              }
            , Cmd.none
            )



-- Read s ->
--     ( case Json.decodeString fromJsonModel s of
--         Err e ->
--             model
--         Ok newModel ->
--             { newModel
--                 | newTodo = model.newTodo
--             }
--     , Cmd.none
--     )
---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ section []
            [ div []
                [ div []
                    [ h1 []
                        [ text "Elm Todo localStorage" ]
                    ]
                ]
            ]
        , section []
            [ div [ HE.onSubmit Add ]
                [ form []
                    [ div []
                        [ input
                            [ HA.type_ "text"
                            , HA.placeholder "input your todo"
                            , HA.autofocus True
                            , HA.value model.newTodo
                            ]
                            []
                        ]
                    , div []
                        [ a
                            [ HA.hidden True
                            ]
                            [ text "add todo" ]
                        ]
                    ]
                , ul [ HA.style "list-style" "none" ]
                    -- (showList model.todoList)
                    (model.todoList
                        |> List.map renderTodo
                    )
                ]
            ]
        ]


renderTodo : String -> Html Msg
renderTodo todo =
    li
        []
        [ input
            [ HA.type_ "checkbox"
            ]
            []
        , span [] [ text todo ]
        ]



-- showList : List String -> List (Html Msg)
-- showList =
--     let
--         todos =
--             List.indexedMap Tuple.pair
--         column ( n, s ) =
--             li [ HA.class "Json.list-item has-text-left" ]
--                 [ div []
--                     [ text s
--                     , a [ HA.class "button is-danger", HE.onClick (Delete n) ] [ text "delete" ]
--                     ]
--                 ]
--     in
--     todos >> List.map column
---- MAIN ----


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view

        -- undo comment out
        -- , update = updateWithStorage
        -- , subscriptions = subscriptions
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- undo comment out
-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     read Read
-- port read : (String -> msg) -> Sub msg
-- port setStorage : Model -> Cmd msg
-- updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
-- updateWithStorage msg model =
--     let
--         ( newModel, cmds ) =
--             update msg model
--     in
--     ( newModel
--     , Cmd.batch [ setStorage newModel, cmds ]
--     )
