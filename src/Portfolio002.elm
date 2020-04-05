module Portfolio002 exposing (main)

-- This is a elm version of profile program of dotinstall's  html/css lessons

import Browser
import Html exposing (..)
import Html.Attributes as HA


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { latin : String
    , arabic : String
    , meaning : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" "" ""
    , Cmd.none
    )


type Msg
    = Delete
    | KeepNext


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Delete ->
            ( model
            , Cmd.none
            )

        KeepNext ->
            ( model
            , Cmd.none
            )


greeting : Html msg
greeting =
    div [ HA.style "color" "red", HA.style "font-family" "Noto Serif CJK JP", HA.style "margin" "0" ]
        [ Html.header
            [ HA.style "text-align" "right"
            , HA.style "padding" "20"
            , HA.style "background-image" "url(header002.png)"
            , HA.style "height" "240px"
            , HA.style "background-size" "cover"
            , HA.style "background-position" "50% 50%"
            , HA.style "margin-bottom" "60px"
            ]
            [ Html.nav []
                [ Html.ul
                    [ HA.style "margin" "0"
                    , HA.style "list-HA.style-type" "none"
                    , HA.style "padding-left" "0"
                    ]
                    [ Html.a
                        [ HA.attribute "href" "profile.html"

                        -- , HA.style "color" "inherit"
                        ]
                        [ Html.li
                            [ HA.style "display" "inline-block"
                            , HA.style "padding" "8px 8px"
                            ]
                            [ text "HOME" ]
                        ]
                    , Html.a
                        [ HA.attribute "href" "about.html" ]
                        [ Html.li [ HA.style "display" "inline-block", HA.style "padding" "8px 8px" ] [ text "ABOUT" ] ]
                    ]
                ]

            -- , div [ HA.style "margin" "0" ] [ Html.img [ src "header.png", HA.style "width" "100%", HA.style "height" "200", alt "header picture" ] [] ]
            ]
        , Html.section [ HA.style "text-align" "center" ]
            [ Html.img
                [ HA.src "taro002.png"
                , HA.width 200
                , HA.height 200
                , HA.alt "taro's icon"
                , HA.style "border-radius" "50%"
                , HA.style "border" "pink solid 10px"
                , HA.style "box-shadow" "0px 0px 20px red"
                ]
                []
            , Html.h1
                h1style
                [ text "Hello!"
                ]
            , Html.p
                [ HA.style "margin" "60px auto"
                , HA.style "width" "400px"
                , HA.style "text-align" "left"
                , HA.style "border-bottom" "3px solid gray"
                ]
                [ Html.h2 [] [ text "this is a pen. " ]
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                , text "This is a pen.  "
                ]
            ]
        , Html.footer
            [ HA.style "border-top" "3px solid red"
            , HA.style "width" "400px"
            , HA.style "margin" "0px auto 60px"
            ]
            [ Html.ul
                [ HA.style "list-HA.style-type" "none"
                , HA.style "padding-left" "0px"
                , HA.style "float" "left"
                ]
                [ Html.a [ HA.attribute "href" "mailto:xxxx@gmail.com" ]
                    [ Html.li [ HA.style "display" "inline-block" ] [ Html.img [ HA.src "mail.png", HA.width 40, HA.alt "メール送信" ] [] ] ]
                , Html.a [ HA.attribute "href" "https://dotinstall.com", HA.attribute "target" "_blank" ]
                    [ Html.li [ HA.style "display" "inline-block" ] [ Html.img [ HA.src "blog.png", HA.width 40, HA.alt "ブログサイトへ" ] [] ] ]
                , Html.a [ HA.attribute "href" "https://dotinstall.com", HA.attribute "target" "_blank" ]
                    [ Html.li [ HA.style "display" "inline-block" ] [ Html.img [ HA.src "photos.png", HA.width 40, HA.alt "写真サイトへ" ] [] ] ]
                ]
            , Html.p
                [ HA.style "color" "gray"
                , HA.style "font-size" "20px"
                , HA.style "text-align" "right"
                ]
                [ text ("©" ++ "TaroCatty") ]
            ]
        ]


h1style =
    [ HA.style "color" "#380"
    , HA.style "height" "90px"
    , HA.style "width" "100%"
    , HA.style "margin" "0"
    ]


view : Model -> Html Msg
view model =
    div []
        [ text "Convert latin to arabic"
        , p [] [ text "SabaaH" ]
        , button [] [ text "Show Answer" ]
        , button [] [ text "Delete" ]
        , button [] [ text "Next" ]
        ]
