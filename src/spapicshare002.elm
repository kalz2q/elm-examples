module SpaPicshare002 exposing (main)

import Browser
import Browser.Navigation as Nav
import Html
import Html.Attributes as HA
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, (</>),(<?>))

main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked -- Visit
        , onUrlChange = UrlChanged -- match >> NewRoute
        }



---- MODEL ----
type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


type Page
    = PublicFeed
    | AccountPage
    | NotFound


type Route
    = Home
    | Account


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


view : Model -> Browser.Document Msg
view model =
  { title = "hello"
   , body = 
   [ Html.div []
        [ Html.h1 [] [ Html.text "Single Page Applications" ] ]]
  }



---- UPDATE ----

type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
