module Flags exposing (..)

import Video

type alias Flags =
    { debug : Bool
    , withDownload : Bool
    , extentions : List Video.FileFormat
    }


debugEnabled : Flags -> Bool
debugEnabled flags =
    flags.debug


withDownload : Flags -> Bool
withDownload flags =
    flags.withDownload
