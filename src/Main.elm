module Main exposing (..)

import Browser
import Browser.Navigation
import Url

import Msg
import Update
import Request
import Types
import View

main : Program Types.Flags Types.Model Msg.Msg
main =
    Browser.application
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = \_ -> Msg.NoOp
        , onUrlRequest = \_ -> Msg.NoOp
        }

init : Types.Flags -> Url.Url -> Browser.Navigation.Key -> ( Types.Model, Cmd Msg.Msg )
init _ _ _ = ({ selected = "", videos = [] }, Request.videoList)
