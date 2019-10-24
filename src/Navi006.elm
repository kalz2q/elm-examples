module Navi006 exposing (main)

-- sample from ElmのSPAとRouting
-- tem save => 007

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes as HA exposing (href)
import Html.Events as HE exposing (onClick)
import Http
import Url
import Url.Parser as Parser exposing ((</>), (<?>), int, s, string, top)


main =
    Nav.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { page : Maybe Route
    }


init : Url.Url -> ( Model, Cmd Msg )
init location =
    ( Model (Parser.parse route location)
    , Cmd.none
    )



-- URL PARSING


type Route
    = Home
    | BlogList (Maybe String)
    | BlogPost Int
    | Modules -- 2018/04/05追加


route : Parser.Parser (Route -> a) a
route =
    Parser.oneOf
        [ Parser.map Home top
        , Parser.map BlogList (Parser.s "blog" <?> stringParam "search")
        , Parser.map BlogPost (Parser.s "blog" </> int)
        , Parser.map Modules (Parser.s "modules") -- 2018/04/05追加
        ]



-- UPDATE


type Msg
    = NewUrl String
    | UrlChange Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewUrl url ->
            ( model
            , Nav.newUrl url
            )

        UrlChange location ->
            let
                -- Bebug printのためのブロック
                _ =
                    Debug.log "location=" location

                page0 =
                    Parser.parse route location

                _ =
                    Debug.log "page=" page0
            in
            ( { model | page = Parser.parse route location }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Links" ]

        -- 2018/04/05追加 "/modules/"
        , ul [] (List.map viewLink [ "/", "/modules/", "/blog/", "/blog/42", "/blog/37", "/blog/?search=cats" ])
        , ul [] (List.map viewLink2 [ "/", "/blog/", "/blog/42", "/blog/37", "/blog/?search=cats" ])
        , h1 [] [ text "各ページの画面です" ]
        , div [] [ viewRoute model.page ]
        ]


viewLink : String -> Html Msg
viewLink url =
    li [] [ button [ onClick (NewUrl url) ] [ text url ] ]


viewLink2 : String -> Html Msg
viewLink2 url =
    li [] [ a [ href ("#" ++ url) ] [ text url ] ]


viewRoute : Maybe Route -> Html msg
viewRoute maybeRoute =
    case maybeRoute of
        Nothing ->
            h2 [] [ text "404 Page Not Found!" ]

        Just route ->
            viewPage route


viewPage : Route -> Html msg
viewPage route =
    case route of
        Home ->
            div []
                [ h2 [] [ text "Welcomw to My Page!" ]
                , p [] [ text "これはテストページのトップです" ]
                ]

        BlogList Nothing ->
            div []
                [ h2 [] [ text "ブログ一覧" ]
                , p [] [ text "これはブログの一覧ページです" ]
                ]

        BlogList (Just search) ->
            div []
                [ h2 [] [ text "ブログ検索結果" ]
                , p [] [ text ("これはブログの検索結果(" ++ Http.encodeUri search ++ ")ページです") ]
                ]

        BlogPost id ->
            div []
                [ h2 [] [ text "ブログ記事表示" ]
                , p [] [ text ("これはブログの記事(" ++ toString id ++ ")を表示します") ]
                ]

        Main ->
            div []
                [ h2 [] [ text "初期画面" ]
                , p [] [ text "これはプログラムがロードされた初期画面です。" ]
                ]

        Modules ->
            -- 2018/04/05追加
            div []
                [ h2 [] [ text "Modules" ]
                , p [] [ text "これはプログラムがロードされModulesです。" ]
                ]
