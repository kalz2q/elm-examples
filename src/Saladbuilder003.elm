module SaladBuilder003 exposing (main)

-- modularise update
-- type Msg    = SaladMsg SaladMsg

import Browser
import Html exposing (Html, button, div, h1, h2, input, label, li, p, section, table, td, text, th, tr, ul)
import Html.Attributes as HA exposing (checked, class, disabled, name, type_, value)
import Html.Events as HE exposing (onCheck, onClick, onInput)
import Http
import Json.Encode as Json exposing (Value, list, object, string)
import Regex
import Set exposing (Set)



---- MODEL ----


type alias Error =
    String


type Base
    = Lettuce
    | Spinach
    | SpringMix


baseToString : Base -> String
baseToString base =
    case base of
        Lettuce ->
            "Lettuce"

        Spinach ->
            "Spinach"

        SpringMix ->
            "Spring Mix"


type Topping
    = Tomatoes
    | Cucumbers
    | Onions


toppingToString : Topping -> String
toppingToString topping =
    case topping of
        Tomatoes ->
            "Tomatoes"

        Cucumbers ->
            "Cucumbers"

        Onions ->
            "Onions"


type Dressing
    = NoDressing
    | Italian
    | RaspberryVinaigrette
    | OilVinegar


dressingToString : Dressing -> String
dressingToString dressing =
    case dressing of
        NoDressing ->
            "No Dressing"

        Italian ->
            "Italian"

        RaspberryVinaigrette ->
            "Raspberry Vinaigrette"

        OilVinegar ->
            "Oil and Vinegar"


type alias Salad =
    { base : Base
    , toppings : Set String
    , dressing : Dressing
    }


type alias Model =
    { building : Bool
    , sending : Bool
    , success : Bool
    , error : Maybe String
    , salad : Salad
    , name : String
    , email : String
    , phone : String
    }


initialModel : Model
initialModel =
    { building = True
    , sending = False
    , success = False
    , error = Nothing
    , salad =
        { base = Lettuce
        , toppings = Set.empty
        , dressing = NoDressing
        }
    , name = ""
    , email = ""
    , phone = ""
    }


init : () -> ( Model, Cmd Msg )
init () =
    ( initialModel, Cmd.none )



---- VALIDATION ----


isRequired : String -> Bool
isRequired value =
    String.trim value /= ""


isValidEmail : String -> Bool
isValidEmail value =
    let
        options =
            { caseInsensitive = True
            , multiline = False
            }

        regexString =
            "^(([^<>()\\[\\]\\.,;:\\s@\"]+(\\.[^<>()\\[\\]\\.,;:\\s@\"]+)*)|(\".+\"))@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$"

        regex =
            Regex.fromStringWith options regexString
                |> Maybe.withDefault Regex.never
    in
    value
        |> String.trim
        |> Regex.contains regex


isValidPhone : String -> Bool
isValidPhone value =
    let
        regex =
            Regex.fromString "^\\d{10}$"
                |> Maybe.withDefault Regex.never
    in
    value
        |> String.trim
        |> Regex.contains regex


isValid : Model -> Bool
isValid model =
    [ isRequired model.name
    , isRequired model.email
    , isValidEmail model.email
    , isRequired model.phone
    , isValidPhone model.phone
    ]
        |> List.all identity



---- VIEW ----
-- START:viewSending


viewSending : Html msg
viewSending =
    div [ class "sending" ] [ text "Sending Order..." ]



-- END:viewSending
-- START:viewError


viewError : Maybe Error -> Html msg
viewError error =
    case error of
        Just errorMessage ->
            div [ class "error" ] [ text errorMessage ]

        Nothing ->
            text ""



-- END:viewError


viewBuild : Model -> Html Msg
viewBuild model =
    div []
        [ viewError model.error
        , section [ class "salad-section" ]
            [ h2 [] [ text "1. Select Base" ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "base"
                    , checked (model.salad.base == Lettuce)
                    , onClick (SaladMsg (SetBase Lettuce))
                    ]
                    []
                , text "Lettuce"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "base"
                    , checked (model.salad.base == Spinach)
                    , onClick (SaladMsg (SetBase Spinach))
                    ]
                    []
                , text "Spinach"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "base"
                    , checked (model.salad.base == SpringMix)
                    , onClick (SaladMsg (SetBase SpringMix))
                    ]
                    []
                , text "Spring Mix"
                ]
            ]
        , section [ class "salad-section" ]
            [ h2 [] [ text "2. Select Toppings" ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "checkbox"
                    , checked (Set.member (toppingToString Tomatoes) model.salad.toppings)
                    , onCheck (SaladMsg << ToggleTopping Tomatoes)
                    ]
                    []
                , text "Tomatoes"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "checkbox"
                    , checked (Set.member (toppingToString Cucumbers) model.salad.toppings)
                    , onCheck (SaladMsg << ToggleTopping Cucumbers)
                    ]
                    []
                , text "Cucumbers"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "checkbox"
                    , checked (Set.member (toppingToString Onions) model.salad.toppings)
                    , onCheck (SaladMsg << ToggleTopping Onions)
                    ]
                    []
                , text "Onions"
                ]
            ]
        , section [ class "salad-section" ]
            [ h2 [] [ text "3. Select Dressing" ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.salad.dressing == NoDressing)
                    , onClick (SaladMsg (SetDressing NoDressing))
                    ]
                    []
                , text "None"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.salad.dressing == Italian)
                    , onClick (SaladMsg (SetDressing Italian))
                    ]
                    []
                , text "Italian"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.salad.dressing == RaspberryVinaigrette)
                    , onClick (SaladMsg (SetDressing RaspberryVinaigrette))
                    ]
                    []
                , text "Raspberry Vinaigrette"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.salad.dressing == OilVinegar)
                    , onClick (SaladMsg (SetDressing OilVinegar))
                    ]
                    []
                , text "Oil and Vinegar"
                ]
            ]
        , section [ class "salad-section" ]
            [ h2 [] [ text "4. Enter Contact Info" ]
            , div [ class "text-input" ]
                [ label []
                    [ div [] [ text "Name:" ]
                    , input
                        [ type_ "text"
                        , value model.name
                        , onInput SetName
                        ]
                        []
                    ]
                ]
            , div [ class "text-input" ]
                [ label []
                    [ div [] [ text "Email:" ]
                    , input
                        [ type_ "text"
                        , value model.email
                        , onInput SetEmail
                        ]
                        []
                    ]
                ]
            , div [ class "text-input" ]
                [ label []
                    [ div [] [ text "Phone:" ]
                    , input
                        [ type_ "text"
                        , value model.phone
                        , onInput SetPhone
                        ]
                        []
                    ]
                ]
            , button
                [ class "send-button"
                , disabled (not (isValid model))
                , onClick Send
                ]
                [ text "Send Order" ]
            ]
        ]


