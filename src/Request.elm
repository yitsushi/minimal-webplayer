module Request exposing (..)

import Http
import Msg
import Video


videoList : Cmd Msg.Msg
videoList =
    Http.get { url = "videos.json", expect = Http.expectJson Msg.VideoListLanded Video.videoListDecoder }
