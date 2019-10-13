module ContentEditable003 exposing (main)

-- https://qiita.com/maron8676/items/5a4d2750400a38b600dd
-- merge this with mine
-- https://ellie-app.com/6TtB978Gk5ra1

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
    , content : String
    }


init : Model
init =
    { input = "edit this sentense"
    , content = ""
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
                | content = model.input
            }




viewInput : String -> Html Msg
viewInput input =
    div []
        [ strong [] [ text "Input: " ]
        , text input
        ]

viewContent : String -> Html Msg
viewContent content =
    div []
        [ strong [] [ text "Content: " ]
        , text content
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
            [ h1 [] [ text "ContentEditable" ] ]
        , form 
            [ HA.class "content-flow"
            , HA.style "margin" "auto"
            , HA.style "width" "400px"
            , HA.contenteditable True
            , HE.onSubmit Submit
            ]
            [ Html.input
                [ HA.type_ "content"
                , HA.placeholder "Add a comment..."
                , HA.value model.input
                , HE.onInput Input
                ]
                []
            , Html.button [ HA.disabled (String.isEmpty (String.trim model.input))

            ] [ text "Submit" ]
        , viewInput model.input
        , viewContent model.content
        ]


        ]