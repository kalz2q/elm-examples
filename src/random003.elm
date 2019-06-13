
-- solution to 2 dice

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random
-- import String exposing (concat)
 
 
 
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }
 
 
 
-- MODEL
 
 
type alias Model =
  { dieFaceA : Int
  , dieFaceB : Int
  }
 
 
init : () -> (Model, Cmd Msg)
init _ =
  (Model 1 1, Cmd.none)
 

 
-- UPDATE
 
 
type Msg
  = Roll
  | NewFaceA Int
  | NewFaceB Int
 
 
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFaceA (Random.int 1 6))
 
    NewFaceA newFace ->
      ({model | dieFaceA = newFace}, Random.generate NewFaceB (Random.int 1 6))
 
    NewFaceB newFace ->
      ({model | dieFaceB = newFace}, Cmd.none)
 
 
 
-- SUBSCRIPTIONS
 
 
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
 
 
-- UTILITIES
 
 
createImage : Int -> String
createImage dieFace =
    "./4-random/" ++ (String.fromInt dieFace) ++ ".png"
 
 
 
-- VIEW
 
 
view : Model -> Html Msg
view model =
  div []
    [ img [src (createImage model.dieFaceA)] []
    , h1 [] [ text (String.fromInt model.dieFaceA) ]
    , img [src (createImage model.dieFaceB)] []
    , h1 [] [ text (String.fromInt model.dieFaceB) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]