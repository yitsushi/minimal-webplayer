port module Update exposing (..)

import Msg
import Model exposing (Model)


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.VideoSelected "" ->
            ( { model | selected = Nothing }, reloadVideoSource () )
        Msg.VideoSelected path ->
            ( { model | selected = Just path }, reloadVideoSource () )

        Msg.VideoListLanded response ->
            case response of
                Ok videos ->
                    ( { model | videos = videos }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        Msg.NoOp ->
            ( model, Cmd.none )


port reloadVideoSource : () -> Cmd msg
