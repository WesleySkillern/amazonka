{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.S3.GetBucketLogging
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Returns the logging status of a bucket and the permissions users have to
-- view and modify that status. To use GET, you must be the bucket owner.
--
-- /See:/ <http://docs.aws.amazon.com/AmazonS3/latest/API/GetBucketLogging.html AWS API Reference> for GetBucketLogging.
module Network.AWS.S3.GetBucketLogging
    (
    -- * Creating a Request
      GetBucketLogging
    , getBucketLogging
    -- * Request Lenses
    , getBucket

    -- * Destructuring the Response
    , GetBucketLoggingResponse
    , getBucketLoggingResponse
    -- * Response Lenses
    , grsLoggingEnabled
    , grsStatus
    ) where

import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response
import           Network.AWS.S3.Types
import           Network.AWS.S3.Types.Product

-- | /See:/ 'getBucketLogging' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'getBucket'
newtype GetBucketLogging = GetBucketLogging'
    { _getBucket :: BucketName
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'GetBucketLogging' smart constructor.
getBucketLogging :: BucketName -> GetBucketLogging
getBucketLogging pBucket_ =
    GetBucketLogging'
    { _getBucket = pBucket_
    }

-- | Undocumented member.
getBucket :: Lens' GetBucketLogging BucketName
getBucket = lens _getBucket (\ s a -> s{_getBucket = a});

instance AWSRequest GetBucketLogging where
        type Sv GetBucketLogging = S3
        type Rs GetBucketLogging = GetBucketLoggingResponse
        request = get
        response
          = receiveXML
              (\ s h x ->
                 GetBucketLoggingResponse' <$>
                   (x .@? "LoggingEnabled") <*> (pure (fromEnum s)))

instance ToHeaders GetBucketLogging where
        toHeaders = const mempty

instance ToPath GetBucketLogging where
        toPath GetBucketLogging'{..}
          = mconcat ["/", toBS _getBucket]

instance ToQuery GetBucketLogging where
        toQuery = const (mconcat ["logging"])

-- | /See:/ 'getBucketLoggingResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'grsLoggingEnabled'
--
-- * 'grsStatus'
data GetBucketLoggingResponse = GetBucketLoggingResponse'
    { _grsLoggingEnabled :: !(Maybe LoggingEnabled)
    , _grsStatus         :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'GetBucketLoggingResponse' smart constructor.
getBucketLoggingResponse :: Int -> GetBucketLoggingResponse
getBucketLoggingResponse pStatus_ =
    GetBucketLoggingResponse'
    { _grsLoggingEnabled = Nothing
    , _grsStatus = pStatus_
    }

-- | Undocumented member.
grsLoggingEnabled :: Lens' GetBucketLoggingResponse (Maybe LoggingEnabled)
grsLoggingEnabled = lens _grsLoggingEnabled (\ s a -> s{_grsLoggingEnabled = a});

-- | Undocumented member.
grsStatus :: Lens' GetBucketLoggingResponse Int
grsStatus = lens _grsStatus (\ s a -> s{_grsStatus = a});
