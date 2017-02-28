module Lib
    ( someFunc
    ) where

import Foreign.C.Types ( CInt(..) )
import Foreign.Ptr ( FunPtr )

someFunc :: IO ()
someFunc = do
  a <- add 1 2
  print a
  asyncAdd 3 4 (\a -> print a)
  asyncTask $ print "called!"


-- int add(int x, int y);

foreign import ccall "sample.h add"
  c_add :: CInt -> CInt -> IO CInt

add :: Int -> Int -> IO Int
add x y = do
  a <- c_add (fromIntegral x) (fromIntegral y)
  return (fromIntegral a)


-- void asyncAdd(int x, int y, void (*callback)(int));

foreign import ccall "wrapper"
  mkAsyncAddCallback :: (CInt -> IO ()) -> IO (FunPtr (CInt -> IO ()))

foreign import ccall "sample.h asyncAdd"
  c_asyncAdd :: CInt -> CInt -> FunPtr (CInt -> IO ()) -> IO ()

asyncAdd :: Int -> Int -> (Int -> IO ()) -> IO ()
asyncAdd x y callback = do
  cb <- mkAsyncAddCallback (callback . fromIntegral)
  c_asyncAdd (fromIntegral x) (fromIntegral y) cb


-- void asyncTask(void (*callback)(void));

foreign import ccall "wrapper"
  mkAsyncTaskCallback :: IO () -> IO (FunPtr (IO ()))

foreign import ccall "sample.h asyncTask"
  c_asyncTask :: FunPtr (IO ()) -> IO ()

asyncTask :: IO () -> IO ()
asyncTask callback = do
  cb <- mkAsyncTaskCallback callback
  c_asyncTask cb

