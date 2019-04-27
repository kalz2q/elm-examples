module CounterAttribite exposing (main)

import Browser exposing (sandbox)
import Html exposing (Html, button, div, node, text)
import Html.Attributes exposing (attribute, class)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    Int


init : Model
init =
    0


type Msg
    = Increment



-- ElmのプログラムはModel, Update, Viewでできている。
-- Modelの型から考えるらしい。多くの場合はレコードだが、今回はIntである。
-- viewとupdateは関数で、viewはmodelを受け取り、Htmlを返す。
-- なんらかのeventでupdateが起動しmodelが返されるとviewが変化する。


view : Model -> Html Msg
view model =
    div [ class "text-center" ]
        [ stylesheet
        , div [] [ text (String.fromInt model) ]
        , button
            [ class "btn-lg btn-primary", onClick Increment ]
            [ text "++++" ]
        ]


-- onClick関数はIncrementという値を受け取りeventを発生させる
 function takes Increment value and will trigger an event
-- whenever the user clicks on the button.
-- When an event is triggered, the message value gets passed to the update
-- function, then the update function returns the new model state.
-- So whenever a user clicks the button, the onClick event will get triggered
-- which will pass the Increment value to the update function.
-- The update function will get called whenever an event is triggered. The message value
-- will be passed in as the first value and the current model state will be passed in as
-- the second value. The update function returns the new model state, which will be passed
-- into the view function.


update msg model =
    -- Here we're using a case expression, which is similar to a switch statement in
    -- JavaScript. We are checking to see what value the msg argument is. If the msg
    -- argument is Increment, then we're going to return the model value plus one. So
    -- we are effectively incrementing the model's value by one. This new model value will
    -- be passed into the view function and the view function will return the new HTML
    -- that gets rendered to the page.
    case msg of
        Increment ->
            model + 1



-- We've changed the main value so now instead of being static HTML, it's a sandbox
-- program. We use the sandbox function and pass in a record. The record has
-- to have 3 properties: init, view, and update. The init property is the initial
-- value that the model is set to. The view property is the view function which takes
-- the model and returns the displayed HTML, and the update property is a function
-- that takes a message and the model as arguments and returns the new model.
-- Initially, the model will be passed to the view function as an argument and the
-- view function will return the HTML. The sandbox will handle displaying
-- that HTML to the page so the user can see and interact with that HTML. If the user
-- triggers any events like the onClick event we have, the message and the model will
-- get passed to the update function and then the update function will return the new
-- model. Now that the model is different, the view function will get passed the new
-- model value and return the new HTML. That new HTML will get displayed on the screen.


main =
    sandbox
        { init = init
        , view = view
        , update = update
        }


stylesheet =
    let
        tag =
            "link"

        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
            ]

        children =
            []
    in
    node tag attrs children
