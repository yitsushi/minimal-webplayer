module Update exposing (..)

import Msg
import Types

update : Msg.Msg -> Types.Model -> ( Types.Model, Cmd Msg.Msg )
update msg model =
  case msg of
    Msg.VideoSelected path -> ({model | selected = path}, Cmd.none)
    Msg.VideoListLanded response ->
      case response of
        Ok videos -> ({model | videos = videos}, Cmd.none)
        Err _ -> (model, Cmd.none)
    Msg.NoOp -> (model, Cmd.none)