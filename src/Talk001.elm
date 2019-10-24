module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, a, text, input, button)
import Html.Attributes exposing (class, value, disabled)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as D exposing (Decoder)

main = 
    Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }

-- Update
type Msg
    = Send
    | Input String
    | Recieve (Result Http.Error Talk)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Input newInput ->
            ({model | input = newInput }, Cmd.none)
        Send ->
            ( {model | input = "", userState = Waiting}
            , Http.post
                { url = "https://api.a3rt.recruit-tech.co.jp/talk/v1/smalltalk"
                , body = Http.stringBody "application/x-www-form-urlencoded" (newRequest model.input)
                , expect = Http.expectJson Recieve talkDecoder
                }
            )

        Recieve (Ok talk) ->
            ({model | userState = Loaded talk}, Cmd.none)

        Recieve (Err e) ->
            ({model | userState = Failed e}, Cmd.none)

-- Model
type alias Model =
    { input : String
    , userState : UserState
    }

type UserState
    = Init
    | Waiting
    | Loaded Talk
    | Failed Http.Error

init : () -> (Model, Cmd Msg)
init () = 
    ( {input = "", userState = Init }, Cmd.none )

-- Data
type alias Talk =
    { status : Int
    , message : String
    , results : (List Response)
    }

type alias Response =
    { perplexity : Float
    , reply : String
    }

-- Http
apikey = "DZZnkt3h7o4Sd5q9NhFIRj3iAdZVMywA"
newRequest : String -> String
newRequest query =
    ["apikey=", apikey, "&query=", query] |> String.concat

-- Decoder
talkDecoder : Decoder (Talk)
talkDecoder = 
    D.map3 Talk 
        (D.field "status" D.int)
        (D.field "message" D.string)
        (D.field "results" (D.list responseDecoder))

responseDecoder : Decoder (Response)
responseDecoder =
    D.map2 Response
        (D.field "perplexity" D.float)
        (D.field "reply" D.string)

-- Render
renderResponse : (List Response) -> Html Msg
renderResponse results =
    let 
        toA = \result -> a [] [text result.reply]
    in
    div [] (List.map toA results)

-- View
view : Model -> Html Msg
view model =
    div [ class "container"]
        [ div [] [
            h1 [] [ text "テキストを入力してネ"]
            , input [ onInput Input, value model.input] []
            , button
            [ onClick Send
            , disabled
              ((model.userState == Waiting)
                || String.isEmpty (String.trim model.input)
              )
            ]
            [text "Submit"]
        ]
        , div [] [
            case model.userState of 
            Init ->
                text ""
            Waiting ->
                text "waiting..."
            Loaded talk ->
                renderResponse talk.results
            Failed error ->
                text (Debug.toString error)
            ]
        ]