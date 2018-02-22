---
layout: post
title: Advanced ExecutorService tutorial
categories:
- Development
tags:
- Java
- Concurrency
comments: []
---

A friend of mine brought to my attention to the fact that many tutorial about Java concurrent programming introduce the Executor Interfaces and its descendants but fails to show its usage in a real-life scenario. This article is my attempt to present the reader with a complex case where the production of the tasks to run, their execution and the consumption of the results constitute a dynamic system.

It is assumed that the reader is already familiar with Java [Thread](https://docs.oracle.com/javase/8/docs/api/java/lang/Thread.html), [Runnable](https://docs.oracle.com/javase/8/docs/api/java/lang/Runnable.html), [Future](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/Future.html) and [ExecutorService](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ExecutorService.html).

# Base entities

At its core, the system is working on three classes of objects:
- __Task__: the algorithm that is to be parallelized; it can be a mathematical computation or a routine with blocking calls (database queries, disk or network i/o, etc.)
- __TaskParameter__: the input data fed to the Task; as it can become a complex structure in real-life, having a dedicated class keep things clean
- __TaskResult__: the output produced by the Task; just like TaskParameter, having a dedicated class contributes to code maintainability

The algorithm constituting the Task can require a large amount of memory. Thus, separating the TaskResult from the Task optimizes memory usage: as soon as a task is completed, the corresponding Task object can be deleted and its memory reclaimed by the GC. Only the TaskResult is kept in memory.

# Workflow

The overall workflow has four steps:
- Craft a TaskParameter
- Create a Task associated to that TaskParameter
- Run the Task
- Do something with the TaskResult

In simple scenarios, the TaskParameters and the Tasks are created at the launch of the program, then the Tasks would be concurrently executed in threads. But in a real-life scenarios, the creation of TaskParameters and Tasks is concurrent with the execution of Tasks. Also, the TaskResults are to be used somehow: written to disk or written to a socket for example.

# Entities

A complex system would be composed of:
- A TaskProducer: create TaskParameter and Task.
- A TaskQueue: where the TaskProducer put tasks ready for execution (sometimes called CompletionQueue in the doc)
- An Executor: retrieve Task from the queue and execute them concurrently
- A ResultQueue
- A ResultConsumer: retrieve the TaskResult from the ResultQueue and do something with it.

As one can imagine, TaskProducer and ResultConsumer are specific to the reader's project. They can be POJO. They can be listening on a socket, writing to disk, or whatever your project requires. For the rest, the JDK offers the necessary building blocks:

- [ThreadPoolExecutor](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ThreadPoolExecutor.html) executes the tasks concurrently, in a dedicated pool of threads.
- [ExecutorCompletionService](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ExecutorCompletionService.html) retrieves the Tasks from the TaskQueue and feed them to the ThreadPoolExecutor.
- The short ExecutorCompletionService constructor uses a [LinkedBlockingQueue](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/LinkedBlockingQueue.html) as the TaskQueue.
- For the Tasks to be handled by ThreadPoolExecutor, Task must implements Callable.

# Sample implementation

To illustrate this design, I've shared [a sample project on GitHub](https://github.com/proudier/blog-example/tree/master/ExecutorCompletionService/src/net/pierreroudier/blog)

Noteworthy items:
- TaskParameter and TaskResult are POJO with a few attributes.
- Task computation of a factorial for the number given in TaskParameter.
- TaskProducer creates a new Task periodically and submit it.
- TaskConsumer retrieve and display the result.
- To present a generic pattern, TaskProducer and ResultConsumer implements Runnable, so they can be executed concurrently as well.

Here is the most important piece of code:

```java
// in Main.java
ExecutorService es = Executors.newFixedThreadPool(THREAD_COUNT);
ExecutorCompletionService<TaskResult> ecs = new ExecutorCompletionService<TaskResult>(es);
```

TaskProducers call ExecutorCompletionService.[submit](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ExecutorCompletionService.html#submit-java.util.concurrent.Callable-) to push new tasks:

```java
// in TaskProducer.java (edited for clarity)
TaskParameter param = new TaskParameter( &hellip; );
Task computation = new Task(param);
ecs.submit(computation);
```

ResultConsumer call ExecutorCompletionService.[take](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ExecutorCompletionService.html#take--) to retrieve the results:

```java
// in ResultConsumer.java (edited for clarity)
Future<TaskResult> future = ecs.take();
future.get()
```

Finally, to bootstrap the system:

```java
// in Main.java
new Thread(new TaskProducer(ecs, 2f)).start();
new Thread(new ResultConsumer(ecs)).start();
```

The rest of the code is pretty self-explanatory ;)


Enjoy!

