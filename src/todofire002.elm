port module Main exposing (main)

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


type Msg
    = Add
    | UpdateField String
    | Delete Int
    | Read String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        isSpace =
            String.trim >> String.isEmpty
    in
    case msg of
        UpdateField todo ->
            ( { model | newTodo = todo }
            , Cmd.batch [ setStorage model, Cmd.none ]
            )

        Add ->
            if isSpace model.newTodo then
                ( model, Cmd.none )

            else
                ( { model
                    | todoList = model.newTodo :: model.todoList
                    , newTodo = ""
                  }
                , Cmd.batch [ setStorage model, Cmd.none ]
                )

        Delete n ->
            let
                t =
                    model.todoList
            in
            ( { model
                | todoList = List.take n t ++ List.drop (n + 1) t
              }
            , Cmd.batch [ setStorage model, Cmd.none ]
            )

        Read s ->
            ( case Json.decodeString fromJsonModel s of
                Err e ->
                    model

                Ok newModel ->
                    { newModel
                        | newTodo = model.newTodo
                    }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ section []
            [ div []
                [ div []
                    [ h1 []
                        [ text "Elm Todo Firebase/Firestore" ]
                    ]
                ]
            ]
        , section []
            [ div [ HE.onSubmit Add ]
                [ form []
                    [ div []
                        [ input
                            [ HA.type_ "text"
                            , HE.onInput UpdateField
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
                        |> List.indexedMap renderTodo
                    )
                ]
            ]
        ]


renderTodo : Int -> String -> Html Msg
renderTodo index todo =
    li
        []
        [ a
            [ HE.onClick (Delete index)
            ]
            [ text "(___)    " ]
        , span [] [ text todo ]
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view

        -- , update = updateWithStorage
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    read Read


port read : (String -> msg) -> Sub msg


port setStorage : Model -> Cmd msg
