module Audio004 exposing (main)

-- HA.src "../foo.wav"
-- try HA.src "https://github.com/kalz2q/gakufu/blob/master/foo.wav"
-- https://drive.google.com/file/d/1IUy62-fQedrICiFxD_pgIUbH9Sfcrhr7/view?usp=sharing
-- https://drive.google.com/file/d/1zRy9O9U4w8HsSnJuMJvDQG276MwGept9/view?usp=sharing
-- [ HA.src "https://drive.google.com/uc?id=1IUy62-fQedrICiFxD_pgIUbH9Sfcrhr7"
-- https://drive.google.com/file/d/10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY/view?usp=sharing

import Html exposing (..)
import Html.Attributes as HA


main =
    audio
        [ HA.src "https://drive.google.com/uc?id=10DniZHZ3-IPLTOgZwIpBZr5B1P78ApPY"
        , HA.controls True
        ]
        []
