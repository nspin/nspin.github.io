---
template: templates/basic.html
title: Unikernel Resources
...

# Unikernel Resources

## Introduction

I can't think of a good single sentence definition of the word "unikernel". There are a few different ways to think about what a unikernel is, and I think it's best to arrive at an understanding after gathering the necessary background.

However, just because that's such an unsatisfying introduction, here are a few single-sentence approximations of what a unikernel is, none of which capture the whole picture:

- A unikernel is a “library operating system”. That is, it's a library that serves as the interface between application code and the metal, thus, in some sense, serving as an operating system.
- A unikernel is an application that interfaces directly with the metal. That is, an application that runs without an operating system.
- A unikernel is to the hypervisor as a userspace process is to a microkernel.

## Kernels in general

Before anything else, one must understand the basic activities of kernel code, in the "usual" sense of a kernel, running on actual bare metal (no hypervisor - but we haven't talked about hypervisors yet). That is, system code running at a privileged execution level (whatever that means for the architecture at hand: ring 0 for x86-64, EL1 for Arm, etc.):

- What environment is provided to it by the hardware?
- What does it need to do to set itself up?
- What abstractions does it provide to its “clients” (userspace programs)?
    - Specifically, what environment does it provide to its clients?
    - How does it provide that environment?

Modern architectures (x86*, Arm*-A) are quite complicated (esp. the former). The best to approach these questions that I've found is by starting with a simple architecture. The Arm-v{7,8}-M architectures lack virtual memory (an important part of the environment a kernel provides to its clients), but studying them is a great way to approach all of this.

My recommendation is to learn about the Cortex-M3 processor (implements Arm-v7-M), then learn about virtual memory and page tables, and then learn about the the Linux boot process. I think that this would provide a good foundation.

Here are some resources:

#### Cortex-M3

[The Definitive Guide to ARM Cortex-M3 and Cortex-M4 Processors](https://www.amazon.com/Definitive-Guide-Cortex%C2%AE-M3-Cortex%C2%AE-M4-Processors/dp/0124080820):
A very well-written book. I could only find old editions online, but I own a hard copy and would be more than happy to lend it out.

#### Virtual Memory

[Computer Organization and Design](http://ac.aua.am/Arm/Public/2017-Spring-Computer-Organization/Textbooks/ComputerOrganizationAndDesign5thEdition2014.pdf):
The book from Org and Arch at Carleton. This book has lots of good info on the hardware-software interface, including paging and virtual memory.

<https://www.akkadia.org/drepper/cpumemory.pdf>:
This paper has a good section on page tables in x86.

#### Linux Boot Process

<https://en.wikipedia.org/wiki/Linux_startup_process>

<https://www.ibm.com/developerworks/library/l-linuxboot/>

<https://www.ibm.com/developerworks/library/l-initrd/>

(Recursive) Google search

## Microkernels

There many ways to design an operating system kernel. Linux is a "monolithic kernel", meaning that the kernel itself (the program/trusted code that runs in a privileged execution mode) is big and contains all of the logic and drivers it needs. I'd recommend checking out the Linux “kernel module” system.

In the microkernel design, code running in kernel space is kept to a minimum. Drivers, for example, run as userspace programs. This design has many benefits, including modularity and security. Device drivers are very complicated and are often not written by those who work on the kernel itself, and they are usually the most vulnerable components of an operating system. Having them run in userspace reduces the kernel's exposure to vulnerabilities in drivers.

There are at least two microkernels worth looking at:

- In the early days, Linux and Minix were battling for a spot in the mainstream. Minix was (and still is) a microkernel, and is worth reading about.
- L4 is a specification for a microkernel. It has a "formally verified" implementation (SeL4), which is very cool, and illustrates a security benefit of modularity (the core you have to worry about is smaller, so you can do crazy things like formally verify it).

Checking out these microkernels, along with a Google search of “microkernel” should do the trick. The ideas here aren't too crazy with a good foundation from the last section.

## Hypervisors

The essential role of an operating system kernel is to provide an application with access to hardware resources. One way to view an application is a collection of cooperating threads of execution. Here, I mean thread of execution in the hardware sense - a context, the thing you context switch. In a typical deployment of an application running on Linux, you

## Unikernels

p
