{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

-- {-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.S3.GetBucketWebsite
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Returns the website configuration for a bucket.
module Network.AWS.S3.GetBucketWebsite
    (
    -- * Request
      GetBucketWebsite
    -- ** Request constructor
    , getBucketWebsite
    -- ** Request lenses
    , gbwrBucket

    -- * Response
    , GetBucketWebsiteOutput
    -- ** Response constructor
    , getBucketWebsiteOutput
    -- ** Response lenses
    , gbwoErrorDocument
    , gbwoIndexDocument
    , gbwoRedirectAllRequestsTo
    , gbwoRoutingRules
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Xml
import Network.AWS.S3.Types

newtype GetBucketWebsite = GetBucketWebsite
    { _gbwrBucket :: BucketName
    } deriving (Eq, Ord, Show, Generic)

-- | 'GetBucketWebsite' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gbwrBucket' @::@ 'BucketName'
--
getBucketWebsite :: BucketName -- ^ 'gbwrBucket'
                 -> GetBucketWebsite
getBucketWebsite p1 = GetBucketWebsite
    { _gbwrBucket = p1
    }

gbwrBucket :: Lens' GetBucketWebsite BucketName
gbwrBucket = lens _gbwrBucket (\s a -> s { _gbwrBucket = a })

instance ToPath GetBucketWebsite where
    toPath GetBucketWebsite{..} = mconcat
        [ "/"
        , toText _gbwrBucket
        ]

instance ToQuery GetBucketWebsite where
    toQuery = const "website"

instance ToHeaders GetBucketWebsite

data GetBucketWebsiteOutput = GetBucketWebsiteOutput
    { _gbwoErrorDocument         :: Maybe ErrorDocument
    , _gbwoIndexDocument         :: Maybe IndexDocument
    , _gbwoRedirectAllRequestsTo :: Maybe RedirectAllRequestsTo
    , _gbwoRoutingRules          :: [RoutingRule]
    } deriving (Eq, Ord, Show, Generic)

instance AWSRequest GetBucketWebsite where
    type Sv GetBucketWebsite = S3
    type Rs GetBucketWebsite = GetBucketWebsiteOutput

    request  = get
    response = const . xmlResponse $ \h x ->
        <$> x %| "ErrorDocument"
        <*> x %| "IndexDocument"
        <*> x %| "RedirectAllRequestsTo"
        <*> x %| "RoutingRules"
