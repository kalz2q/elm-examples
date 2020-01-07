module Audio004 exposing (main)

-- HA.src "../foo.wav"
-- try HA.src "https://github.com/kalz2q/gakufu/blob/master/foo.wav"
-- https://drive.google.com/file/d/1IUy62-fQedrICiFxD_pgIUbH9Sfcrhr7/view?usp=sharing

import Html exposing (..)
import Html.Attributes as HA


main =
    audio
        [ HA.src "https://drive.google.com/file/d/1IUy62-fQedrICiFxD_pgIUbH9Sfcrhr7/view?usp=sharing"
        , HA.controls True
        ]
        []
