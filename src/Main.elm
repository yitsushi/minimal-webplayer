module Main exposing (..)

import Browser
import Msg
import Request
import Types
import Update
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


init : Types.Flags -> a -> b -> ( Types.Model, Cmd Msg.Msg )
init flags _ _ =
    ( initialState flags, Request.videoList )


initialState : Types.Flags -> Types.Model
initialState flags =
    { selected = Nothing
    , videos = []
    , extensions = flags.extentions
    , withDownload = Types.withDownload flags
    }
