module TwoDice exposing (main)

-- originals are svgdice002.elm and random003.elm

import Browser
import Html
import Html.Events as HE
import Html.Attributes as HA
import Random

 
 
 
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }
 
 
 
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
 
 
 
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
 
 
 
createImage : Int -> String
createImage dieFace =
    "./4-random/" ++ (String.fromInt dieFace) ++ ".png"
 
 
 
 
view : Model -> Html.Html Msg
view model =
  Html.div [HA.style "textAlign" "center"]
    [ Html.img [HA.src (createImage model.dieFaceA)] []
    , Html.h1 [] [ Html.text (String.fromInt model.dieFaceA) ]
    , Html.img [HA.src (createImage model.dieFaceB)] []
    , Html.h1 [] [ Html.text (String.fromInt model.dieFaceB) ]
    , Html.button [ HE.onClick Roll ] [ Html.text "Roll" ]
    ]