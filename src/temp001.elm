viewDetailedPhoto : { url : String, caption : String, liked : Bool } -> Html Msg
viewDetailedPhoto model =
let
  buttonClass =
     if model.liked then
        "fa-heart"
      else
        "fa-heart-o"
   msg =
         if model.liked then
                Unlike
          else
              Like
  in
div [ class "detailed-photo" ]
[ img [ src model.url ] []
, div [ class "photo-info" ]
[ div [ class "like-button" ]
❹ [ Html.i
❺ [ class "fa fa-2x"
❻ , class buttonClass
❼ , onClick msg
]
[]
]
, h2 [ class "caption" ] [ text model.caption ]
]
]