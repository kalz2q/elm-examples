module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

import Random
import Array

type alias Char = 
    { text: String }

type alias Flags = 
    {  }


type alias Model =
    { selected : Maybe Char, chars: List Char }


initialModel : Model
initialModel =
    { selected = Nothing
    , chars = [
        {text= "A"}
        ,{text= "B"}
        ,{text = "C"}
        ,{text= "D"}
        ,{text= "E"}
      ] 
    }


type Msg
    = FindRandom
    | RandomNumber Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FindRandom ->
            (model, Random.generate RandomNumber (Random.int 0 (List.length model.chars - 1)))
        RandomNumber rn ->
            let
                selected = Array.fromList model.chars
                    |> Array.get rn
            in
                ({ model | selected = selected }, Cmd.none)

renderText : Maybe Char -> Html Msg
renderText selected =
    case selected of 
        Just char ->
            text char.text
        Nothing ->
            text "Please click on Random Button"


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick FindRandom ] [ text "Random" ]
        , div [] [ (renderText model.selected) ]
        ]
        
init : Flags -> (Model, Cmd Msg)
init flags =
    (initialModel, Cmd.none)


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }