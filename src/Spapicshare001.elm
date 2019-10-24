module SpaPicshare001 exposing (main)

import Browser
import Browser.Navigation as Nav
import Html
import Html.Attributes as HA
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser)


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = Visit
        , onUrlChange = match >> NewRoute
        }



---- MODEL ----


type Page
    = PublicFeed
    | AccountPage
    | NotFound


type Route
    = Home
    | Account


type alias Model =
    { page : Page
    , key : Nav.Key
    }


initialModel : Nav.Key -> Model
initialModel navigationKey =
    { page = NotFound
    , key = navigationKey
    }



-- init : () -> ( Model, Cmd Msg )


init () =
    ( initialModel, Cmd.none )
init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url, Cmd.none )


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map Account (Parser.s "account")
        ]


match : Url -> Maybe Route
match url =
    Parser.parse routes url



---- VIEW ----


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.h1 [] [ Html.text "Single Page Applications" ] ]



---- UPDATE ----


type Msg
    = NewRoute (Maybe Route)
    | Visit Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
