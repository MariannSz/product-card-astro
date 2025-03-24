-- src/Main.elm


module Main exposing (main)

import Browser
import Dict exposing (Dict)
import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class)
import Http
import Json.Decode as Decode
import ProductCard exposing (ProductCardProps, view)
import Types exposing (Image, Product)



-- MODEL


type alias Model =
    { products : List Product
    , selectedColors : Dict Int String
    , showInsideStates : Dict Int Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { products = [], selectedColors = Dict.empty, showInsideStates = Dict.empty }
    , fetchProducts
    )



-- UPDATE


type Msg
    = ProductsFetched (Result Http.Error (List Product))
    | SelectColor Int String
    | ToggleShowInside Int
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProductsFetched (Ok products) ->
            let
                initialColors =
                    products
                        |> List.map
                            (\p ->
                                ( p.id
                                , case p.images of
                                    img :: _ ->
                                        img.color

                                    [] ->
                                        ""
                                )
                            )
                        |> Dict.fromList

                initialShowInside =
                    products
                        |> List.map (\p -> ( p.id, False ))
                        |> Dict.fromList
            in
            ( { model | products = products, selectedColors = initialColors, showInsideStates = initialShowInside }, Cmd.none )

        ProductsFetched (Err _) ->
            ( model, Cmd.none )

        SelectColor productId color ->
            ( { model | selectedColors = Dict.insert productId color model.selectedColors }, Cmd.none )

        ToggleShowInside productId ->
            let
                newShowInside =
                    Dict.get productId model.showInsideStates
                        |> Maybe.map not
                        |> Maybe.withDefault False
            in
            ( { model | showInsideStates = Dict.insert productId newShowInside model.showInsideStates }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



-- FETCH


fetchProducts : Cmd Msg
fetchProducts =
    Http.get
        { url = "/product.json"
        , expect = Http.expectJson ProductsFetched productsDecoder
        }


productsDecoder : Decode.Decoder (List Product)
productsDecoder =
    Decode.field "products" (Decode.list productDecoder)


productDecoder : Decode.Decoder Product
productDecoder =
    Decode.map6 Product
        (Decode.field "id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "priceRange" Decode.string)
        (Decode.field "description" Decode.string)
        (Decode.field "tag" Decode.string)
        (Decode.field "images" (Decode.list imageDecoder))


imageDecoder : Decode.Decoder Image
imageDecoder =
    Decode.map4 Image
        (Decode.field "color" Decode.string)
        (Decode.field "front" Decode.string)
        (Decode.field "inside" Decode.string)
        (Decode.field "hex" Decode.string)



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 gap-1" ]
        (List.map (viewProductCard model.selectedColors model.showInsideStates) model.products)


viewProductCard : Dict Int String -> Dict Int Bool -> Product -> Html Msg
viewProductCard selectedColors showInsideStates product =
    let
        currentColor =
            Dict.get product.id selectedColors
                |> Maybe.withDefault
                    (case product.images of
                        img :: _ ->
                            img.color

                        [] ->
                            ""
                    )

        showInside =
            Dict.get product.id showInsideStates
                |> Maybe.withDefault False
    in
    ProductCard.view
        { title = product.title
        , priceRange = product.priceRange
        , description = product.description
        , tag = product.tag
        , images = product.images
        , selectedColor = currentColor
        , showInside = showInside
        , onToggleShowInside = ToggleShowInside product.id
        , onSelectColor = \color -> SelectColor product.id color
        }



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
