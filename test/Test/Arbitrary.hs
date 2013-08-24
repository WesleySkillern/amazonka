{-# OPTIONS_GHC -fno-warn-orphans #-}

-- Module      : Test.Arbitrary
-- Copyright   : (c) 2013 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Test.Arbitrary where

import           Control.Applicative
import           Data.ByteString       (ByteString)
import qualified Data.ByteString.Char8 as BS
import           Data.Time
import           Test.QuickCheck

instance Arbitrary ByteString where
    arbitrary = fmap BS.pack . listOf1 $ oneof
        [ choose ('\48', '\57')
        , choose ('\65', '\90')
        , choose ('\97', '\122')
        ]

instance Arbitrary UTCTime where
    arbitrary = flip UTCTime 0 <$> arbitrary

    shrink ut@(UTCTime day dayTime) =
        [ut { utctDay     = d' } | d' <- shrink day    ] ++
        [ut { utctDayTime = t' } | t' <- shrink dayTime]

instance Arbitrary Day where
    arbitrary = ModifiedJulianDay <$> (2000 +) <$> arbitrary
    shrink    = (ModifiedJulianDay <$>) . shrink . toModifiedJulianDay

instance Arbitrary DiffTime where
    arbitrary = arbitrarySizedFractional
    shrink    = shrinkRealFrac
