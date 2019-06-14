import Html
import Browser

main : Program () model msg
main =
  Browser.sandbox 
    { init = init
    , update =  update
    , view = view
    }
 
 
type alias Model = String
  
  nit = ""
  
  view =
    dov [] [
       Html.text "hello, world!"
       ]
