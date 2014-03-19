module ActionKid.Types where
import Graphics.Gloss.Interface.IO.Game
import ActionKid.Utils

data Attributes = Attributes {
                    ax :: Float,
                    ay :: Float,
                    ascaleX :: Float,
                    ascaleY :: Float,
                    avisible :: Bool,
                    azindex :: Int
}

defaultAttrs = Attributes 0.0 0.0 1.0 1.0 True 1

class MovieClip a where
    attrs :: a -> Attributes
    render :: a -> Picture

    -- these should be lenses so we can get and set
    x :: a -> Float
    x mc = ax . attrs $ mc
    y :: a -> Float
    y mc = ay . attrs $ mc
    scaleX :: a -> Float
    scaleX mc = ascaleX . attrs $ mc
    scaleY :: a -> Float
    scaleY mc = ascaleY . attrs $ mc
    visible :: a -> Bool
    visible mc = avisible . attrs $ mc
    zindex :: a -> Int
    zindex mc = azindex . attrs $ mc

    display :: (Int, Int) -> a -> Picture
    -- TODO change this from a fixed size to a statevar
    display (w, h) mc
      | visible mc = translate (x mc - (fromIntegral $ w // 2)) (y mc - (fromIntegral $ w // 2)) $ scale (scaleX mc) (scaleY mc) $ render mc
      | otherwise = blank
