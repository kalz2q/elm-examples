module SvgDice002 exposing (main)

-- now make SvgDice001 to dice program
-- success
-- next project is twodice.elm
-- originals are svgdice002.elm and random003.elm


import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE
import Random
import Svg
import Svg.Attributes as SA

main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Model =
    { dieFace : Int
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1, Cmd.none )

type Msg
    = Roll
    | NewFace Int

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace newFace ->
            ( Model newFace, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



view : Model -> Html.Html Msg
view model =
    Html.div [HA.style "textAlign" "center"]
        [ Html.h1 [] [ Html.text (String.fromInt model.dieFace) ]
        , Svg.svg [ SA.width "120"
                  , SA.height "120"
                  , SA.viewBox "0 0 120 120"
                  , SA.fill "white"
                  , SA.stroke "black"
                  , SA.strokeWidth "3"
                  , HA.style "padding-left" "20px"
                    ]
            (List.append
                [ Svg.rect [ SA.x "1", SA.y "1", SA.width "100", SA.height "100", SA.rx "15", SA.ry "15" ] [] ]
                (svgCirclesForDieFace model.dieFace)
            )
        , Html.p [][]
        , Html.button [ HE.onClick Roll ] [ Html.text "Roll" ]
        ]


svgCirclesForDieFace : Int -> List (Svg.Svg msg)
svgCirclesForDieFace dieFace =
    case dieFace of
        1 ->
            [ Svg.circle [ SA.cx "50", SA.cy "50", SA.r "10", SA.fill "red" , SA.stroke "red"] [] ]

        2 ->
            [ Svg.circle [ SA.cx "25", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "75", SA.r "10", SA.fill "black" ] []
            ]

        3 ->
            [ Svg.circle [ SA.cx "25", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "50", SA.cy "50", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "75", SA.r "10", SA.fill "black" ] []
            ]

        4 ->
            [ Svg.circle [ SA.cx "25", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "25", SA.cy "75", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "75", SA.r "10", SA.fill "black" ] []
            ]

        5 ->
            [ Svg.circle [ SA.cx "25", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "25", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "25", SA.cy "75", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "75", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "50", SA.cy "50", SA.r "10", SA.fill "black" ] []
            ]

        6 ->
            [ Svg.circle [ SA.cx "25", SA.cy "20", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "25", SA.cy "50", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "25", SA.cy "80", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "20", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "50", SA.r "10", SA.fill "black" ] []
            , Svg.circle [ SA.cx "75", SA.cy "80", SA.r "10", SA.fill "black" ] []
            ]

        _ ->
            [ Svg.circle [ SA.cx "50", SA.cy "50", SA.r "50", SA.fill "red", SA.stroke "none" ] [] ]
