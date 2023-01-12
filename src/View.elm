module View exposing (..)

import Browser exposing (Document)
import Dropdown
import Html
import Html.Attributes
import Model exposing (Model)
import Msg
import Video


unique : List a -> List a
unique list =
    List.foldr
        (\elem lst ->
            if List.member elem lst then
                lst

            else
                elem :: lst
        )
        incUnique
        []
        list


view : Model -> Document Msg.Msg
view model =
    { title = "Minimal WebPlayer"
    , body =
        [ groupDropdown model.videos
        , dropdown model.selectedGroup model.videos
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


groupDropdown : List Video.Video -> Html.Html Msg.Msg
groupDropdown videos =
    if List.isEmpty videos then
        Html.div [] [ Html.text "Please wait..." ]

    else
        Dropdown.view
            { options = unique <| List.map (\v -> { value = v.name, display = v.name }) videos
            , default = { value = "", display = "Select one please ;)" }
            , selectEvent = Msg.GroupSelected
            }


dropdown : Maybe String -> List Video.Video -> Html.Html Msg.Msg
dropdown group videos =
    if List.isEmpty videos then
        Html.div [] [ Html.text "Please wait..." ]

    else
        Dropdown.view
            { options =
                List.filterMap
                    (\v ->
                        case group of
                            Nothing ->
                                Just { value = v.path, display = v.title }

                            Just name ->
                                if name == v.name then
                                    Just { value = v.path, display = v.title }

                                else
                                    Nothing
                    )
                    videos
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
