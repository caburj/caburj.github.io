module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ id "content" ]
        [ h2 [] [ text "Joseph Caburnay" ]
        , h4 [] [ text "@caburj" ]
        , img [ src "/wedding.png" ] []
        , blockquote [ class "blockquote text-center" ]
            [ p [ class "mb-0" ]
                [ text "\"In the cave you fear to enter, holds the treasure you seek.\"" ]
            , footer [ class "blockquote-footer" ]
                [ node
                    "cite"
                    [ title "" ]
                    [ text "Joseph Campbell" ]
                ]
            ]
        , div [ class "links" ]
            [ ul []
                [ li []
                    [ a
                        [ class "button"
                        , href "https://www.linkedin.com/in/caburj/"
                        , target "blank_"
                        ]
                        [ i [ class "fa fa-linkedin" ] [] ]
                    ]
                , li []
                    [ a
                        [ class "button"
                        , href "https://twitter.com/caburj"
                        , target "blank_"
                        ]
                        [ i [ class "fa fa-twitter" ] [] ]
                    ]
                , li []
                    [ a
                        [ class "button"
                        , href "https://github.com/caburj"
                        , target "blank_"
                        ]
                        [ i [ class "fa fa-github" ] [] ]
                    ]
                , li []
                    [ a
                        [ class "button"
                        , href "https://medium.com/@caburj"
                        , target "blank_"
                        ]
                        [ i [ class "fa fa-medium" ] [] ]
                    ]
                ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
