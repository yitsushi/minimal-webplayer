module Video exposing (..)

import Html
import Html.Attributes
import Json.Decode

type alias Video =
  { title : String
  , path : String
  }

type alias FileFormat =
  { extention : String
  , mime : String
  }

videoListDecoder : Json.Decode.Decoder (List Video)
videoListDecoder = Json.Decode.list videoDecoder

videoDecoder : Json.Decode.Decoder Video
videoDecoder =
  Json.Decode.map2 Video
    (Json.Decode.field "Title" Json.Decode.string)
    (Json.Decode.field "Path" Json.Decode.string)

htmlSourceElem : String -> FileFormat -> Html.Html msg
htmlSourceElem path format =
  Html.source
    [ Html.Attributes.src (path ++ "." ++ format.extention)
    , Html.Attributes.type_ format.mime
    ] []

downloadLink : String -> FileFormat -> Html.Html msg
downloadLink path format =
  Html.a
    [ Html.Attributes.href (path ++ "." ++ format.extention)
    , Html.Attributes.download <| filename path format
    ]
    [ Html.text <| filename path format ]

filename : String -> FileFormat -> String
filename path format =
  (Maybe.withDefault "unknown" <| List.head <| List.drop 1 <| String.split "/" path) ++ "." ++ format.extention