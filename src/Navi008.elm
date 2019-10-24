module Navi008 exposing (main)

-- lets make this to a template

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Url
import Url.Parser as Parser exposing ((</>), (<?>))
import Url.Parser.Query as Query


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url, Cmd.none )


type Route
    = Home
    | BlogList (Maybe String)
    | BlogPost Int
    | Main
    | Modules -- 2018/04/05追加


routeParser : Parser.Parser (Route -> a) a
routeParser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map BlogList (Parser.s "blog" <?> Query.string "search")
        , Parser.map BlogPost (Parser.s "blog" </> Parser.int)
        , Parser.map Modules (Parser.s "modules")
        ]


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "URL Interceptor"
    , body =
        [ div []
            [ h1 [] [ text "Links" ]
            , ul [] (List.map viewLink [ "/", "/blog/", "/blog/42", "/blog/37", "/blog/?search=cats", "modules" ])
            , h1 [] [ text "各lページの画面です" ]
            , div [] [ viewRoute model.url ]
            ]
        ]
    }


viewLink : String -> Html.Html msg
viewLink path =
    Html.li [] [ Html.a [ HA.href path ] [ Html.text path ] ]


viewRoute : Url.Url -> Html msg
viewRoute url =
    viewPage url


viewPage : Url.Url -> Html msg
viewPage path =
    case Parser.parse routeParser path of
        Just Home ->
            div []
                [ h2 [] [ text "Welcomw to My Page!" ]
                , p [] [ text "これはテストページのトップです" ]
                ]

        Just (BlogList Nothing) ->
            div []
                [ h2 [] [ text "ブログ一覧" ]
                , p [] [ text "これはブログの一覧ページです" ]
                ]

        Just (BlogList (Just search)) ->
            div []
                [ h2 [] [ text "ブログ検索結果" ]
                , p [] [ text ("これはブログの検索結果(" ++ search ++ ")ページです") ]
                ]

        Just (BlogPost id) ->
            div []
                [ h2 [] [ text "ブログ記事表示" ]
                , p [] [ text ("これはブログの記事(" ++ String.fromInt id ++ ")を表示します") ]
                ]

        Just Modules ->
            div []
                [ h2 [] [ text "Modules" ]
                , p [] [ text "これはプログラムがロードされModulesです。" ]
                ]

        Just Main ->
            div []
                [ h2 [] [ text "初期画面" ]
                , p [] [ text "これはプログラムがロードされた初期画面です。" ]
                ]

        Nothing ->
            div []
                [ h2 [] [ text "初期画面" ]
                , p [] [ text "これはプログラムがロードされた初期画面です。" ]
                ]