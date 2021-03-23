module Types exposing (..)

import Video

type alias Flags = { }

type alias Model =
  { selected : String
  , videos : List Video.Video
  }