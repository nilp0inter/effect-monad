{-# LANGUAGE TypeFamilies, EmptyDataDecls, TypeOperators #-}

module Control.Effect.Counter(Z, S, Counter, tick, (:+)) where

import Control.Effect
import Prelude hiding (Monad(..))

data Z
data S n

data Counter n a = Counter { forget :: a }

type family n :+ m 
type instance n :+ Z     = n
type instance n :+ (S m) = S (n :+ m)

instance Effect Counter where
    type Inv Counter n m = ()
    type Unit Counter = Z
    type Plus Counter n m = n :+ m

    return a = Counter a
    (Counter a) >>= k = Counter . forget $ k a

tick :: a -> Counter (S Z) a
tick x = Counter x

-- instance Subeffect Counter s t where
    