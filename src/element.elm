module Main exposing (myElement)

import Element exposing (Element, rgb)
import Element.Background as Background
import Element.Border as Border


myElement : Element msg
myElement =
    Element.el
        [ Background.color (rgb 0 0.5 0)
        , Border.color (rgb 0 0.7 0)
        , Border.width 10
        ]
        (Element.text "You've made a stylish element!")

main =
    Element.layout []
      myElement