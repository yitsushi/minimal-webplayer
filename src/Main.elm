module Main exposing (..)

import Browser exposing (Document)
import Browser.Navigation
import Html
import Html.Attributes
import Url
import Html.Events as Events
import Json.Decode
import Http


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = \_ -> NoOp
        , onUrlRequest = \_ -> NoOp
        }

type alias Flags = { }

type Msg
  = NoOp
  | VideoSelected String
  | VideoListLanded (Result Http.Error (List Video))

type alias Video =
  { title : String
  , path : String
  }

type alias Model =
  { selected : String
  , videos : List Video
  }

init : flags -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ _ _ = ({ selected = "", videos = [{title="asd", path="kjhkj"}] }, requestVideoList)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    VideoSelected path -> ({model | selected = path}, Cmd.none)
    VideoListLanded response ->
      case response of
        Ok videos -> ({model | videos = videos}, Cmd.none)
        Err _ -> (model, Cmd.none)
    NoOp -> (model, Cmd.none)

view : Model -> Document Msg
view model =
  { title = "My Title"
  , body =
    [ if List.length model.videos == 0 then Html.div [] [] else makeDropDown model.videos
    , if model.selected == "" then Html.div [] [] else makePlayer model.selected
    , Html.footer [] [ Html.text "Handmade with love (and Vim and elm) ;)" ]
    ]
  }

makeDropDown : List Video -> Html.Html Msg
makeDropDown videos =
  Html.select []
    <| makeOption {title = "Select one please ;)", path = ""} :: (List.map makeOption videos)

makeOption : Video -> Html.Html Msg
makeOption video =
  Html.option
    [ Events.onClick (VideoSelected video.path)
    , Html.Attributes.value video.path
    ] [ Html.text video.title ]

makePlayer : String -> Html.Html Msg
makePlayer path =
  Html.video
    [ Html.Attributes.width 960
    , Html.Attributes.height 650
    , Html.Attributes.controls True
    ]
    [ Html.source [Html.Attributes.src (path ++ ".mkv"), Html.Attributes.type_ "video/x-matroska"] []
    , Html.source [Html.Attributes.src (path ++ ".mp4"), Html.Attributes.type_ "video/mp4"] []
    ]

requestVideoList : Cmd Msg
requestVideoList = Http.get { url = "videos.json", expect = Http.expectJson VideoListLanded videoListDecoder }

videoListDecoder : Json.Decode.Decoder (List Video)
videoListDecoder = Json.Decode.list videoDecoder

videoDecoder : Json.Decode.Decoder Video
videoDecoder =
  Json.Decode.map2 Video
    (Json.Decode.field "Title" Json.Decode.string)
    (Json.Decode.field "Path" Json.Decode.string)