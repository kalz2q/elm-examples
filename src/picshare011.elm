module Picshare011 exposing (main)

-- p.97 websocket and go real-time
-- 05_realtime

import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE
import Http
import Json.Decode as Json
import Json.Decode.Pipeline as JP
import Svg
import Svg.Attributes as SA


type alias Id =
    Int


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Feed =
    List Photo


type alias Photo =
    { id : Id
    , url : String
    , caption : String
    , liked : Bool
    , comments : List String
    , newComment : String
    }


type alias Model =
    { feed :
        Maybe Feed
    }


photoDecoder : Json.Decoder Photo
photoDecoder =
    Json.succeed Photo
        |> JP.required "id" Json.int
        |> JP.required "url" Json.string
        |> JP.required "caption" Json.string
        |> JP.required "liked" Json.bool
        |> JP.required "comments" (Json.list Json.string)
        |> JP.hardcoded ""


initialModel : Model
initialModel =
    { feed = Nothing }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, fetchFeed )


fetchFeed : Cmd Msg
fetchFeed =
    Http.get
        { url = "https://programming-elm.com/feed"
        , expect = Http.expectJson LoadFeed (Json.list photoDecoder)        }


type Msg
    = ToggleLike
    | Input String
    | Submit
    | LoadFeed (Result Http.Error Feed)


saveNewComment : Photo -> Photo
saveNewComment photo =
    let
        comment =
            String.trim photo.newComment
    in
    case comment of
        "" ->
            photo

        _ ->
            { photo
                | comments = photo.comments ++ [ comment ]
                , newComment = ""
            }


toggleLike : Photo -> Photo
toggleLike photo =
    { photo | liked = not photo.liked }


updateComment : String -> Photo -> Photo
updateComment comment photo =
    { photo | newComment = comment }


updateFeed : (Photo -> Photo) -> Maybe Photo -> Maybe Photo
updateFeed updatePhoto maybePhoto =
    Maybe.map updatePhoto maybePhoto


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
    {-}
        ToggleLike ->
            ( { model
                | photo = updateFeed toggleLike model.photo
              }
            , Cmd.none
            )

        Input input ->
            ( { model
                | photo = updateFeed (updateComment input) model.photo
              }
            , Cmd.none
            )

        Submit ->
            ( { model
                | photo = updateFeed saveNewComment model.photo
              }
            , Cmd.none
            )
 -}
        LoadFeed (Ok feed) ->
            ( { model | feed = Just feed }
            , Cmd.none
            )

        LoadFeed (Err _) ->
            ( model, Cmd.none )

        _ -> 
             (model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


viewLoveButton : Photo -> Html.Html Msg
viewLoveButton photo =
    let
        whichheart =
            if photo.liked then
                pinkheart

            else
                blackheart
    in
    Html.div [ HA.align "center" ]
        [ Html.span [ 
            -- HE.onClick ToggleLike 
        ]
            [ whichheart ]
        , Html.p [] [ Html.text "click the heart icon to toggle its color between pink and black" ]
        , Html.span [ 
            -- HE.onClick ToggleLike 
            ]
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


viewComments : Photo -> Html.Html Msg
viewComments photo =
    Html.div []
        [ viewCommentList photo.comments
        , Html.form [ 
            -- HE.onSubmit Submit 
            ]
            [ Html.input
                [ HA.type_ "text"
                , HA.placeholder "Add a comment..."
                , HA.value photo.newComment
                -- , HE.onInput Input
                ]
                []
            , Html.button
                [ HA.disabled (String.isEmpty (String.trim photo.newComment))
                ]
                [ Html.text "Save" ]
            ]
        ]


viewDetailedPhoto : Photo -> Html.Html Msg
viewDetailedPhoto photo =
    Html.div
        [ HA.class "detailed-photo"
        , HA.style "box-shadow" "0 0 10px #555"
        , HA.style "background" "yellow"
        ]
        [ Html.img
            [ HA.src photo.url
            , HA.style "width" "400px"
            , HA.style "margin-top" "10px"
            ]
            []
        , Html.div
            [ HA.class "photo-info"
            , HA.style "padding-bottom" "10px"
            ]
            [ viewLoveButton photo
            , Html.h2
                [ HA.class "caption"
                , HA.style "font-size" "30px"
                , HA.style "font-weight" "lighter"
                , HA.style "font-style" "italic"
                , HA.style "margin" "0 0 10px 0"
                ]
                [ Html.text photo.caption ]
            , viewComments photo
            ]
        ]


viewFeed : Maybe Feed -> Html.Html Msg
viewFeed maybeFeed =
    case maybeFeed of
        Just feed ->
            Html.div [] (List.map viewDetailedPhoto feed)
            -- viewDetailedPhoto photo

        Nothing ->
            Html.div [ HA.class "loading-feed" ]
                [ Html.text "Loading Feed..." ]


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
            [ viewFeed model.feed
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
