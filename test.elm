import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Array exposing (..)

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update 
    }

cellToDiv : Int -> String -> Html msg
cellToDiv index cell =
  div [id ( toString index )][text cell]

type Msg = Dummy String

type alias Model =
  { board : Array String }

model : Model
model = {board = Array.repeat 9 ""}


view : Model -> Html msg
view model =
      node "div" [id "board"] ( toList ( Array.indexedMap cellToDiv model.board ) )
    
update : Msg -> Model -> Model
update msg model = model