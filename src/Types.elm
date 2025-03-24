module Types exposing (Image, Product)


type alias Image =
    { color : String
    , front : String
    , inside : String
    , hex : String
    }


type alias Product =
    { id : Int
    , title : String
    , priceRange : String
    , description : String
    , tag : String
    , images : List Image
    }
