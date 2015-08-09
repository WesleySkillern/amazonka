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
-- Module      : Network.AWS.RDS.DeleteDBSnapshot
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Deletes a DBSnapshot. If the snapshot is being copied, the copy
-- operation is terminated.
--
-- The DBSnapshot must be in the @available@ state to be deleted.
--
-- /See:/ <http://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DeleteDBSnapshot.html AWS API Reference> for DeleteDBSnapshot.
module Network.AWS.RDS.DeleteDBSnapshot
    (
    -- * Creating a Request
      DeleteDBSnapshot
    , deleteDBSnapshot
    -- * Request Lenses
    , ddbsDBSnapshotIdentifier

    -- * Destructuring the Response
    , DeleteDBSnapshotResponse
    , deleteDBSnapshotResponse
    -- * Response Lenses
    , ddbsrsDBSnapshot
    , ddbsrsStatus
    ) where

import           Network.AWS.Prelude
import           Network.AWS.RDS.Types
import           Network.AWS.RDS.Types.Product
import           Network.AWS.Request
import           Network.AWS.Response

-- |
--
-- /See:/ 'deleteDBSnapshot' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ddbsDBSnapshotIdentifier'
newtype DeleteDBSnapshot = DeleteDBSnapshot'
    { _ddbsDBSnapshotIdentifier :: Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DeleteDBSnapshot' smart constructor.
deleteDBSnapshot :: Text -> DeleteDBSnapshot
deleteDBSnapshot pDBSnapshotIdentifier_ =
    DeleteDBSnapshot'
    { _ddbsDBSnapshotIdentifier = pDBSnapshotIdentifier_
    }

-- | The DBSnapshot identifier.
--
-- Constraints: Must be the name of an existing DB snapshot in the
-- @available@ state.
ddbsDBSnapshotIdentifier :: Lens' DeleteDBSnapshot Text
ddbsDBSnapshotIdentifier = lens _ddbsDBSnapshotIdentifier (\ s a -> s{_ddbsDBSnapshotIdentifier = a});

instance AWSRequest DeleteDBSnapshot where
        type Sv DeleteDBSnapshot = RDS
        type Rs DeleteDBSnapshot = DeleteDBSnapshotResponse
        request = postQuery
        response
          = receiveXMLWrapper "DeleteDBSnapshotResult"
              (\ s h x ->
                 DeleteDBSnapshotResponse' <$>
                   (x .@? "DBSnapshot") <*> (pure (fromEnum s)))

instance ToHeaders DeleteDBSnapshot where
        toHeaders = const mempty

instance ToPath DeleteDBSnapshot where
        toPath = const "/"

instance ToQuery DeleteDBSnapshot where
        toQuery DeleteDBSnapshot'{..}
          = mconcat
              ["Action" =: ("DeleteDBSnapshot" :: ByteString),
               "Version" =: ("2014-10-31" :: ByteString),
               "DBSnapshotIdentifier" =: _ddbsDBSnapshotIdentifier]

-- | /See:/ 'deleteDBSnapshotResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ddbsrsDBSnapshot'
--
-- * 'ddbsrsStatus'
data DeleteDBSnapshotResponse = DeleteDBSnapshotResponse'
    { _ddbsrsDBSnapshot :: !(Maybe DBSnapshot)
    , _ddbsrsStatus     :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DeleteDBSnapshotResponse' smart constructor.
deleteDBSnapshotResponse :: Int -> DeleteDBSnapshotResponse
deleteDBSnapshotResponse pStatus_ =
    DeleteDBSnapshotResponse'
    { _ddbsrsDBSnapshot = Nothing
    , _ddbsrsStatus = pStatus_
    }

-- | Undocumented member.
ddbsrsDBSnapshot :: Lens' DeleteDBSnapshotResponse (Maybe DBSnapshot)
ddbsrsDBSnapshot = lens _ddbsrsDBSnapshot (\ s a -> s{_ddbsrsDBSnapshot = a});

-- | Undocumented member.
ddbsrsStatus :: Lens' DeleteDBSnapshotResponse Int
ddbsrsStatus = lens _ddbsrsStatus (\ s a -> s{_ddbsrsStatus = a});
