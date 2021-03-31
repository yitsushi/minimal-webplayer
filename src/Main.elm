module Main exposing (..)

import Browser
import Msg
import Request
import Model exposing (Model)
import Update
import View
import Flags exposing (Flags)


main : Program Flags Model Msg.Msg
main =
    Browser.application
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = \_ -> Msg.NoOp
        , onUrlRequest = \_ -> Msg.NoOp
        }


init : Flags -> a -> b -> ( Model, Cmd Msg.Msg )
init flags _ _ =
    ( Model.initialState flags, Request.videoList )