viewConfirmation : Model -> Html msg
viewConfirmation model =
    div [ class "confirmation" ]
        [ h2 [] [ text "Woo hoo!" ]
        , p [] [ text "Thanks for your order!" ]
        , table []
            [ tr []
                [ th [] [ text "Base:" ]
                , td [] [ text (baseToString model.salad.base) ]
                ]
            , tr []
                [ th [] [ text "Toppings:" ]
                , td []
                    [ ul []
                        (model.salad.toppings
                            |> Set.toList
                            |> List.map (\topping -> li [] [ text topping ])
                        )
                    ]
                ]
            , tr []
                [ th [] [ text "Dressing:" ]
                , td [] [ text (dressingToString model.salad.dressing) ]
                ]
            , tr []
                [ th [] [ text "Name:" ]
                , td [] [ text model.name ]
                ]
            , tr []
                [ th [] [ text "Email:" ]
                , td [] [ text model.email ]
                ]
            , tr []
                [ th [] [ text "Phone:" ]
                , td [] [ text model.phone ]
                ]
            ]
        ]



-- START:viewStep1


viewStep : Model -> Html Msg
viewStep model =
    if model.sending then
        viewSending
        -- END:viewStep1

    else if model.building then
        viewBuild model
        -- START:viewStep2

    else
        viewConfirmation model



-- END:viewStep2
-- START:view


view : Model -> Html Msg
view model =
    div []
        [ h1 [ class "header" ]
            [ text "Saladise - Build a Salad" ]
        , div [ class "content" ]
            [ viewStep model ]
        ]



-- END:view

---- UPDATE ----
updateSalad : SaladMsg -> Salad -> Salad
updateSalad msg salad =
    case msg of
        SetBase base ->
            { salad | base = base }

        ToggleTopping topping add ->
            let
                updater =
                    if add then
                        Set.insert

                    else
                        Set.remove
            in
             { salad | toppings = updater (toppingToString topping) salad.toppings }

        SetDressing dressing ->
            { salad | dressing = dressing }



type SaladMsg
  = SetBase Base
  | ToggleTopping Topping Bool
  | SetDressing Dressing



type Msg
    = SaladMsg SaladMsg
    | SetName String
    | SetEmail String
    | SetPhone String
    | Send
    | SubmissionResult (Result Http.Error String)


sendUrl : String
sendUrl =
    "https://programming-elm.com/salad/send"


encodeOrder : Model -> Value
encodeOrder model =
    object
        [ ( "base", string (baseToString model.salad.base) )
        , ( "toppings", list string (Set.toList model.salad.toppings) )
        , ( "dressing", string (dressingToString model.salad.dressing) )
        , ( "name", string model.name )
        , ( "email", string model.email )
        , ( "phone", string model.phone )
        ]


send : Model -> Cmd Msg
send model =
    Http.post
        { url = sendUrl
        , body = Http.jsonBody (encodeOrder model)
        , expect = Http.expectString SubmissionResult
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaladMsg saladMsg ->
            ( { model | salad = updateSalad saladMsg model.salad }
            , Cmd.none
            )

        SetName name ->
            ( { model | name = name }
            , Cmd.none
            )

        SetEmail email ->
            ( { model | email = email }
            , Cmd.none
            )

        SetPhone phone ->
            ( { model | phone = phone }
            , Cmd.none
            )

        Send ->
            let
                newModel =
                    { model
                        | building = False
                        , sending = True
                        , error = Nothing
                    }
            in
            ( newModel
            , send newModel
            )

        SubmissionResult (Ok _) ->
            ( { model
                | sending = False
                , success = True
                , error = Nothing
              }
            , Cmd.none
            )

        SubmissionResult (Err _) ->
            ( { model
                | building = True
                , sending = False
                , error = Just "There was a problem sending your order. Please try again."
              }
            , Cmd.none
            )



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
