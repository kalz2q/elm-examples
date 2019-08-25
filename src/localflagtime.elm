port module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode as E
import Time exposing (Month(..), millisToPosix, toDay, toHour, toMinute, toMonth, toSecond, toYear, utc)



-- ---------------------------
-- PORTS
-- ---------------------------
-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { greeting : String, times : Int, datetime : Int }


type alias Flags =
    { greeting : String, times : Int, datetime : Int }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { greeting = flags.greeting
      , times = flags.times
      , datetime = flags.datetime
      }
    , Cmd.none
    )



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


omissionMonth : Time.Month -> String
omissionMonth month =
    case month of
        Jan ->
            "Jan"

        Feb ->
            "Feb"

        Mar ->
            "Mar"

        Apr ->
            "Apr"

        May ->
            "May"

        Jun ->
            "Jun"

        Jul ->
            "Jul"

        Aug ->
            "Aug"

        Sep ->
            "Sep"

        Oct ->
            "Oct"

        Nov ->
            "Nov"

        Dec ->
            "Dec"


view : Model -> Html Msg
view model =
    div []
        [ section []
            [ div []
                [ div []
                    [ h1 []
                        [ text
                            ("Initialized at "
                                ++ String.fromInt (toYear utc (millisToPosix model.datetime))
                                ++ " "
                                ++ (toMonth utc (millisToPosix model.datetime)
                                        |> omissionMonth
                                   )
                                ++ " "
                                ++ String.fromInt (toDay utc (millisToPosix model.datetime))
                                ++ " "
                                ++ String.fromInt
                                    (toHour utc (millisToPosix model.datetime))
                                ++ ":"
                                ++ String.fromInt (toMinute utc (millisToPosix model.datetime))
                                ++ ":"
                                ++ String.fromInt (toSecond utc (millisToPosix model.datetime))
                                ++ " UTC"
                            )
                        ]
                    ]
                ]
            ]
        , section []
            [ div []
                [ ul []
                    (List.repeat model.times
                        (li [] [ text model.greeting ])
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
