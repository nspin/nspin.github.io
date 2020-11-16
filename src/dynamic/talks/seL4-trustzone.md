---
template: templates/basic.html
title: 'seL4 + TrustZone: Spanning both worlds'
...

<div style="text-align: center;">

## seL4 + TrustZone: Spanning both worlds {.top-line-flush}

[seL4 Summit 2020](https://www.sel4-us.org/summit2020/)

_Nick Spinale_

[[slides]](./sel4-trustzone.pdf)
[recording coming soon]

</div>

### Abstract

<!-- _Abstract._ -->

Arm TrustZone partitions a SoC’s hardware resources into two worlds: the
 Secure World for the security subsystem, and the Normal World for
everything else. By configuring seL4 to span both worlds, we obtain a
firmware design with greater assurance and flexibility
than traditional secure monitor firmware. Such a configuration will
become even more interesting and useful in the coming months as the
Armv8.4-SecEL2 extension for secure virtualization becomes available in
silicon.

To both motivate and demonstrate such a firmware design, we present
IceCap, an experimental platform from Arm Research for virtualization
and general-purpose confidential compute, based on seL4. By implementing
 the design introduced above, IceCap binds hardware
isolation boundaries enforced by TrustZone with software isolation
boundaries enforced by seL4 to fit a strong threat model without
sacrificing simplicity of design and implementation. Our preliminary
results suggest that this world-spanning configuration of
seL4 on AArch64 is worth the attention of the seL4 community.

In addition to the firmware design described above, IceCap also features
a dynamic adaptation of CapDL, a seL4 userland written entirely in the
Rust programming language, and ultra-lightweight virtualization with a
virtual machine monitor consisting of <1kLOC.
