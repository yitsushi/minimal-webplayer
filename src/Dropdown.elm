module Dropdown exposing (..)

import Html
import Html.Attributes
import Html.Events as Events

type alias Option =
  { value : String
  , display : String
  }

type alias Config msg =
  { options : List Option
  , default : Option
  , selectEvent : String -> msg
  }

view : Config msg -> Html.Html msg
view config = Html.select [ Events.onInput config.selectEvent ] <|
                makeOption config.default
                    :: List.map makeOption config.options

makeOption : Option -> Html.Html msg
makeOption option =
    Html.option
        [ Html.Attributes.value option.value ]
        [ Html.text option.display ]