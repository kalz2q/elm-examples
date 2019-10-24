module Navi007 exposing (main)

-- sample from ElmのSPAとRouting
-- tem save => 007

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes as HA exposing (href)
import Html.Events as HE
import Url
import Url.Parser as Parser exposing ((</>), (<?>), int, s, string, top)
import Url.Parser.Query as Query


main : Program () Model Msg
main =
    -- Nav.program UrlChange
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL
-- type alias Model =
--     { page : Maybe Route
--     }


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }



-- init : Url.Url -> ( Model, Cmd Msg )
-- init location =
--     ( Model (Parser.parse route location)
--     , Cmd.none
--     )


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url, Cmd.none )



-- URL PARSING


type Route
    = Home
    | BlogList (Maybe String)
    | BlogPost Int
    | Main
    | Modules -- 2018/04/05追加


routeParser : Parser.Parser (Route -> a) a
routeParser =
    Parser.oneOf
        [ Parser.map Home top
        , Parser.map BlogList (Parser.s "blog" <?> Query.string "search")
        , Parser.map BlogPost (Parser.s "blog" </> int)
        , Parser.map Modules (Parser.s "modules") -- 2018/04/05追加
        ]



-- UPDATE


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
            let
                -- Bebug printのためのブロック
                _ =
                    Debug.log "url=" url

                page0 =
                    Parser.parse routeParser url

                _ =
                    Debug.log "page=" page0
            in
            ( { model | url = url }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "URL Interceptor"
    , body =
        [ div []
            [ h1 [] [ text "Links" ]
            , ul [] (List.map viewLink [ "/", "/blog/", "/blog/42", "/blog/37", "/blog/?search=cats" ])
            , h1 [] [ text "各lページの画面です" ]
           , div [] [ viewRoute model.url ]
            ]
        ]
    }



-- viewLink : String -> Html Msg
-- viewLink url =
--     li [] [ button [ HE.onClick (LinkClicked  (Browser.Internal url))] [ text url ] ]

viewLink : String -> Html.Html msg
viewLink path =
    Html.li [] [ Html.a [ HA.href path ] [ Html.text path ] ]

-- viewLink2 : String -> Html Msg
-- viewLink2 url =
--     li [] [ a [ href ("#" ++ url) ] [ text url ] ]



-- viewRoute : Maybe Route -> Html msg
-- viewRoute maybeRoute =
--     case maybeRoute of
--         Nothing ->
--             h2 [] [ text "404 Page Not Found!" ]
--         Just route ->
--             viewPage route

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

        Just ( BlogList (Just search)) ->
            div []
                [ h2 [] [ text "ブログ検索結果" ]
                , p [] [ text ("これはブログの検索結果(" ++ search ++ ")ページです") ]
                ]

        Just (BlogPost id) ->
            div []
                [ h2 [] [ text "ブログ記事表示" ]
                , p [] [ text ("これはブログの記事(" ++ String.fromInt id ++ ")を表示します") ]
                ]

        Just Main ->
            div []
                [ h2 [] [ text "初期画面" ]
                , p [] [ text "これはプログラムがロードされた初期画面です。" ]
                ]

        Just Modules ->
            -- 2018/04/05追加
            div []
                [ h2 [] [ text "Modules" ]
                , p [] [ text "これはプログラムがロードされModulesです。" ]
                ]
        
        Nothing ->
                        div []
                [ h2 [] [ text "Modules" ]
                , p [] [ text "???l;kjl;kjl;kj?? lklkj" ]
                ]
