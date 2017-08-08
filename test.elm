import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Array exposing (..)

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update 
    }

type Msg = Take Int

cellToDiv : Int -> String -> Html Msg
cellToDiv index cell =
  div [id ( toString index ), class "cell", onClick (Take index)][text cell]

type alias Model =
  { board : Array String 
  , turn : String
  }

model : Model
model = 
  { board = Array.repeat 9 "O"
  , turn = "X"
  }


view : Model -> Html Msg
view model =
  div [][
  node "div" [id "board"] ( toList ( Array.indexedMap cellToDiv model.board ) )
  , div [][text model.turn]
  ]
    
update : Msg -> Model -> Model
update msg model =
  case msg of
      Take index ->
        {model | turn = toString index}
  