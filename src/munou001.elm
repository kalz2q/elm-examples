module Shiritori003 exposing (main)

-- make a shiritori program using buta.txt


import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE
import Random

main: Program () Model Msg
main =
  Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = always Sub.none
    }

-- MODEL
type alias Model =
  { input : String
  , validInput : String
  , memos : List String
  }

init : () -> ( Model, Cmd Msg )
init _ =
   ( Model "" "" []
   , Cmd.none)


-- UPDATE

type Msg
   = Input String
   | Submit
   | NewRandom Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Input input ->
      ( {model | input = input}, Cmd.none  )

    Submit -> 
      if isValid model.input then
        ( { model | input =""
                  , validInput = model.input
                  , memos = model.memos ++ model.input:: [] }
          , Random.generate NewRandom (Random.int 1 (List.length answers) ))
      else
        ( {model | input = ""}
        , Cmd.none)

    NewRandom n ->
      if isValid model.input then
            ( { model
                | memos =
                    model.memos
                        ++ List.take 1 (List.drop n answers)
              }
            , Cmd.none
            )
      else
        ( {model | input = ""}
        , Cmd.none)

view : Model -> Html Msg
view model =
    div
        [ HA.style "textAlign" "center"
        , HA.style "width" "400px"
        , HA.style "margin" "60px auto"
        ]
        [ h1 [] [ text "人工無能 0.01"]
        -- , text "こんにちは"
        , form [ HE.onSubmit Submit ]
            [ input
                [ HE.onInput Input
                , HA.value model.input
                , HA.autofocus True
                , HA.style "width" "70%"
                ]
                []
            , button
                [ HA.disabled (String.isEmpty (String.trim model.input))
                , HA.style "width" "27%"
                ]
                [ text "Submit" ]
            ]
            , ul [ HA.style "textAlign" "left" ] (List.map viewMemo model.memos)
        ]


viewMemo : String -> Html Msg
viewMemo memo =
    li [] [ Html.text memo ]




isValid : String -> Bool
isValid input =
    True
    -- List.all inAiueo (String.split "" input) 

inAiueo : String -> Bool
inAiueo string =
   List.member string aiueo


aiueo : List String
aiueo = 
  String.words "あ い う え お か き く け こ さ し す せ そ た ち つ て と な に ぬ ね の は ひ ふ へ ほ ま み む め も や ゆ よ ら り る れ ろ わ ー ん が ぎ ぐ げ ご ざ じ ず ぜ ぞ だ ぢ づ で ど ば び ぶ べ ぼ ぱ ぴ ぷ ぺ ぽ ぃ ぅ ぇ ぉ ゃ ゅ ょ っ ゎ"


lastChar : String -> String
lastChar input =
  case getLastChar input of
     Just "ー" -> lastChar ( String.join "" (List.reverse (List.drop 1 (List.reverse ((String.split "" input))))))
     Just "ん" -> lastChar ( String.join "" (List.reverse (List.drop 1 (List.reverse ((String.split "" input))))))
     Just char -> char
     Nothing -> "ん"


getLastChar : String -> Maybe String
getLastChar input =
  String.split "" input
  |> List.reverse
  |> List.head





answers: List String
answers =  String.words  ("""
もしもし
なんですか？
なに言っているかわかりません
もう一度別の言い方でおねがいします
ハロハロ
本題を言ってください
続けてください
聞いています
わかります
お察しします
それはそれは
ふーん
ふむふむ
それで？
いいね！
""")