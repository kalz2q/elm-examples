module ContentEditable002 exposing (main)

-- https://qiita.com/maron8676/items/5a4d2750400a38b600dd

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { input : String
    , comments : List String
    }


init : Model
init =
    { input = ""
    , comments = [ "Cowabunga, dude!" ]
    }


type Msg
    = Input String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model | input = input}
        
        Submit ->
            { model
                | input = ""
                , comments = model.comments ++ [ model.input ]
            }




viewComment : String -> Html Msg
viewComment comment =
    li []
        [ strong [] [ text "Comment:" ]
        , text (" " ++ comment)
        ]


viewCommentList : List String -> Html Msg
viewCommentList comments =
    case comments of
        [] ->
            text ""

        _ ->
            div []
                [ ul []
                    (List.map viewComment comments)
                ]


viewComments : Model -> Html Msg
viewComments model =
    div []
        [ viewCommentList model.comments
        , form [HE.onSubmit Submit]
            [ input
                [ HA.type_ "text"
                , HA.placeholder "Add a comment..."
                , HA.value model.input
                , HE.onInput Input
                ]
                []
            , button [ HA.disabled (String.isEmpty (String.trim model.input))

            ] [ text "Save" ]
            ]
        ]



view : Model -> Html Msg
view model =
    div []
        [ div
            [ HA.class "header"
            , HA.style "background-color" "#aaa"
            , HA.style "padding-bottom" "10px"
            , HA.style "padding-top" "10px"
            , HA.style "text-align" "center"
            ]
            [ h1 [] [ text "contentEditable" ] ]
        , div
            [ HA.class "content-flow"
            , HA.style "margin" "auto"
            , HA.style "width" "400px"
            , HA.contenteditable True
            ]
            [ text "ここは編集できる"
                -- viewDetailedPhoto model
            ]
        ]


