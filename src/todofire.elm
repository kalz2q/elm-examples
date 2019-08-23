port module Main exposing (..)


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
    = Change String
    | Add
    | Delete Int
    | KeyDown Int
    | Read String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        isSpace =
            String.trim >> String.isEmpty
    in
    case msg of
        Change str ->
            ( { model | newTodo = str }
            , Cmd.none
            )

        Add ->
            if isSpace model.newTodo then
                ( model, Cmd.none )

            else
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

        KeyDown key ->
            if key == 13 then
                if isSpace model.newTodo then
                    ( model, Cmd.none )

                else
                    ( { model
                        | todoList = model.newTodo :: model.todoList
                        , newTodo = ""
                      }
                    , Cmd.none
                    )

            else
                ( model, Cmd.none )

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
        [ section [ HA.class "hero is-primary" ]
            [ div [ HA.class "hero-body" ]
                [ div [ HA.class "container" ]
                    [ h1 [ HA.class "title" ]
                        [ text "Elm Todo localStorage" ]
                    ]
                ]
            ]
        , section [ HA.class "section" ]
            [ div [ HA.class "container" ]
                [ form [ HA.class "Json.field has-addons" ]
                    [ div [ HA.class "control" ]
                        [ input [ HA.class "input", HA.type_ "text", HA.placeholder "input your todo", onKeyDown KeyDown, HA.autofocus True, HE.onInput Change, HA.value model.newTodo ] []
                        ]
                    , div [ HA.class "control" ]
                        [ a [ HA.class "button is-info", HE.onClick Add ] [ text "add todo" ]
                        ]
                    ]
                , ul [ HA.class "Json.list is-hoverable" ]
                    (showList model.todoList)
                ]
            ]
        , footer [ HA.class "footer" ]
            [ div [ HA.class "content has-text-centered" ]
                [ p []
                    [ a [ HA.href "https://i-doctor.sakura.ne.jp/font/?p=38214" ] [ text "WordPressでフリーオリジナルフォント2" ]
                    ]
                ]
            ]
        ]


showList : List String -> List (Html Msg)
showList =
    let
        todos =
            List.indexedMap Tuple.pair

        column ( n, s ) =
            li [ HA.class "Json.list-item has-text-left" ]
                [ div []
                    [ text s
                    , a [ HA.class "button is-danger", HE.onClick (Delete n) ] [ text "delete" ]
                    ]
                ]
    in
    todos >> List.map column


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    HE.on "keydown" (Json.map tagger HE.keyCode)



---- MAIN ----


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = updateWithStorage
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    read Read


port read : (String -> msg) -> Sub msg


port setStorage : Model -> Cmd msg


{-| We want to `setStorage` on every update. This function adds the setStorage
command for every step of the update function.2
-}
updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg model =
    let
        ( newModel, cmds ) =
            update msg model
    in
    ( newModel
    , Cmd.batch [ setStorage newModel, cmds ]
    )
