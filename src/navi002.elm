module Navi002 exposing (main)

import Browser
import Browser.Navigation as Nav
import Html
import Html.Attributes as HA
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init -- flags -> Url -> Key -> ( model, Cmd msg )
        , view = view -- model -> Document msg
        , update = update -- msg -> model -> ( model, Cmd msg )
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged -- Url -> msg
        , onUrlRequest = LinkClicked -- UrlRequest -> msg
        }


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url, Cmd.none )


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


view : Model -> Browser.Document Msg
view model =
    { title = "URL Interceptor"
    , body =
        [ Html.div
            [ HA.style "width" "600px"
            , HA.style "margin" "60px auto"
            ]
            [ Html.text "The current URL is: "
            , Html.b [] [ Html.text (Url.toString model.url) ]
            , Html.ul []
                [ Html.li []
                    [ Html.a [ HA.href "/home" ] [ Html.text "/home" ] ]
                , viewLink "/profile"
                , viewLink "/reviews/the-century-of-the-self"
                , viewLink "/reviews/public-opinion"
                , viewLink "/reviews/shah-of-shahs"
                , viewLink "https://guide.elm-lang.org/webapps/navigation.html"
                ]
            ]
        ]
    }


viewLink : String -> Html.Html msg
viewLink path =
    Html.li [] [ Html.a [ HA.href path ] [ Html.text path ] ]
