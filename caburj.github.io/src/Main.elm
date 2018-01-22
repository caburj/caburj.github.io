module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (string)


---- MODEL ----


type alias Model =
    { joke : String }


init : ( Model, Cmd Msg )
init =
    Model "Fetching random dad joke..." ! [ getJoke ]



---- UPDATE ----


type Msg
    = MoreJoke
    | NewJoke (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MoreJoke ->
            model ! [ getJoke ]

        NewJoke (Ok newJoke) ->
            Model newJoke ! []

        NewJoke (Err _) ->
            Model "What time did the man go to the dentist? Tooth hurt-y." ! []



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ id "content" ]
        [ h2 [] [ text "Joseph Caburnay" ]
        , h4 [] [ text "@caburj" ]
        , img [ src "/wedding.png" ] []
        , blockquote
            [ class "blockquote text-center"
            , onClick MoreJoke
            ]
            [ p [ class "mb-0" ]
                [ text model.joke ]
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



---- HTTP ----


getJoke : Cmd Msg
getJoke =
    Http.send NewJoke (Http.get "https://icanhazdadjoke.com/slack" decodeJokeUrl)


decodeJokeUrl : Decode.Decoder String
decodeJokeUrl =
    Decode.at [ "attachments", "0", "text" ] string
