# TimerTest

* 编译

```
./build.sh
```

* 运行

 * io\_context.run()运行模式

```
./build/core/event_loop_main 1
```

 * Spin运行模式,不Sleep

 ```
./build/core/event_loop_main 0 0
 ```


 * Spin运行模式,Sleep

 ```
 ./build/core/event_loop_main 0 1
 ```
