/*!
 * \file event_loop.cc
 */
#include "./event_loop.h"

#include <iostream>

void EventLoop::Start() {
  thread_.reset(new std::thread([this](){ this->DoEventLoop();  }));
}

void EventLoop::DoEventLoop() {
  try {
    if (use_asio_timer_) {
      io_context_.run();
    } else {
      /// Spin running
      while (true) {
        auto event_count = io_context_.poll();
        auto timer_count = 0;
        auto now_time = Timer::nowNanoSecond();
        while (!timer_.empty()) {
          auto& item = timer_.top();
          if (now_time >= item.timestamp) {
            item.func();
            timer_.pop();
            timer_count++;
          } else {
            break;
          }
        }
        if (!event_count && !timer_count) {
          if (enable_sleep_) {
            std::this_thread::sleep_for(std::chrono::microseconds(1));
          }
        }
      }
    }
  } catch (std::exception const& e) {
    std::cerr << "exception in EventLoop " << e.what();
  }
}

void EventLoop::SetTimer(int64_t delayMicroseconds, std::function<void()> handler, bool async) {
  if (use_asio_timer_) {
    boost::asio::post(io_context_, [this, delayMicroseconds, handler]() {
      this->timerPtr_.reset(new boost::asio::high_resolution_timer(this->io_context_, boost::asio::chrono::microseconds(delayMicroseconds)));
      this->timerPtr_->async_wait([this, handler](const boost::system::error_code& ec) {
        if (ec) {}
        else {
          handler();
        }
      });
    });
  } else {
    auto deadline = Timer::nowNanoSecond() + delayMicroseconds * 1000;
    if (async) {
      boost::asio::post(io_context_, [this, deadline, handler]() {
                          this->timer_.setTimer(deadline, handler);
                        });
    } else {
      timer_.setTimer(deadline, handler);
    }
  }
}
