module Types exposing (..)

import Video

type alias Flags =
  { debug : Bool
  , extentions : List Video.FileFormat
  }

type alias Model =
  { selected : Maybe String
  , videos : List Video.Video
  , extensions : List Video.FileFormat
  , withDownload : Bool
  }

videos : Model -> List Video.Video
videos model = model.videos

 -- These functions may seem useless, but that way it's easier to swap out
 -- from flags without changing the init function.

debugEnabled : Flags -> Bool
debugEnabled flags = flags.debug

withDownload : Flags -> Bool
withDownload flags = flags.debug