module Picshare009 exposing (main)

-- p.73 json decode and http api

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE
import Svg
import Svg.Attributes as SA


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }


type alias Model =
    { url : String
    , caption : String
    , liked : Bool
    , comments : List String
    , newComment : String
    }


initialModel : Model
initialModel =
    { url = "https://drive.google.com/uc?id=1NyeKCX2Hh0iioPYQs7JsJ8e_okLC4L5Y"
    , caption = "Santa Clause"
    , liked = False
    , comments = [ "Cowabunga, dude!" ]
    , newComment = ""
    }


type Msg
    = ToggleLike
    | Input String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleLike ->
            { model | liked = not model.liked }
        
        Input input ->
            { model | newComment = input}
        
        Submit ->
            { model
                | newComment = ""
                , comments = model.comments ++ [ model.newComment ]
            }


viewLoveButton : Model -> Html.Html Msg
viewLoveButton model =
    let
        whichheart =
            if model.liked then
                pinkheart

            else
                blackheart
    in
    Html.div []
        [ Html.span [ HE.onClick ToggleLike ]
            [ whichheart ]
        ]


viewComment : String -> Html.Html Msg
viewComment comment =
    Html.li []
        [ Html.strong [] [ Html.text "Comment:" ]
        , Html.text (" " ++ comment)
        ]


viewCommentList : List String -> Html.Html Msg
viewCommentList comments =
    case comments of
        [] ->
            Html.text ""

        _ ->
            Html.div []
                [ Html.ul []
                    (List.map viewComment comments)
                ]


viewComments : Model -> Html.Html Msg
viewComments model =
    Html.div []
        [ viewCommentList model.comments
        , Html.form [HE.onSubmit Submit]
            [ Html.input
                [ HA.type_ "text"
                , HA.placeholder "Add a comment..."
                , HA.value model.newComment
                , HE.onInput Input
                ]
                []
            , Html.button [ HA.disabled (String.isEmpty (String.trim model.newComment))

            ] [ Html.text "Save" ]
            ]
        ]


viewDetailedPhoto : Model -> Html.Html Msg
viewDetailedPhoto model =
    Html.div
        [ HA.class "detailed-photo"
        , HA.style "box-shadow" "0 0 10px #555"
        , HA.style "background" "yellow"
        ]
        [ Html.img
            [ HA.src model.url
            , HA.style "width" "400px"
            , HA.style "margin-top" "10px"
            ]
            []
        , Html.div
            [ HA.class "photo-info"
            , HA.style "padding-bottom" "10px"
            ]
            [ viewLoveButton model
            , Html.h2
                [ HA.class "caption"
                , HA.style "font-size" "30px"
                , HA.style "font-weight" "lighter"
                , HA.style "font-style" "italic"
                , HA.style "margin" "0 0 10px 0"
                ]
                [ Html.text model.caption ]
            , viewComments model
            ]
        ]


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.div
            [ HA.class "header"
            , HA.style "background-color" "#aaa"
            , HA.style "padding-bottom" "10px"
            , HA.style "padding-top" "10px"
            , HA.style "text-align" "center"
            ]
            [ Html.h1 [] [ Html.text "Picshare" ] ]
        , Html.div
            [ HA.class "content-flow"
            , HA.style "margin" "auto"
            , HA.style "width" "400px"
            ]
            [ viewDetailedPhoto model
            ]
        ]


blackheart =
    Svg.svg
        [ SA.width "28"
        , SA.height "28"
        , SA.viewBox "0 0 28 28"
        ]
        [ Svg.path
            [ SA.d "M14 26c-0.25 0-0.5-0.094-0.688-0.281l-9.75-9.406c-0.125-0.109-3.563-3.25-3.563-7 0-4.578 2.797-7.313 7.469-7.313 2.734 0 5.297 2.156 6.531 3.375 1.234-1.219 3.797-3.375 6.531-3.375 4.672 0 7.469 2.734 7.469 7.313 0 3.75-3.437 6.891-3.578 7.031l-9.734 9.375c-0.187 0.187-0.438 0.281-0.688 0.281z"
            , SA.fill "black"
            ]
            []
        ]


pinkheart =
    Svg.svg
        [ SA.width "28"
        , SA.height "28"
        , SA.viewBox "0 0 28 28"
        ]
        [ Svg.path
            [ SA.d "M14 26c-0.25 0-0.5-0.094-0.688-0.281l-9.75-9.406c-0.125-0.109-3.563-3.25-3.563-7 0-4.578 2.797-7.313 7.469-7.313 2.734 0 5.297 2.156 6.531 3.375 1.234-1.219 3.797-3.375 6.531-3.375 4.672 0 7.469 2.734 7.469 7.313 0 3.75-3.437 6.891-3.578 7.031l-9.734 9.375c-0.187 0.187-0.438 0.281-0.688 0.281z"
            , SA.fill "pink"
            ]
            []
        ]
