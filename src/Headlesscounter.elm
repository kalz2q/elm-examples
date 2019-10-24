-- port module Main exposing (main, tick)
module Main exposing (main)



import Time


-- port tick : Int -> Cmd msg


main : Program () Int ()
main =
    Platform.worker
        { init =
            \_ ->
                ( 1
                , Cmd.none
                )
        , update =
            \_ model ->
                ( model + 1
                -- , tick model
                )
        , subscriptions = \_ -> Time.every 1000 (\_ -> ())
        }
