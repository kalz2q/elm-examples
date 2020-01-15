module Svglogoanimation exposing (main)

import Array
import Browser
import Browser.Events exposing (onAnimationFrame)
import Html as H exposing (Html, div, text)
import Html.Attributes as A exposing (style)
import Html.Events exposing (onInput)
import Random
import Svg exposing (Svg, polygon, svg)
import Svg.Attributes exposing (fill, height, points, viewBox)
import Time


type alias Range =
    ( Float, Float )


type alias Model =
    { delta : Float
    , period : Int
    , ranges : List Range
    }


type Msg
    = Tick Float
    | Ranges (List Range)
    | Period Int



-- MAIN


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init () =
    ( { delta = 0
      , period = 2000
      , ranges = []
      }
    , randomRangeList
    )


randomRangeList =
    let
        range =
            Random.pair (Random.float 0 0.5) (Random.float 0.5 1)
    in
    Random.generate Ranges (Random.list 7 range)


update action model =
    case action of
        Tick next_delta ->
            ( { model | delta = next_delta }
            , if next_delta < model.delta then
                randomRangeList

              else
                Cmd.none
            )

        Ranges ranges ->
            ( { model | ranges = ranges }, Cmd.none )

        Period period ->
            ( { model | period = period }, Cmd.none )


subscriptions { period } =
    onAnimationFrame (\time -> Tick (toFloat (remainderBy period (Time.posixToMillis time)) / toFloat period))


view model =
    let
        { delta } =
            model
    in
    div
        [ style "position" "absolute"
        , style "left" "0"
        , style "right" "0"
        , style "top" "0"
        , style "bottom" "0"
        , style "background-color" "#eee"
        , style "display" "flex"
        , style "align-items" "center"
        , style "justify-content" "center"
        ]
        [ div [] [ gray_logo 250 model ]
        , div [ style "width" "120px" ] []
        , div [] [ color_logo 250 model ]
        , div
            [ style "position" "absolute"
            , style "left" "5px"
            , style "bottom" "5px"
            ]
            [ div []
                [ div []
                    [ text "period "
                    , text (String.fromInt model.period)
                    ]
                , div []
                    [ text "Δ "
                    , text (String.fromFloat delta)
                    ]
                ]
            ]
        , div
            [ style "position" "absolute"
            , style "left" "0"
            , style "top" "0"
            , style "right" "0"
            , style "height" "30px"
            ]
            [ text "200"
            , H.input
                [ A.type_ "range"
                , A.value (String.fromInt model.period)
                , A.min "200"
                , A.max "5000"
                , onInput (\period -> Period (Maybe.withDefault 2000 (String.toInt period)))
                ]
                []
            , text "5000"
            ]
        ]


ease x =
    sin ((x - 0.25) * 2 * pi) / 2 + 0.5


bound ( k, l ) x =
    if x < k then
        k

    else if x > l then
        l

    else
        x


skew ( m, n ) x =
    (bound ( m, n ) x - m) / (n - m)


logo : (String -> List ( String, String ) -> String -> Svg msg) -> Int -> Model -> Html msg
logo shape size { delta, ranges } =
    let
        rule k v =
            ( k, v )

        opacity ( m, n ) ( k, l ) =
            rule "opacity" (String.fromFloat (bound ( k, l ) (ease (skew ( m, n ) delta))))

        rangesArray =
            Array.fromList ranges

        getRange index =
            Maybe.withDefault ( 0, 1 ) (Array.get index rangesArray)
    in
    svg
        [ height (String.fromInt size)
        , viewBox "0 0 600 600"
        ]
        [ shape "#5A6378" [ opacity (getRange 0) ( 0.0, 1.0 ) ] "0,20 280,300 0,580"
        , shape "#60B5CC" [ opacity (getRange 1) ( 0.0, 1.0 ) ] "20,600 300,320 580,600"
        , shape "#60B5CC" [ opacity (getRange 2) ( 0.0, 1.0 ) ] "320,0 600,0 600,280"
        , shape "#7FD13B" [ opacity (getRange 3) ( 0.0, 1.0 ) ] "20,0 280,0 402,122 142,122"
        , shape "#F0AD00" [ opacity (getRange 4) ( 0.0, 1.0 ) ] "170,150 430,150 300,280"
        , shape "#7FD13B" [ opacity (getRange 5) ( 0.0, 1.0 ) ] "320,300 450,170 580,300 450,430"
        , shape "#F0AD00" [ opacity (getRange 6) ( 0.0, 1.0 ) ] "470,450 600,320 600,580"
        ]


color_logo =
    logo shape_of_color


gray_logo =
    logo (\_ -> shape_of_color "#DDDDDD")


shape_of_color : String -> List ( String, String ) -> String -> Svg msg
shape_of_color color styles coordinates =
    let
        attrs =
            List.map (\( prop, value ) -> style prop value) styles ++ [ fill color, points coordinates ]
    in
    polygon attrs []
