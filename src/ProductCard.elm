module ProductCard exposing (ProductCardProps, view)

import ColorSelector exposing (viewColorSelector)
import Html exposing (Html, button, div, h3, img, p, span, text)
import Html.Attributes exposing (alt, class, src, style)
import Html.Events exposing (onClick)
import Types exposing (Image)


type alias ProductCardProps msg =
    { title : String
    , priceRange : String
    , description : String
    , tag : String
    , images : List Image
    , selectedColor : String
    , showInside : Bool
    , onToggleShowInside : msg
    , onSelectColor : String -> msg
    }


view : ProductCardProps msg -> Html msg
view props =
    div [ class "flex flex-col items-start bg-[#f7f7f7] gap-4" ]
        [ div [ class "relative group" ]
            [ img
                [ src (getCurrentImage props.images props.selectedColor props.showInside)
                , alt props.title
                , class "w-full object-cover"
                ]
                []
            , button
                [ class "absolute uppercase rounded-bl top-0 right-0 text-xs tracking-wide bg-gray-300 px-2 py-1 flex items-center gap-1 opacity-0 group-hover:opacity-100 transition"
                , onClick props.onToggleShowInside
                ]
                [ text
                    (if props.showInside then
                        "Close"

                     else
                        "Show Inside"
                    )
                , span
                    [ class
                        ("transform transition-transform "
                            ++ (if props.showInside then
                                    "rotate-45"

                                else
                                    "rotate-0"
                               )
                        )
                    ]
                    [ text "+" ]
                ]
            ]
        , div [ class "p-4" ]
            [ div [ class "mb-2" ]
                [ if props.tag /= "" then
                    p [ class "inline-block bg-white text-red-600 text-xs px-2 py-1 rounded" ]
                        [ text props.tag ]

                  else
                    p [ class "inline-block px-2 py-1" ]
                        [ text "" ]
                ]
            , div []
                [ h3 [ class "font-sans text-[0.93rem] leading-6 font-normal tracking-wide antialiased text-gray-800" ] [ text props.title ]
                , span [ class "font-sans text-sm leading-6 tracking-wide antialiased" ] [ text props.priceRange ]
                ]
            , span [ class "flex space-x-2 mt-2" ] (viewColorSelector props.images props.selectedColor props.onSelectColor)
            , p [ class "text-xs text-gray-500 mt-2" ] [ text props.description ]
            ]
        ]


getCurrentImage : List Image -> String -> Bool -> String
getCurrentImage images selectedColor showInside =
    case List.filter (\img -> img.color == selectedColor) images of
        img :: _ ->
            if showInside then
                img.inside

            else
                img.front

        [] ->
            ""
