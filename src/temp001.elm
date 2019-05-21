module View exposing (..)

import Html exposing (Html, div)
-- import Login.View
-- import Types exposing (..)
-- import Messages exposing (Msg(..))
-- import Ui.Layout
import Element exposing (..)

view : Model -> Html Msg
view model =
  Ui.Layout.app
    [ text "sidebar" ]
    [ text "toolbar" ]
    [ div [] [ map LoginMsg (Login.View.view model.login) ] ]