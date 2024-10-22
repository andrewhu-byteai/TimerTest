/*!
 * \file event_loop.h
 */
#pragma once

#include <boost/asio.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <boost/asio/steady_timer.hpp>
#include <boost/optional.hpp>
#include "boost/beast/core.hpp"
#include "boost/beast/http.hpp"
#include "boost/beast/ssl.hpp"
#include "boost/beast/version.hpp"
#include "boost/asio/high_resolution_timer.hpp"

#include <memory>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <thread>

#include "./timer.h"

namespace ba = boost::asio;
namespace bi = ba::ip;

namespace beast = boost::beast;
namespace http = beast::http;
namespace net = boost::asio;
namespace ssl = net::ssl;
using tcp = net::ip::tcp;

class EventLoop : public std::enable_shared_from_this<EventLoop> {
 public:
  virtual void Start();

  void set_use_asio_timer(bool use_asio_timer) { use_asio_timer_ = use_asio_timer; }
  void set_enable_sleep(bool enable_sleep) { enable_sleep_ = enable_sleep; }

  void SetTimer(int64_t delayMicroseconds, std::function<void()> handler, bool async = true);

 protected:
  void DoEventLoop();

  std::shared_ptr<boost::asio::high_resolution_timer> timerPtr_; 
  bool use_asio_timer_ = false;
  bool enable_sleep_ = false;
  ba::io_context io_context_;
  std::shared_ptr<std::thread> thread_;
  Timer timer_;
};
