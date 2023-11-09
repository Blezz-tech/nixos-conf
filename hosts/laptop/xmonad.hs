import XMonad

main = do 
  xmonad $ def
    { terminal = "alacritty"
    , nodNask = mod4Mask
    , borderWidth = 3
    }
