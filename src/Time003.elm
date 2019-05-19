module Time003 exposing (..)

-- import Browser
-- import Element exposing (..)
-- import Element.Background as Background
-- import Element.Border as Border
-- import Element.Events exposing (..)
-- import Element.Font as Font
-- import Element.Input as Input
-- import Html exposing (Html)
import Task
import Time


-- main =
--     Browser.element
--         { init = init
--         , view = view
--         , update = update
--         , subscriptions = subscriptions
--         }


type alias Model =
    { zone : Time.Zone
    , time : Time.Posix
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Time.utc (Time.millisToPosix 0)
    , Task.perform AdjustTimeZone Time.here
    )


type Msg
    = Tick Time.Posix
    | AdjustTimeZone Time.Zone


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = newTime }
            , Cmd.none
            )

        AdjustTimeZone newZone ->
            ( { model | zone = newZone }
            , Cmd.none
            )




subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick


-- view : Model -> Html Msg
-- view model =
--     let
--         hour =
--             String.fromInt (Time.toHour model.zone model.time)

--         minute =
--             String.fromInt (Time.toMinute model.zone model.time)

--         second =
--             String.fromInt (Time.toSecond model.zone model.time)
--     in
--     -- Html.h1 [] [ Html.text (hour ++ ":" ++ minute ++ ":" ++ second) ]
--     layout [Font.family [Font.typeface "Noto Serif CJK JP"]] <|
--         column [width (px 400), height (px 400), Background.color (rgb255 200 180 170), centerX]
--             [ el [centerX , centerY, Font.size 36] <| text "現在の時間"
--             , el [centerX, centerY, Font.size 48, Font.bold] <| text (hour ++ ":" ++ minute ++ ":" ++ second)
--             ]
