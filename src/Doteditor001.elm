module Doteditor exposing (main)

import Browser
import Dict exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- first, lets analyze view
-- > List.Extraのlift2というのがキーになっているのでまずこれを自作しよう
-- import List.Extra exposing (..)
-- elm-community/list-extra
-- MODEL


type alias Model =
    { campus : Campus
    , palette : Color
    , campusSize : CampusSize
    }


type alias Campus =
    Dict Point Color


type alias Point =
    ( Int, Int )


type alias Color =
    String


type alias CampusSize =
    { width : Int
    , height : Int
    }


initialModel : Model
initialModel =
    { campus = Dict.empty
    , palette = "red"
    , campusSize = { width = 5, height = 5 }
    }


type Msg
    = NewCampus
    | ChangePixelColor Point Color
    | ChangePaletteColor Color


update : Msg -> Model -> Model
update msg model =
    case msg of
        NewCampus ->
            { model | campus = newCampus model.campusSize }

        ChangePixelColor ( x, y ) color ->
            { model
                | campus =
                    Dict.update
                        ( x, y )
                        (Maybe.map (\n -> color))
                        model.campus
            }

        ChangePaletteColor color ->
            { model | palette = color }



-- [(0,0), white ...... ]


newCampus : CampusSize -> Campus
newCampus campusSize =
    Dict.fromList <|
        lift2
            Tuple.pair
            (lift2
                Tuple.pair
                (List.range 0 campusSize.width)
                (List.range 0 campusSize.height)
            )
            [ "white" ]


getCampusColor : Campus -> Point -> String
getCampusColor campus ( x, y ) =
    Dict.get ( x, y ) campus
        |> Maybe.withDefault "white"


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick NewCampus ] [ text "New" ]
        , br [] []
        , text "Select Palette Color"
        , button [ onClick (ChangePaletteColor "red") ] [ text "Red" ]
        , button [ onClick (ChangePaletteColor "green") ] [ text "Green" ]
        , button [ onClick (ChangePaletteColor "blue") ] [ text "Blue" ]
        , viewCampus model
        ]



-- div []
--     [ button [ onClick NewCampus ] [ text "New" ]
--     , br [] []
--     , text "Select Palette Color"
--     , button [ onClick (ChangePaletteColor "red") ] [ text "Red" ]
--     , button [ onClick (ChangePaletteColor "green") ] [ text "Green" ]
--     , button [ onClick (ChangePaletteColor "blue") ] [ text "Blue" ]
--     , viewCampus model
--     ]


viewCampus : Model -> Html Msg
viewCampus model =
    let
        displayCampus =
            if model.campus == Dict.empty then
                style "display" "none"

            else
                style "display" "block"

        width y =
            if y == model.campusSize.width then
                style "width" "0px"

            else
                style "width" "20px"

        height x =
            if x == model.campusSize.height then
                style "height" "0px"

            else
                style "height" "20px"
    in
    div [ displayCampus ] <|
        List.map
            (\y ->
                div [ style "float" "left" ] <|
                    List.map
                        (\x ->
                            div
                                [ style "border-top" "1px solid black"
                                , style "border-left" "1px solid black"
                                , onClick (ChangePixelColor ( x, y ) model.palette)
                                , style "background-color" (getCampusColor model.campus ( x, y ))
                                , width y
                                , height x
                                ]
                                []
                        )
                    <|
                        List.range 0 model.campusSize.width
            )
        <|
            List.range 0 model.campusSize.height


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
