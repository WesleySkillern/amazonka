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
-- Module      : Network.AWS.DirectConnect.ConfirmPublicVirtualInterface
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Accept ownership of a public virtual interface created by another
-- customer.
--
-- After the virtual interface owner calls this function, the specified
-- virtual interface will be created and made available for handling
-- traffic.
--
-- /See:/ <http://docs.aws.amazon.com/directconnect/latest/APIReference/API_ConfirmPublicVirtualInterface.html AWS API Reference> for ConfirmPublicVirtualInterface.
module Network.AWS.DirectConnect.ConfirmPublicVirtualInterface
    (
    -- * Creating a Request
      ConfirmPublicVirtualInterface
    , confirmPublicVirtualInterface
    -- * Request Lenses
    , cVirtualInterfaceId

    -- * Destructuring the Response
    , ConfirmPublicVirtualInterfaceResponse
    , confirmPublicVirtualInterfaceResponse
    -- * Response Lenses
    , crsVirtualInterfaceState
    , crsStatus
    ) where

import           Network.AWS.DirectConnect.Types
import           Network.AWS.DirectConnect.Types.Product
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Container for the parameters to the ConfirmPublicVirtualInterface
-- operation.
--
-- /See:/ 'confirmPublicVirtualInterface' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cVirtualInterfaceId'
newtype ConfirmPublicVirtualInterface = ConfirmPublicVirtualInterface'
    { _cVirtualInterfaceId :: Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'ConfirmPublicVirtualInterface' smart constructor.
confirmPublicVirtualInterface :: Text -> ConfirmPublicVirtualInterface
confirmPublicVirtualInterface pVirtualInterfaceId_ =
    ConfirmPublicVirtualInterface'
    { _cVirtualInterfaceId = pVirtualInterfaceId_
    }

-- | Undocumented member.
cVirtualInterfaceId :: Lens' ConfirmPublicVirtualInterface Text
cVirtualInterfaceId = lens _cVirtualInterfaceId (\ s a -> s{_cVirtualInterfaceId = a});

instance AWSRequest ConfirmPublicVirtualInterface
         where
        type Sv ConfirmPublicVirtualInterface = DirectConnect
        type Rs ConfirmPublicVirtualInterface =
             ConfirmPublicVirtualInterfaceResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ConfirmPublicVirtualInterfaceResponse' <$>
                   (x .?> "virtualInterfaceState") <*>
                     (pure (fromEnum s)))

instance ToHeaders ConfirmPublicVirtualInterface
         where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("OvertureService.ConfirmPublicVirtualInterface" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ConfirmPublicVirtualInterface where
        toJSON ConfirmPublicVirtualInterface'{..}
          = object
              ["virtualInterfaceId" .= _cVirtualInterfaceId]

instance ToPath ConfirmPublicVirtualInterface where
        toPath = const "/"

instance ToQuery ConfirmPublicVirtualInterface where
        toQuery = const mempty

-- | The response received when ConfirmPublicVirtualInterface is called.
--
-- /See:/ 'confirmPublicVirtualInterfaceResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'crsVirtualInterfaceState'
--
-- * 'crsStatus'
data ConfirmPublicVirtualInterfaceResponse = ConfirmPublicVirtualInterfaceResponse'
    { _crsVirtualInterfaceState :: !(Maybe VirtualInterfaceState)
    , _crsStatus                :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'ConfirmPublicVirtualInterfaceResponse' smart constructor.
confirmPublicVirtualInterfaceResponse :: Int -> ConfirmPublicVirtualInterfaceResponse
confirmPublicVirtualInterfaceResponse pStatus_ =
    ConfirmPublicVirtualInterfaceResponse'
    { _crsVirtualInterfaceState = Nothing
    , _crsStatus = pStatus_
    }

-- | Undocumented member.
crsVirtualInterfaceState :: Lens' ConfirmPublicVirtualInterfaceResponse (Maybe VirtualInterfaceState)
crsVirtualInterfaceState = lens _crsVirtualInterfaceState (\ s a -> s{_crsVirtualInterfaceState = a});

-- | Undocumented member.
crsStatus :: Lens' ConfirmPublicVirtualInterfaceResponse Int
crsStatus = lens _crsStatus (\ s a -> s{_crsStatus = a});
