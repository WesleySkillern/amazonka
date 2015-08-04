{-# LANGUAGE BangPatterns      #-}
{-# LANGUAGE CPP               #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE RankNTypes        #-}

{-# OPTIONS_HADDOCK show-extensions #-}

-- |
-- Module      : Network.AWS.Free
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Defines the core DSL, logic and interpreters for AWS behaviour.
module Network.AWS.Free where

import           Control.Applicative
import           Control.Monad.Reader
import           Control.Monad.Trans.Free.Church
import           Data.Conduit                    (Source, yield)
import           Network.AWS.Pager
import           Network.AWS.Prelude
import           Network.AWS.Waiter
#if MIN_VERSION_free(4,12,0)
#else
import           Control.Monad.Catch
import           Control.Monad.Trans.Free        (FreeT (..))
#endif

data Command r where
    Send  :: (AWSSigner (Sg s), AWSRequest a)
          => Service s
          -> a
          -> (Rs a -> r)
          -> Command r

    Await :: (AWSSigner (Sg s), AWSRequest a)
          => Service s
          -> Wait a
          -> a
          -> (Rs a -> r)
          -> Command r

instance Functor Command where
    fmap f = \case
        Send  s   x k -> Send  s   x (fmap f k)
        Await s w x k -> Await s w x (fmap f k)

#if MIN_VERSION_free(4,12,0)
#else
instance MonadThrow m => MonadThrow (FreeT Command m) where
    throwM = lift . throwM

instance MonadCatch m => MonadCatch (FreeT Command m) where
    catch (FreeT m) f = FreeT $
        liftM (fmap (`catch` f)) m `catch` (runFreeT . f)
#endif

-- | Send a request, returning the associated response if successful.
--
-- /See:/ 'sendWith'
send :: (MonadFree Command m, AWSRequest a)
     => a
     -> m (Rs a)
send = sendWith id

-- | A variant of 'send' that allows modifying the default 'Service' definition
-- used to configure the request.
sendWith :: (MonadFree Command m, AWSSigner (Sg s), AWSRequest a)
         => (Service (Sv a) -> Service s)
         -> a
         -> m (Rs a)
sendWith f x = liftF $ Send (f (serviceOf x)) x id

-- | Transparently paginate over multiple responses for supported requests
-- while results are available.
--
-- /See:/ 'paginateWith'
paginate :: (MonadFree Command m, AWSPager a)
         => a
         -> Source m (Rs a)
paginate = paginateWith id

-- | A variant of 'paginate' that allows modifying the default 'Service' definition
-- used to configure the request.
paginateWith :: (MonadFree Command m, AWSSigner (Sg s), AWSPager a)
             => (Service (Sv a) -> Service s)
             -> a
             -> Source m (Rs a)
paginateWith f rq = go rq
  where
    go !x = do
        !y <- lift $ liftF (Send s x id)
        yield y
        maybe (pure ())
              go
              (page x y)

    !s = f (serviceOf rq)

-- | Poll the API with the supplied request until a specific 'Wait' condition
-- is fulfilled.
--
-- The response will be either the first error returned that is not handled
-- by the specification, or any subsequent successful response from the await
-- request(s).
--
-- /Note:/ You can find any available 'Wait' specifications under then
-- @Network.AWS.<ServiceName>.Waiters@ namespace for supported services.
--
-- /See:/ 'awaitWith'
await :: (MonadFree Command m, AWSRequest a)
      => Wait a
      -> a
      -> m (Rs a)
await = awaitWith id

-- | A variant of 'await' that allows modifying the default 'Service' definition
-- used to configure the request.
awaitWith :: (MonadFree Command m, AWSSigner (Sg s), AWSRequest a)
          => (Service (Sv a) -> Service s)
          -> Wait a
          -> a
          -> m (Rs a)
awaitWith f w x = liftF $ Await (f (serviceOf x)) w x id
