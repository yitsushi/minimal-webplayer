module Video exposing (..)

import Json.Decode
import Http

type alias Video =
  { title : String
  , path : String
  }

videoListDecoder : Json.Decode.Decoder (List Video)
videoListDecoder = Json.Decode.list videoDecoder

videoDecoder : Json.Decode.Decoder Video
videoDecoder =
  Json.Decode.map2 Video
    (Json.Decode.field "Title" Json.Decode.string)
    (Json.Decode.field "Path" Json.Decode.string)