diff --git a/benchmark/throughput/asio_from_chenshuo/handler_allocator.hpp b/benchmark/throughput/asio_from_chenshuo/handler_allocator.hpp
index be2ff03..b148323 100644
--- a/benchmark/throughput/asio_from_chenshuo/handler_allocator.hpp
+++ b/benchmark/throughput/asio_from_chenshuo/handler_allocator.hpp
@@ -13,6 +13,7 @@
 
 #include "asio.hpp"
 #include <boost/aligned_storage.hpp>
+#include <boost/core/noncopyable.hpp>
 
 // Class to manage the memory to be used for handler-based custom allocation.
 // It contains a single block of memory which may be returned for allocation
