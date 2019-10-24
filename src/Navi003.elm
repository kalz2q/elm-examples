module Navi003 exposing (main)

import Browser
import Browser.Navigation as Nav
import Html
import Html.Attributes as HA
import Url
import Url.Parser as UP exposing ((</>), (<?>))
import Url.Parser.Query as Query



-- import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string)


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



-- import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string)


type Route
    = Topic String
    | Blog Int
    | User String
    | Comment String Int
    | BlogPost Int String
    | BlogQuery (Maybe String)


routeParser : UP.Parser (Route -> a) a
routeParser =
    UP.oneOf
        [ UP.map Topic (UP.s "topic" </> UP.string)
        , UP.map Blog (UP.s "blog" </> UP.int)
        , UP.map User (UP.s "user" </> UP.string)
        , UP.map Comment (UP.s "user" </> UP.string </> UP.s "comment" </> UP.int)
        , UP.map BlogPost (UP.s "blog" </> UP.int </> UP.string)
        , UP.map BlogQuery (UP.s "blog" <?> Query.string "q")
        ]



-- /topic/pottery        ==>  Just (Topic "pottery")
-- /topic/collage        ==>  Just (Topic "collage")
-- /topic/               ==>  Nothing
-- /blog/42              ==>  Just (Blog 42)
-- /blog/123             ==>  Just (Blog 123)
-- /blog/mosaic          ==>  Nothing
-- /user/tom/            ==>  Just (User "tom")
-- /user/sue/            ==>  Just (User "sue")
-- /user/bob/comment/42  ==>  Just (Comment "bob" 42)
-- /user/sam/comment/35  ==>  Just (Comment "sam" 35)
-- /user/sam/comment/    ==>  Nothing
-- /user/                ==>  Nothing


type alias Docs =
    ( String, Maybe String )


docsParser : UP.Parser (Docs -> a) a
docsParser =
    UP.map Tuple.pair (UP.string </> UP.fragment identity)



-- /Basics     ==>  Just ("Basics", Nothing)
-- /Maybe      ==>  Just ("Maybe", Nothing)
-- /List       ==>  Just ("List", Nothing)
-- /List#map   ==>  Just ("List", Just "map")
-- /List#      ==>  Just ("List", Just "")
-- /List/map   ==>  Nothing
-- /           ==>  Nothing
