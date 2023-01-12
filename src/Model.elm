module Model exposing (..)

import Flags exposing (Flags, withDownload)
import Video


type alias Model =
    { selectedGroup : Maybe String
    , selected : Maybe String
    , videos : List Video.Video
    , extensions : List Video.FileFormat
    , withDownload : Bool
    }


initialState : Flags -> Model
initialState flags =
    { selectedGroup = Nothing
    , selected = Nothing
    , videos = []
    , extensions = flags.extentions
    , withDownload = withDownload flags
    }
