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
    [ if List.length model.videos == 0 then Html.div [] [] else makeDropDown model.videos
    , if model.selected == "" then Html.div [] [] else makePlayer model.selected
    , Html.footer []
        [ Html.text "Handmade with love (and Vim and elm) ;)"
        , Html.a
          [ Html.Attributes.href "https://gitea.code-infection.com/efertone/minimal-webplayer"
          , Html.Attributes.target "_blank"
          ] [ Html.text "source" ]
        ]
    ]
  }

makeDropDown : List Video.Video -> Html.Html Msg.Msg
makeDropDown videos =
  Html.select [ Events.onInput Msg.VideoSelected ]
    <| makeOption {title = "Select one please ;)", path = ""} :: (List.map makeOption videos)

makeOption : Video.Video -> Html.Html Msg.Msg
makeOption video =
  Html.option
    [ Html.Attributes.value video.path ] [ Html.text video.title ]

makePlayer : String -> Html.Html Msg.Msg
makePlayer path =
  Html.video
    [ Html.Attributes.width 960
    , Html.Attributes.height 650
    , Html.Attributes.controls True
    ]
    [ Html.source [Html.Attributes.src (path ++ ".mkv"), Html.Attributes.type_ "video/x-matroska"] []
    , Html.source [Html.Attributes.src (path ++ ".mp4"), Html.Attributes.type_ "video/mp4"] []
    ]