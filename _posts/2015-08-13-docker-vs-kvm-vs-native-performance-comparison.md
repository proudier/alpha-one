---
layout: post
title: Docker vs KVM vs Native performance
tags:
- Virtualization
- Docker
- Kvm
---

The original paper can be found [there](http://domino.research.ibm.com/library/cyberdig.nsf/papers/0929052195DD819C85257D2300681E7B/). Below are the points I would remember:

Docker induces no significant overhead on CPU nor memory usage,  compared to a native execution (worse observation: -4%; 0% on all others)

Using Docker NAT is not cheap. It almost doubles the latency and has a measurable CPU overhead (adds 0.5 cpu-cycle per byte out of 2 for transmission and out of 2.25 for reception).

Using the host’s Net namespace restores performance to the native level; interesting only if your use-case doesn’t require network isolation.

Using Volume storage has no impact on pure block I/O performance (sequential throughput, random access throughput and latency).

Using AUFS (storing inside containers) is expensive: performance is 20% inferior compared to Volume (see fig. 10 MySQL transactions/seconds).

Redis and MySQL tests reveal Docker (without NAT nor AUFS) achieve almost identical performances than the native system.

On the overall, Docker equals of exceed KVM performance.

KVM’s default configuration hide the host hardware’s topology to the guess OS&Apps, hindering the auto-tuning of some advanced libraries (eg. [Intel MKL](https://software.intel.com/en-us/intel-mkl))