/*!
 * \file timer.h
 */
#pragma once

#include <chrono>
#include <functional>
#include <vector>
#include <queue>

class Timer {
 public:
  struct TimerItem {
    TimerItem(int64_t timestamp, std::function<void()> func) : timestamp(timestamp), func(func) { }

    uint64_t timestamp;
    std::function<void()> func;
  };
  struct TimerItemCmp {
    bool operator()(const TimerItem& a, const TimerItem& b) {
      return a.timestamp > b.timestamp;
    }
  };
  static int64_t nowNanoSecond() {
    auto now =  std::chrono::high_resolution_clock::now();
    auto duration = now.time_since_epoch();
    return std::chrono::duration_cast<std::chrono::nanoseconds>(duration).count();
  }

  void setTimer(uint64_t deadline, std::function<void()> func) {
    TimerItem item(deadline, func);
    items_.push(item);
  }

  const TimerItem& top() const {
    return items_.top();
  }

  bool empty() const {
    return items_.empty();
  }

  void pop() {
    items_.pop();
  }

 protected:
  std::priority_queue<TimerItem, std::vector<TimerItem>, TimerItemCmp> items_;
};
