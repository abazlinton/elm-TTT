module Main exposing (..)

import Array exposing (..)
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type Msg
    = Take Int


cellStyle =
    [ ( "user-select", "none" )
    , ( "justify-content", "center" )
    , ( "display", "flex" )
    , ( "align-items", "center" )
    , ( "background-color", "lightgrey" )
    , ( "font-size", "8vw" )
    ]


gridStyle =
    [ ( "display", "grid" )
    , ( "align-items", "stretch" )
    , ( "grid-template-columns", "15vw 15vw 15vw" )
    , ( "grid-template-rows", "15vw 15vw 15vw" )
    , ( "grid-gap", "0.5vw" )
    , ( "background-color", "#fff" )
    , ( "color", "#444" )
    ]


cellToDiv : Int -> String -> Html Msg
cellToDiv index cell =
    div
        [ id (toString index)
        , class "cell"
        , onClick (Take index)
        , style cellStyle
        ]
        [ text cell ]


turns =
    Dict.fromList [ ( "O", "X" ), ( "X", "O" ) ]

updateTurn : String -> String
updateTurn current =
    Maybe.withDefault "" (Dict.get current turns)


type alias Model =
    { board : Array String
    , turn : String
    }


model : Model
model =
    { board = Array.repeat 9 ""
    , turn = "X"
    }


view : Model -> Html Msg
view model =
    div []
        [ div [ id "board", style gridStyle ]
            (toList (Array.indexedMap cellToDiv model.board))
        , div [] [ text model.turn ]
        ]

update : Msg -> Model -> Model
update msg model =
    case msg of
        Take index ->
          if Maybe.withDefault "" (get index model.board) == "" then
            { turn = updateTurn model.turn, board = set index model.turn model.board }
          else
            model