module ColorSelector exposing (viewColorSelector)

import Html exposing (Html, button, div)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (Image)


viewColorSelector : List Image -> String -> (String -> msg) -> List (Html msg)
viewColorSelector images selectedColor toMsg =
    List.map
        (\img ->
            let
                isSelected =
                    img.color == selectedColor
            in
            button
                [ onClick (toMsg img.color)
                , style "background-color" img.hex
                , class
                    ("cursor-pointer rounded-full w-[19px] h-[19px] outline outline-2 outline-transparent outline-offset-[-3px] "
                        ++ (if isSelected then
                                " outline-white"

                            else
                                ""
                           )
                    )
                ]
                []
        )
        images
