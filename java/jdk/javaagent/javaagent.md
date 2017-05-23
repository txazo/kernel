#### JavaAgent

* 实现方法

```
public static void premain(String agentArgs);
public static void premain(String agentArgs, Instrumentation inst);
```

* 打jar包，MANIFEST.MF包含Premain-Class

* `java -javaagent:jarpath[=options]`

#### JavaAgent实现

* create_vm，启动虚拟机 // hotspot/src/share/vm/runtime/thread.cpp
* create_vm_init_agents，初始化agent，调用Agent_OnLoad() // hotspot/src/share/vm/runtime/thread.cpp
* Agent_OnLoad，加载agent // jdk/src/share/instrument/InvocationAdapter.c
* createNewJPLISAgent，创建新的JPLISAgent // jdk/src/share/instrument/JPLISAgent.c
* initializeJPLISAgent，初始化JPLISAgent，注册回调事件eventHandlerVMInit() // jdk/src/share/instrument/JPLISAgent.c
* eventHandlerVMInit，执行回调事件 // jdk/src/share/instrument/InvocationAdapter.c
* processJavaStart，创建Instrumentation实例(sun/instrument/InstrumentationImpl) // jdk/src/share/instrument/JPLISAgent.c
* startJavaAgent，启动Java代理 // jdk/src/share/instrument/JPLISAgent.c
* invokeJavaAgentMainMethod，调用Java代理 // jdk/src/share/instrument/JPLISAgent.c
* 调用sun.instrument.InstrumentationImpl的loadClassAndCallPremain()方法
* 调用`Premain-Class`的premain()方法
