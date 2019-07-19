module Spa003 exposing (main)

import Browser
import Browser.Navigation as Nav
import Html
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
    | Modules


routeParser : Parser.Parser (Route -> a) a
routeParser =
    Parser.oneOf
        [ Parser.map Home (Parser.s "home")
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
    { title = "SPA Example Skelton"
    , body =
        [ Html.div
            [ HA.style "width" "600px"
            , HA.style "margin" "60px auto"
            ]
            [ Html.h2 []
                [ Html.text "The current URL is: "
                , Html.b [] [ Html.text (Url.toString model.url) ]
                ]
            , Html.ul [] (List.map viewLink [ "/home", "/blog/", "/blog/42", "/blog/37", "/blog/?search=cats", "/modules", "https://guide.elm-lang.org/webapps/navigation.html" ])
            , Html.h2 [] [ Html.text "各ページの画面です" ]
            , Html.div [] [ viewRoute model.url ]
            ]
        ]
    }


viewLink : String -> Html.Html msg
viewLink path =
    Html.li [] [ Html.a [ HA.href path ] [ Html.text path ] ]


viewRoute : Url.Url -> Html.Html msg
viewRoute url =
    viewPage url


viewPage : Url.Url -> Html.Html msg
viewPage path =
    case Parser.parse routeParser path of
        Just Home ->
            Html.div []
                [ Html.h2 [] [ Html.text "Welcomw to My Page!" ]
                , Html.p [] [ Html.text "これはテストページのトップです" ]
                ]

        Just (BlogList Nothing) ->
            Html.div []
                [ Html.h2 [] [ Html.text "ブログ一覧" ]
                , Html.p [] [ Html.text "これはブログの一覧ページです" ]
                ]

        Just (BlogList (Just search)) ->
            Html.div []
                [ Html.h2 [] [ Html.text "ブログ検索結果" ]
                , Html.p [] [ Html.text ("これはブログの検索結果(" ++ search ++ ")ページです") ]
                ]

        Just (BlogPost id) ->
            Html.div []
                [ Html.h2 [] [ Html.text "ブログ記事表示" ]
                , Html.p [] [ Html.text ("これはブログの記事(" ++ String.fromInt id ++ ")を表示します") ]
                ]

        Just Modules ->
            Html.div []
                [ Html.h2 [] [ Html.text "Modules" ]
                , Html.p [] [ Html.text "これはプログラムがロードされたModulesです。" ]
                ]

        Just Main ->
            Html.div []
                [ Html.h2 [] [ Html.text "初期画面" ]
                , Html.p [] [ Html.text "これはプログラムがロードされた初期画面です。" ]
                ]

        Nothing ->
            Html.div []
                [ Html.h2 [] [ Html.text "初期画面" ]
                , Html.p [] [ Html.text "これはプログラムがロードされた初期画面です。" ]
                ]
