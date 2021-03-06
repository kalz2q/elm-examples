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


type Msg
    = Add
    | UpdateField String
    | Toggle Int
    | SetVisibility Visibility



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateField todo ->
            { model | field = todo }

        Add ->
            let
                nextId : Int
                nextId =
                    case List.head model.todos of
                        Nothing ->
                            0

                        Just todo ->
                            todo.id + 1
            in
            { model
                | field = ""
                , todos =
                    { id = nextId
                    , title = model.field
                    , completed = False
                    }
                        :: model.todos
            }

        Toggle id ->
            let
                updateTodo todo =
                    if todo.id == id then
                        { todo | completed = not todo.completed }

                    else
                        todo
            in
            { model | todos = List.map updateTodo model.todos }

        SetVisibility visibility ->
            { model | filter = visibility }


view : Model -> Html Msg
view model =
    div []
        [ form [ HE.onSubmit Add ]
            [ div []
                [ input
                    [ HE.onInput UpdateField
                    , HA.value model.field
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
        , ul [ HA.style "list-style" "none" ]
            (model.todos
                |> List.filter (filterTodo model.filter)
                |> List.map renderTodo
            )
        , model.todos
            |> itemsLeft
            |> String.fromInt
            |> String.append "Item left : "
            |> text
        , filterView model.filter
        ]


filterTodo : Visibility -> Todo -> Bool
filterTodo visibility todo =
    case visibility of
        All ->
            True

        Active ->
            not todo.completed

        Completed ->
            todo.completed


itemsLeft : List Todo -> Int
itemsLeft todos =
    let
        nbCompleted : Int
        nbCompleted =
            List.foldl
                (\item count ->
                    if item.completed then
                        count + 1

                    else
                        count
                )
                0
                todos
    in
    List.length todos - nbCompleted


renderTodo : Todo -> Html Msg
renderTodo todo =
    let
        lineThroughStyle =
            if todo.completed then
                HA.style "text-decoration" "line-through"

            else
                HA.style "" ""
    in
    -- ( String.fromInt todo.id
    -- ,
    li
        []
        [ span []
            [ text ("<" ++ String.fromInt todo.id ++ ">   ") ]
        , input
            [ HA.type_ "checkbox"
            , HE.onClick (Toggle todo.id)
            , HA.checked todo.completed
            ]
            []
        , span [ lineThroughStyle ] [ text todo.title ]
        ]



-- )
-- renderTodo : Todo -> Html Msg
-- renderTodo todo =
--     li
--         []
--         [ input
--             [ HA.type_ "checkbox"
--             , HE.onClick (Toggle todo.id)
--             , HA.checked todo.completed
--             ]
--             []
--         , text todo.title
--         ]


filterView : Visibility -> Html Msg
filterView visibility =
    let
        underlineAttr filter =
            if visibility == filter then
                HA.style "text-decoration" "underline"

            else
                HA.style "" ""
    in
    div []
        [ a
            [ HE.onClick (SetVisibility All)
            , underlineAttr All
            ]
            [ text "  All  " ]
        , a
            [ HE.onClick (SetVisibility Completed)
            , underlineAttr Completed
            ]
            [ text "  Completed  " ]
        , a
            [ HE.onClick (SetVisibility Active)
            , underlineAttr Active
            ]
            [ text "  Active  " ]
        ]
