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
videoListDecoder =
    Json.Decode.list videoDecoder


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
        ]
        []


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


type alias ListConfig msg =
    { selected : Maybe String
    , extensions : List FileFormat
    , attrs : List (Html.Attribute msg)
    }


downloadList : ListConfig msg -> Html.Html msg
downloadList config =
    case config.selected of
        Nothing ->
            Html.div [] []

        Just path ->
            Html.div config.attrs <|
                List.map (\e -> downloadLink path e) config.extensions


type alias PlayerConfig msg =
    { path : Maybe String
    , extensions : List FileFormat
    , attrs : List (Html.Attribute msg)
    }


makePlayer : PlayerConfig msg -> Html.Html msg
makePlayer config =
    case config.path of
        Nothing ->
            Html.div [] []

        Just path ->
            Html.video config.attrs (List.map (htmlSourceElem path) config.extensions)
