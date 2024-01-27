# Learning Elm language

This is a simple documentation for the basic concepts on Elm and it's concepts including the basic concepts of functional programming.

## Synthax

- Variables are declared directly and can store any ~TYPE~ of value (including expressions that evaluate to a value): functions, string, number, boolean, character, Int, Float
- functions are declared by `variableName ...parameters = functionBody`

### Conditionals

- if, else if, or else are written without enclosed brackets is an expression that evaluates to a value and can be stored in a variable. e.g `crazyStuff = if 4 > 3 then "Wow" else if 3 > 4 then "Sshh" else "Wamm" ` . Where `crazyStuff ` is a variable that represents an expression that evaluates to a String type value.

### Expressions and Priority

it is worthy to note that functional programming is heavily based on mathmatical principles, therefore the rules of BODMAS are applicaple.

- There is an order to the priority of operations executed in an expression/ equation.
- Examples of operators are `+`, `-`, `*`, `/`, `%`, `>>`, `<<`, `//` without being ordered by priority.

### Elm Functions

Functions in Elm are non-ceremonious, in fact they are almost equivalent to declaring any other variable (Almost only because of synthax difference).

- Declaring a function looks like this:
  foo params =
  if bar == 1 then
  "bar"
  else if baz == 2 then
  "baz"
  else "foo bar baz"
- Functions MUST return a value: No ridiculousness as a Void function, NEVER!

- _Partial Functions_ are functions called without complete arguments. These functions can be saved in a variable and called with the remaining arguments. e.g. `subtract a b = a - b` `subtractFrom3 = subtract 3` `removedFrom3 = subtractFrom3 1`. in this case, `subtractFrom3` is a partial function that can be called with the remaining arguments in subtract.
- Partial functions can be chained together
  e.g `subtract 6 (subtractFrom3 (subtract 5 4))` == 4
- function chaining like the above example can become dirty if you had to chain more partials together. So Elm gracefully supports `|>` and `<|` the forward and backward "pipe operators" that lets us rewrite the previous example more gracefully.
  e.g `   value = 
      subtract 5 4 
          |> subtractFrom3 
          |> subtract 6
|`subtract 6 <| subtractFrom3 <| substract 5 4` == 4

#### Elm Let expression

- This expression is used to save and use variables locally in an elm finction. e.g:
  let
  valueFive
  = 5
  valueFour
  = 4
  in
  subract valueFive valueFour

### Elm Types

I realised Elm has Types that have Types _*scratches head*_

## Basic structure for a sandboxed (standalone) styled elm application

    module Main exposing (..)

    import Browser
    import Css exposing (..)
    import Html.Styled exposing (..)
    import Html.Styled.Attributes exposing (..)
    import Html.Styled.Events exposing (onClick, onInput)

    {-
        This is a multiline comment
    -}
    type alias Model =
        { name : String --this is an inline comment
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
