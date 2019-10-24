port module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode as E



-- ---------------------------
-- PORTS
-- ---------------------------
-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { greeting : String, times : Int }


init : Model -> ( Model, Cmd Msg )
init flags =
    ( flags, Cmd.none )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = NoMessage


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( model, Cmd.none )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Html Msg
view model =
  div [] 
        [section []
          [div[]
            [div[]
                [h1 []
                  [
                      text "hello world for 8 times"
                  ]
                ]
            ]
          ]
        , section []
            [div []
              [
                ul [  ]
                    (List.repeat model.times
                        (li [  ] [ text model.greeting])
                    )

              ]
            ]

        ]



-- ---------------------------
-- MAIN
-- ---------------------------


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- main : Program flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
