module NumToComma002 exposing (main)

-- convert number to a string with commas

import Browser
import Html exposing (..)
import Html.Attributes as HA
import Html.Events as HE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { input : String
    , stringWithCommas : String
    }


init : Model
init =
    { input = ""
      , stringWithCommas = ""
      }


type Msg
    = Input String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model | input = input}
        
        Submit ->
          let
            convertedString = 
              case String.toInt model.input of
              Just int ->
                toIntString int False
              Nothing -> 
                "Error!"
          in
            { model
                | stringWithCommas = convertedString
                , input = ""
            }

viewConvertedString : String -> Html Msg
viewConvertedString string =
    div []
        [ h2 [] [ text string ]
        ]

view : Model -> Html.Html Msg
view model =
    Html.div
        [ HA.style "textAlign" "center"
        , HA.style "width" "400px"
        , HA.style "margin" "60px auto"
        ]
        [ h2 [] [text "Please enter a number"]
        , h2 [] [ text "to convert"]
        , h2 [] [ text "to a string with commas"]
        , Html.form
            [ HE.onSubmit Submit ]
            [ Html.input
                [ HE.onInput Input
                , HA.value model.input
                ]
                []
            , Html.button
                [ HA.disabled (String.isEmpty (String.trim model.input))
                , HA.hidden True
                ]
                [ Html.text "Submit" ]
            ]
        ,  viewConvertedString model.stringWithCommas
        ]

--- zeroPadding 0埋めしたい数字 桁数
zeroPadding : Int -> Int -> String
zeroPadding num digit =
    String.right 3 ("000" ++ String.fromInt num)


--- toIntString 桁区切りしたい数字 False
--- 第二引数にTrueを渡すと一番最後にも,がついてしまう
toIntString : Int -> Bool -> String
toIntString num addsLastComma =
    let
        comma : String
        comma =
            if addsLastComma then
                ","

            else
                ""
    in
    if num >= 1000 then
        toIntString (num // 1000) True ++ zeroPadding (modBy 1000 num) 3 ++ comma

    else
        String.fromInt (modBy 1000 num) ++ comma