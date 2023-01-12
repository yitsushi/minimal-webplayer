module Msg exposing (..)

import Http
import Video


type Msg
    = NoOp
    | VideoSelected String
    | GroupSelected String
    | VideoListLanded (Result Http.Error (List Video.Video))
