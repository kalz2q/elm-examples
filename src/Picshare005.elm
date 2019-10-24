module Picshare005 exposing (main)

--   <link href="https://programming-elm.com/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
-- p.55
-- introducing browser

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE




main : Program () Model  Msg
main =
  Browser.sandbox
    { init = initialModel
    , view = view
    , update = update
    }


type alias Model =
    { url : String, caption : String, liked : Bool }


initialModel : Model
initialModel =
    { url = "https://drive.google.com/uc?id=1NyeKCX2Hh0iioPYQs7JsJ8e_okLC4L5Y"
    , caption = "Santa Clause"
    , liked = False
    }


type Msg
    = Unlike
    | Like


update : Msg -> Model -> Model
update msg model =
    case msg of
        Like ->
            { model | liked = True }

        Unlike ->
            { model | liked = False }


viewDetailedPhoto : Model -> Html.Html Msg
viewDetailedPhoto model =
    let
        buttonClass =
            if model.liked then
                "fa-heart"

            else
                "fa-heart-o"

        msg =
            if model.liked then
                Unlike

            else
                Like
    in
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
            [ Html.div [ HA.class "like-button" ]
                [ Html.span
                    [ HA.class "fa fa-2x"
                    , HA.class buttonClass
                    , HE.onClick msg
                    ]
                    [Html.text "like-button"]
                ]
            , Html.h2
                [ HA.class "caption"
                , HA.style "font-size" "30px"
                , HA.style "font-weight" "lighter"
                , HA.style "font-style" "italic"
                , HA.style "margin" "0 0 10px 0"
                ]
                [ Html.text model.caption ]
            ]
        ]


view : { url : String, caption : String, liked : Bool } -> Html.Html Msg
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
            , if model.liked then Html.text "liked" else Html.text "unliked"
            ]
        ]
