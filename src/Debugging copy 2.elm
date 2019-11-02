module Debugging exposing (main)

import Html exposing (..)
import Json.Decode as Json
import Json.Decode.Pipeline exposing (required)

type Breed 
 = Sheltie
 | Poodle

breedToString : Breed -> String
breedToString  breed =
  case breed of
    Sheltie ->
      "Sheltie"
    _ ->
      Debug.todo "Handle other breeds in breedToString"


type alias Dog =
  { name : String
  , age : Int
  , breed : Breed
  }

decodeBreed : String -> Json.Decoder Breed
decodeBreed breed =
  case Debug.log "breed" breed of
    "Sheltie" ->
      Json.succeed Sheltie
    _ ->
      Debug.todo "Handle other breeds in decodeBreed"

dogDecoder : Json.Decoder Dog
dogDecoder =
  Json.succeed Dog
    |> required "name" Json.string
    |> required "age" Json.int
    |> required "breed" (Json.string |> Json.andThen decodeBreed)

jsonDog : String
jsonDog =
  """
    {
        "name" : "Tucker",
        "age": 11,
        -- "breed" : "Sheltie"
        "breed" : "Sheltie"
    }
  """

decodedDog : Result Json.Error Dog
decodedDog =
  Json.decodeString dogDecoder jsonDog

viewDog : Dog -> Html msg
viewDog  dog =
   text <|
     dog.name
     ++ " the "
     ++ breedToString dog.breed
     ++ " is "
     ++ String.fromInt dog.age
     ++ " years old."

main : Html msg
main = 
  case Debug.log "decodedDog" decodedDog of
    Ok dog ->
      viewDog dog
    Err _ ->
      text "ERROR: Couldn't decode dog."