module Model exposing (..)

import Flags exposing (Flags, withDownload)
import Video


type alias Model =
    { selected : Maybe String
    , videos : List Video.Video
    , extensions : List Video.FileFormat
    , withDownload : Bool
    }


initialState : Flags -> Model
initialState flags =
    { selected = Nothing
    , videos = []
    , extensions = flags.extentions
    , withDownload = withDownload flags
    }
