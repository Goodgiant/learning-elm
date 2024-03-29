module Main exposing (..)

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick, onInput)


type alias Model =
    { name : String
    , email : String
    , password : String
    , loggedIn : Bool
    }


initialModel : Model
initialModel =
    { name = ""
    , email = ""
    , password = ""
    , loggedIn = False
    }


view : Model -> Html Msg
view model =
    div [ css [ padding (px 40)]]
        [ h1 [ css [ padding (px 20) ] ] [ text "Sign up" ]
        , styledForm []
            [ div []
                [ text "Name"
                , styledInput [ id "name", type_ "text", onInput SaveName ] []
                ]
            , div []
                [ text "Email"
                , styledInput [ id "email", type_ "email", onInput SaveEmail ] []
                ]
            , div []
                [ text "Password"
                , styledInput [ id "password", type_ "password", onInput SavePassword ] []
                ]
            , div []
                [ styledButton [ onClick Signup, type_ "submit" ]
                    [ text "Create my account" ]
                ]
            ]
        ]


styledForm : List (Attribute msg) -> List (Html msg) -> Html msg
styledForm =
    styled Html.Styled.form
        [ borderRadius (px 5)
        , backgroundColor (hex "#f2f2f2")
        , padding (px 20)
        , Css.width (px 300)
        ]


styledInput : List (Attribute msg) -> List (Html msg) -> Html msg
styledInput =
    styled Html.Styled.input
        [ display block
        , Css.width (px 260)
        , padding2 (px 12) (px 20)
        , margin2 (px 8) (px 0)
        , border (px 0)
        , borderRadius (px 4)
        ]


styledButton : List (Attribute msg) -> List (Html msg) -> Html msg
styledButton =
    styled Html.Styled.button
        [ Css.width (px 300)
        , backgroundColor (hex "#397cd5")
        , color (hex "#fff")
        , padding2 (px 14) (px 20)
        , marginTop (px 10)
        , border (px 0)
        , borderRadius (px 4)
        , fontSize (px 16)
        ]


type Msg
    = SaveName String
    | SaveEmail String
    | SavePassword String
    | Signup


update : Msg -> Model -> Model
update message model =
    case message of
        SaveName name ->
            { model | name = name }

        SaveEmail email ->
            { model | email = email }

        SavePassword password ->
            { model | password = password }

        Signup ->
            { model | loggedIn = True }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view >> toUnstyled
        , update = update
        }
