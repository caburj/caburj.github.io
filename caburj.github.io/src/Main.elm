module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onMouseOver)
import Http
import Json.Decode as Decode exposing (string)


---- MODEL ----


type alias Model =
    { joke : String
    , toggleLinks : Bool
    }


init : ( Model, Cmd Msg )
init =
    Model "Fetching random dad joke..." True ! [ getJoke ]



---- UPDATE ----


type Msg
    = MoreJoke
    | NewJoke (Result Http.Error String)
    | ToggleLinks


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MoreJoke ->
            model ! [ getJoke ]

        NewJoke (Ok newJoke) ->
            { model | joke = newJoke } ! []

        NewJoke (Err _) ->
            { model | joke = "What time did the man go to the dentist? Tooth hurt-y." } ! []

        ToggleLinks ->
            { model | toggleLinks = not model.toggleLinks } ! []



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        toggleMessage =
            if model.toggleLinks then
                "Interested in my works?"
            else
                "More on social media?"

        ( socialClass, worksClass ) =
            if model.toggleLinks then
                ( "m-fadeIn", "m-fadeOut" )
            else
                ( "m-fadeOut", "m-fadeIn" )
    in
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
            [ ul [ class ("social " ++ socialClass) ]
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
            , ul [ class ("works " ++ worksClass) ]
                [ li []
                    [ a
                        [ class "button"
                        , href "https://transaccion.netlify.com"
                        , target "blank_"
                        ]
                        [ i [ class "fa fa-book" ] [] ]
                    ]
                ]
            ]
        , div [ class "links-toggle", onMouseOver ToggleLinks, onClick ToggleLinks ]
            [ text toggleMessage ]
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
