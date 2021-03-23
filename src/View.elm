module View exposing (..)

import Browser exposing (Document)
import Html
import Html.Attributes
import Html.Events as Events

import Msg
import Types
import Video

view : Types.Model -> Document Msg.Msg
view model =
  { title = "Minimal WebPlayer"
  , body =
    [ makeDropDown model.videos
    , makePlayer model
    , downloadList model
    , Html.footer []
        [ Html.text "Handmade with love (and Vim and elm) ;)"
        , Html.a
          [ Html.Attributes.href "https://gitea.code-infection.com/efertone/minimal-webplayer"
          , Html.Attributes.target "_blank"
          ] [ Html.text "source" ]
        ]
    ]
  }

empty : Html.Html Msg.Msg
empty = Html.div [] []

makeDropDown : List Video.Video -> Html.Html Msg.Msg
makeDropDown videos =
  if List.isEmpty videos
    then empty
    else
      Html.select [ Events.onInput Msg.VideoSelected ]
        <| makeOption {title = "Select one please ;)", path = ""} :: (List.map makeOption videos)

makeOption : Video.Video -> Html.Html Msg.Msg
makeOption video =
  Html.option
    [ Html.Attributes.value video.path ] [ Html.text video.title ]

makePlayer : Types.Model -> Html.Html Msg.Msg
makePlayer model = 
  case model.selected of
    Nothing -> empty
    Just path ->
      Html.video
        [ Html.Attributes.width 960
        , Html.Attributes.height 650
        , Html.Attributes.controls True
        ] <| List.map (Video.htmlSourceElem path) model.extensions

downloadList : Types.Model -> Html.Html Msg.Msg
downloadList model =
  let
    selected = if not model.withDownload then Nothing else model.selected
  in
    case selected of
      Nothing -> empty
      Just path ->
        Html.div [ Html.Attributes.class "downloadList" ]
          <| List.map (\e -> Video.downloadLink path e) model.extensions