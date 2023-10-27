import XMonad
import XMonad.Config.Kde
import qualified XMonad.StackSet as W -- to shift and float windows

main = xmonad kde4Config
    { modMask = mod4Mask -- use the Windows button as mod
    , manageHook = manageHook kde4Config <+> myManageHook
    }

myManageHook = composeAll . concat $
    [ [ className   =? c --> doFloat           | c <- myFloats]
    , [ title       =? t --> doFloat           | t <- myOtherFloats]
    , [ className   =? c --> doF (W.shift "2") | c <- webApps]
    , [ className   =? c --> doF (W.shift "3") | c <- ircApps]
    ]
  where myFloats      = ["MPlayer", "Gimp"]
        myOtherFloats = ["alsamixer"]
        webApps       = ["Firefox-bin"] -- open on desktop 2
        ircApps       = ["Ksirc"]                -- open on desktop 3
