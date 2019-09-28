module Prime001 exposing (main)

-- Enter a number and tell if its prime or not

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
  , number : Maybe Int
  , memos : List String
  }

init : Model
init = { input = ""
       , number = Nothing
       , memos = []
       } 


type Msg
  = Input String
  | Submit

update : Msg -> Model -> Model
update msg model =
  case msg of
     Input input ->
             { model | input = input }

     Submit -> 
             { model
                | input = ""
                , number = String.toInt model.input
                , memos = model.memos ++ ("your number is " ++ model.input ++ feedbackText model.input ) :: []
              }

view : Model -> Html Msg
view model =
    Html.div
        [ HA.style "textAlign" "center"
        , HA.style "width" "400px"
        , HA.style "margin" "60px auto"
        ]
        [ Html.text "Please enter a number to see if it's a prime number"
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
        , Html.ul [ HA.style "textAlign" "left" ] (List.map viewMemo model.memos)
        ]

viewMemo : String -> Html Msg
viewMemo memo =
    li [] [ Html.text memo ]


feedbackText : String -> String
feedbackText input  =
    let
        guessnum =
            String.toInt input
    in
    case guessnum of
        Just guess ->
            if (isPrime guess) then
                " which is a prime number!!"

            else
                " and it is not a prime number!"

        Nothing ->
            ". Invalid input.  Try again."

isPrime : Int -> Bool
isPrime n =
    List.range 2 (floor <| sqrt <| toFloat n)
        |> List.all (\i -> modBy i n /= 0)
