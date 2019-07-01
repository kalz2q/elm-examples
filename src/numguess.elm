module NumGuess exposing (main)


-- number guessing game
-- first version is forked from textformlist.elm and helloname.elm
-- secondly, add random001.elm
-- bookmark
-- this is not going well because random001.elm i s intended to start with a random number so ... try other way roun d


import Browser
import Html
import Html.Attributes as HA
import Html.Events as HE
import Random


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }

type alias Model =
    { input : String
    , randomNumber : Int
    , memos : List String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { input = ""
    , rndomNumber = 1
    , memos = []
    }
    , randomNumber = Random.generate NewRandom (Random.int 1 100000))



type Msg
    = Input String
    | NewRandom Int
    | Submit


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Input input ->
            ({ model | input = input }
            , Cmd.none)

        NewRandom newRandom ->
          ({model | randomNumber = NewRandom}
          , Cmd.none)

-- bookmark
        Submit ->
            { model
                | input = ""
                , memos = model.memos ++ model.input :: []
            }

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.form [ HE.onSubmit Submit ]
            [ Html.input [ HE.onInput Input, HA.value model.input ] []
            , Html.button
                [ HA.disabled (String.isEmpty (String.trim model.input)) ]
                [ Html.text "Submit" ]
            ]
        , Html.ul [] (List.map viewMemo model.memos)
        ]


viewMemo : String -> Html.Html Msg
viewMemo memo =
    Html.li [] [ Html.text memo ]
