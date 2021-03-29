module Msg exposing (..)

import Http
import Video


type Msg
    = NoOp
    | VideoSelected String
    | VideoListLanded (Result Http.Error (List Video.Video))
