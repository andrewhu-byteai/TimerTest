#include <iostream>

#include "./event_loop.h"

#define WAIT_MICROSECONDS 1000 * 1000

void doTimer(std::shared_ptr<EventLoop> event_loop, uint64_t sta) {
  auto diff = Timer::nowNanoSecond() - sta;
  std::cout << "Time Interval:" << (diff) / 1000 << "(ms)" << " Expected:" << WAIT_MICROSECONDS << "(ms)" << std::endl;

  sta = Timer::nowNanoSecond();
  event_loop->SetTimer(WAIT_MICROSECONDS, [event_loop, sta]() {
    doTimer(event_loop, sta);
  }, false);
}

int main(int argc, char** argv) {
  if ((argc != 3) && (argc != 2)) {
    std::cerr << "Usage: event_loop_main use_asio_timer[0/1] enable_sleep[0/1]" << std::endl; 
    return 0;
  }
  auto use_asio_timer = std::stoi(argv[1]);
  auto enable_sleep = 0;
  if (argc == 3) {
    enable_sleep = std::stoi(argv[2]);
  }

  std::shared_ptr<EventLoop> event_loop(new EventLoop());
  event_loop->set_use_asio_timer(use_asio_timer);
  event_loop->set_enable_sleep(enable_sleep);
  event_loop->Start();

  auto sta = Timer::nowNanoSecond();
  event_loop->SetTimer(WAIT_MICROSECONDS, [event_loop, sta]() {
    doTimer(event_loop, sta);
  }, true);

  while (true) std::this_thread::sleep_for(std::chrono::microseconds(1000)); 
  return 0;
}

