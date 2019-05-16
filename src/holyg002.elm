module HolyG002 exposing (main)


import Element exposing (..)
import Element.Background as Background
import Element.Input as Input
import Html exposing (Html, a, div, h1, li, p, ul)

main =
    layout [] <|
        column [ width fill, height fill ]
            [ row [ width fill, height <| px 100, Background.color pink ] [ text "header pink" ]
            , row [ width fill, height fill ]
                [ column [ width <| fillPortion 1, height fill, Background.color slategray ] [ text "nav slategray" ]
                , column [ width <| fillPortion 3, height fill, Background.color yellowgreen ] [ text "main yellogreen" ]
                , column [ width <| fillPortion 1 , height fill, Background.color sandybrown ] [ text "ad sandybrown" ]
                ]
            , row [ width fill, height <| px 100, Background.color peachpuff ] [ text "footer peachpuff" ]
            ]

black = rgb255 0 0 0
maroon = rgb255 128 0 0
darkred = rgb255 139 0 0
red = rgb255 255 0 0
firebrick = rgb255 178 34 34
brown = rgb255 165 42 42
indianred = rgb255 205 92 92
rosybrown = rgb255 188 143 143
lightcoral = rgb255 240 128 128
dimgray = rgb255 105 105 105
gray = rgb255 128 128 128
darkgray = rgb255 169 169 169
silver = rgb255 192 192 192
lightgray = rgb255 211 211 211
gainsboro = rgb255 220 220 220
whitesmoke = rgb255 245 245 245
snow = rgb255 255 250 250
white = rgb255 255 255 255
salmon = rgb255 250 128 114
mistyrose = rgb255 255 228 225
tomato = rgb255 255 99 71
darksalmon = rgb255 233 150 122
orangered = rgb255 255 69 0
coral = rgb255 255 127 80
lightsalmon = rgb255 255 160 122
sienna = rgb255 160 82 45
saddlebrown = rgb255 139 69 19
chocolate = rgb255 210 105 30
sandybrown = rgb255 244 164 96
peachpuff = rgb255 255 218 185
peru = rgb255 205 133 63
linen = rgb255 250 240 230
darkorange = rgb255 255 140 0
bisque = rgb255 255 228 196
tan = rgb255 210 180 140
burlywood = rgb255 222 184 135
antiquewhite = rgb255 250 235 215
navajowhite = rgb255 255 222 173
blanchedalmond = rgb255 255 235 205
papayawhip = rgb255 255 239 213
moccasin = rgb255 255 228 181
orange = rgb255 255 165 0
wheat = rgb255 245 222 179
oldlace = rgb255 253 245 230
floralwhite = rgb255 255 250 240
darkgoldenrod = rgb255 184 134 11
goldenrod = rgb255 218 165 32
cornsilk = rgb255 255 248 220
gold = rgb255 255 215 0
khaki = rgb255 240 230 140
lemonchiffon = rgb255 255 250 205
palegoldenrod = rgb255 238 232 170
darkkhaki = rgb255 189 183 107
seashell = rgb255 255 245 238
yellow = rgb255 255 255 0
beige = rgb255 245 245 220
lightgoldenrodyellow = rgb255 250 250 210
lightyellow = rgb255 255 255 224
ivory = rgb255 255 255 240
olive = rgb255 128 128 0
olivedrab = rgb255 107 142 35
darkolivegreen = rgb255 85 107 47
greenyellow = rgb255 173 255 47
lawngreen = rgb255 124 252 0
chartreuse = rgb255 127 255 0
yellowgreen = rgb255 154 205 50
green = rgb255 0 128 0
darkseagreen = rgb255 143 188 143
limegreen = rgb255 50 205 50
darkgreen = rgb255 0 100 0
lime = rgb255 0 255 0
lightgreen = rgb255 144 238 144
palegreen = rgb255 152 251 152
forestgreen = rgb255 34 139 34
seagreen = rgb255 46 139 87
mediumseagreen = rgb255 60 179 113
springgreen = rgb255 0 255 127
mintcream = rgb255 245 255 250
mediumspringgreen = rgb255 0 250 154
honeydew = rgb255 240 255 240
mediumaquamarine = rgb255 102 205 170
aquamarine = rgb255 127 255 212
turquoise = rgb255 64 224 208
lightseagreen = rgb255 32 178 170
mediumturquoise = rgb255 72 209 204
darkslategray = rgb255 47 79 79
teal = rgb255 0 128 128
darkcyan = rgb255 0 139 139
aqua = rgb255 0 255 255
cyan = rgb255 0 255 255
paleturquoise = rgb255 175 238 238
lightcyan = rgb255 224 255 255
azure = rgb255 240 255 255
darkturquoise = rgb255 0 206 209
cadetblue = rgb255 95 158 160
powderblue = rgb255 176 224 230
deepskyblue = rgb255 0 191 255
lightblue = rgb255 173 216 230
skyblue = rgb255 135 206 235
lightskyblue = rgb255 135 206 250
steelblue = rgb255 70 130 180
dodgerblue = rgb255 30 144 255
slategray = rgb255 112 128 144
lightslategray = rgb255 119 136 153
lightsteelblue = rgb255 176 196 222
cornflowerblue = rgb255 100 149 237
royalblue = rgb255 65 105 225
aliceblue = rgb255 240 248 255
darkblue = rgb255 0 0 139
mediumblue = rgb255 0 0 205
blue = rgb255 0 0 255
midnightblue = rgb255 25 25 112
lavender = rgb255 230 230 250
ghostwhite = rgb255 248 248 255
navy = rgb255 0 0 128
darkslateblue = rgb255 72 61 139
slateblue = rgb255 106 90 205
mediumslateblue = rgb255 123 104 238
mediumpurple = rgb255 147 112 219
rebeccapurple = rgb255 102 51 153
blueviolet = rgb255 138 43 226
indigo = rgb255 75 0 130
darkorchid = rgb255 153 50 204
darkviolet = rgb255 148 0 211
mediumorchid = rgb255 186 85 211
purple = rgb255 128 0 128
mediumvioletred = rgb255 199 21 133
magenta = rgb255 255 0 255
fuchsia = rgb255 255 0 255
violet = rgb255 238 130 238
plum = rgb255 221 160 221
thistle = rgb255 216 191 216
orchid = rgb255 218 112 214
darkmagenta = rgb255 139 0 139
deeppink = rgb255 255 20 147
hotpink = rgb255 255 105 180
palevioletred = rgb255 219 112 147
lavenderblush = rgb255 255 240 245
crimson = rgb255 220 20 60
pink = rgb255 255 192 203
lightpink = rgb255 255 182 193