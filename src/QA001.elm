module QA001 exposing (main)

-- cf. Gakufu005.elm
-- cf. Myawesome.elm-- <meta name="viewport" content="width=device-width, initial-scale=1">

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Random


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { question : String
    , answer : String
    , dolist : Bool
    , list : List QA
    }


type alias QA =
    { question : String
    , answer : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" "" True dict
    , Random.generate NewList (shuffle dict)
    )


type Msg
    = Submit
    | NewRandom Int
    | Shuffle
    | NewList (List QA)
    | ShowMusic Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Submit ->
            ( model
            , Random.generate NewRandom (Random.int 1 (List.length dict))
            )

        NewRandom n ->
            case List.drop n dict of
                x :: _ ->
                    ( { model
                        | jpgUrl = x.jpgUrl
                        , mp3Url = x.mp3Url
                        , title = x.title
                        , filename = x.filename
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model
                    , Cmd.none
                    )

        Shuffle ->
            ( model
            , Random.generate NewList
                (shuffle dict)
            )

        NewList newList ->
            ( { model | list = newList }
            , Cmd.none
            )

        ShowMusic index ->
            case List.drop index model.list of
                x :: _ ->
                    ( { model
                        | jpgUrl = x.jpgUrl
                        , mp3Url = x.mp3Url
                        , title = x.title
                        , filename = x.filename
                        , dolist = False
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model
                    , Cmd.none
                    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


viewDetailedPdf : Model -> Html Msg
viewDetailedPdf model =
    div
        []
        [ img
            [ HA.src model.jpgUrl
            , HA.style "width" "100%"
            ]
            []
        ]


linecolor : Int -> String
linecolor index =
    if modBy 2 index == 0 then
        "pink"

    else
        "yellow"


view : Model -> Html Msg
view model =
    case model.dolist of
        True ->
            div
                [ HA.style "margin" "auto"
                , HA.style "width" "800px"
                ]
                (List.indexedMap
                    (\index music ->
                        p
                            [ HE.onClick (ShowMusic index)
                            , HA.style "background" (linecolor index)
                            ]
                            [ text music.title
                            , button
                                [ HA.style "float" "right"
                                , HA.style "background" (linecolor index)
                                ]
                                [ text "Show Music" ]
                            ]
                    )
                    model.list
                )

        False ->
            div []
                [ div
                    []
                    [ h1 []
                        [ audio
                            [ HA.src model.mp3Url
                            , HA.controls True
                            , HA.style "float" "right"
                            ]
                            []
                        ]
                    ]
                , div
                    [ HA.style "margin" "auto"
                    , HA.style "width" "90%"
                    ]
                    [ viewDetailedPdf model
                    ]
                ]


shuffle : List a -> Random.Generator (List a)
shuffle list =
    let
        randomNumbers : Random.Generator (List Int)
        randomNumbers =
            Random.list (List.length list) <| Random.int Random.minInt Random.maxInt

        zipWithList : List Int -> List ( a, Int )
        zipWithList intList =
            List.map2 Tuple.pair list intList

        listWithRandomNumbers : Random.Generator (List ( a, Int ))
        listWithRandomNumbers =
            Random.map zipWithList randomNumbers

        sortedGenerator : Random.Generator (List ( a, Int ))
        sortedGenerator =
            Random.map (List.sortBy Tuple.second) listWithRandomNumbers
    in
    Random.map (List.map Tuple.first) sortedGenerator


dict =
    [ { question = "cssの書き方3通りを述べよ"
      , answer = "headに<style>h1 {color:red;}</style>, 外出しは<link rel=stylesheet href=styles.css>,インラインはstyle="
      }
    , { question = "マージンを初期化する"
      , answer = "margin: 0; padding: 0;"
      }
    , { question = "classとidはcssでどう受けるか"
      , answer = "classは.btn、idは#btn"
      }
    , { question = "画像を丸くする"
      , answer = "border-radius: 50%;"
      }
    , { question = "リストの黒丸の取り方"
      , answer = "ul li list-style: none"
      }
    , { question = "写真集Santa Feの女優、当時18歳"
      , answer = "宮沢りえ"
      }
    , { question = "htmlの構成"
      , answer = "head, body, header, section, footer"
      }
    , { question = "左右に余白をつくる"
      , answer = "margin: 0 32px"
      }
    , { question = "faviconの設定方法"
      , answer = "<link rel=icon href=favicon.ico>"
      }
    , { question = "viewportの設定方法"
      , answer = "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
      }
    , { question = "メディアクエリの設定方法"
      , answer = "@media (min-width: 900px) .container {display: flex;}"
      }
    , { question = "縦方向センタリング"
      , answer = "align-self: center;"
      }
    , { question = "flexの中身をきれいに並べる"
      , answer = "justify-content: space-between;"
      }
    , { question = "単位違いの計算"
      , answer = "calc(50% - 32px);"
      }
    , { question = "elmのmainのTypeと構成"
      , answer = "main : Program () Model Msg => Browser.elemt {init, update, subscriptions, view}"
      }
    ]
