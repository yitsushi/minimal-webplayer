module View exposing (..)

import Browser exposing (Document)
import Dropdown
import Html
import Html.Attributes
import Msg
import Model exposing (Model)
import Video


view : Model -> Document Msg.Msg
view model =
    { title = "Minimal WebPlayer"
    , body =
        [ dropdown model.videos
        , player model
        , download model
        , Html.footer []
            [ Html.text "Handmade with love (and Vim and elm) ;)"
            , Html.a
                [ Html.Attributes.href "https://gitea.code-infection.com/efertone/minimal-webplayer"
                , Html.Attributes.target "_blank"
                ]
                [ Html.text "source" ]
            ]
        ]
    }


dropdown : List Video.Video -> Html.Html Msg.Msg
dropdown videos =
    if List.isEmpty videos then
        Html.div [] [ Html.text "Please wait..." ]

    else
        Dropdown.view
            { options = List.map (\v -> { value = v.path, display = v.title }) videos
            , selectEvent = Msg.VideoSelected
            , default = { value = "", display = "Select one please ;)" }
            }


player : Model -> Html.Html Msg.Msg
player model =
    Video.makePlayer
        { path = model.selected
        , extensions = model.extensions
        , attrs =
            [ Html.Attributes.width 960
            , Html.Attributes.height 650
            , Html.Attributes.controls True
            ]
        }


download : Model -> Html.Html Msg.Msg
download model =
    Video.downloadList
        { selected =
            if not model.withDownload then
                Nothing

            else
                model.selected
        , extensions = model.extensions
        , attrs = [ Html.Attributes.class "downloadList" ]
        }
