Solving the cube blindfolded is a fun, medetative exercise. One can also use it to fool others into thinking one is special in some way. In reality, solving the cube blindfolded doesn't even require an above-average memory. All that's necessary is a solid understanding of the basic properties of the cube, and a fair bit of practice.

This article doesn't assume any knowledge of cube theory, but a reader might find some basic undergraduate math (e.g. group theory) useful.

# Preliminaries

## The Game

* I give you a cube in an arbitrary state
* You inspect the cube (the memorization phase)
* You don the blindfold
* You solve the cube (the execution phase)

We can try to optimize for different timing schemes.
That is, we could try to minimize the time of the memorization phase, the execution phase, or the game as a whole.
The method I present is tailored for the last scheme.

## Notation

We always consider the cube as having a fixed orientation.
Relative to a fixed orientation, the cube has 6 faces:

* `U`p
* `D`own
* `L`eft
* `R`ight
* `F`ront
* `B`ack

We can consider the cube as being composed of either pieces or stickers.
In the first model, the cube is thought of as a 3x3x3 grid of pieces, or "cubelets".
The pieces belong to one face, edge pieces belong to two faces, and corner pieces belong to three faces.
In other words, center pieces have one sticker, edge pieces have two stickers, and corner pieces have three stickers.
Pieces have both position (where on the grid they lie) and orientation (which faces their stickers lie on).
The 6 center pieces each have one orientation, the 12 edge pieces each have two orientations, and 8 corner pieces each have three orientations.

In the second model, each face contains 9 stickers locations.
A sticker location is either a "center" (at the center of the face), an "edge" (adjascent to the center by an edge), or a "corner" (adjascent to the center by a corner).
We specify sticker locations of each type differently:

* Center stickers are specified by the face they are on (e.g. `L` is the sticker location at the center of the `L` face).
* Edge stickers are specified by the face they are on, and then the face they boarder (e.g. `LU` is the sticker location on the `L` face adjascent the the `U` face).
* Corner stickers are specified by the face they are on, and then the two faces they boarder, in clockwise order around the corner clubelet (e.g. `LUF` is the sticker location on the `L` that boarders both the `U` and `F` faces).

We can modify the state of the cube by a variety of turns allowed by the its mechanics.
The most basic turns correspond to clockwise turns of the 6 faces.
For example, the turn denoted `U` is a clockwise turn of `U` face from the perspective of looking at that face from outside of the cube.

Double layer turns effect both a face and the layer behind that face.
They are denoted by the lower-case equivalent of their corresponding face turn.
For example, `u` denotes a simultaneous clockwise turn of the `U` face and the slice beneath it.

"Slice" turns each effect one of the center layers of the cube:

* `M`: Turn the "middle" slice behind the `L` face in the same direction as `L`
* `E`: Turn the "equator" slice behind the `D` face in the same direction as `D`
* `S`: Turn the "slice" slice behind the `F` face in the same direction as `F`

Finally, we can rotate the entire cube 90 degrees about the `x`, `y`, or `z` axes.
These turns are denoted by the corresponding axes.

To invert a turn, we append a `'`, which we pronounce "inverse" or "prime".
For example, `U'` denotes a counter-clockwise turn of the `U` face.
A numerical suffix denotes repetition of a turn.
For these simple turns, the only suffix that really makes sense is `2` (for example, `U3 = U'` and `U1337 = U`).
We can also invert and repeat sequences of moves.
For example, `(U F)3 = U F U F U F` and `(U F' R')' = R F U'`.

The widget below demonstrates the all of the turns mentioned so far.

<p style="text-align: center;"><iframe height="530px" width="300px" scrolling="no" frameborder="0" src="https://ruwix.com/widget/notation-3d/"></iframe></p>

## The Cube Group

The cube has state, and turns modify this state.
Two different sequences of moves can have the same effect on the cube's state (e.g. `U D F2 B F'` and `B F U' D U2`).
We can view such an "effect" on the cube's state in a variety of equivalent ways.
For example, we could consider an effect as a permutation of sticker locations, or as a permutation and re-orientation of peice locations.

These effects have a group structure under composition.
We shall refer to this as the cube group.
Common ways of denoting its elements are as permutations of stickers or sequences of turns.
For example, the sequence of turns `U` is equivalent to the sticker permutation `(UL UF UR UB)(LU FU RU BU)(ULB UFL URF UBR)(LBU FLU RFU BRU)(BUL LUF FUR RUB)`

The elements of the cube group act on the states of the cube.
However, in general, we will specify states of the cube *relative* to a particular "solved" state (for example, that in which the entire `U` face is white, the entire `F` face is green, etc.), so states really just correspond to group elements.
For example, the state specified by the sequence of turns `(U F)3 D'` is the state resulting from applying that sequence of turns to the solved state.

Interestingly, each face turn can be expressed in terms of the five others, so the cube group is generated by the turns `{U, D, L, R, F, x, y}`.

Here are a few important properties of the cube group (proofs are left out for now):

* Permutations of pieces are always even
* The orientations of any 7 corner pieces determine the orientation of the last
* The orientations of any 11 edge pieces determine the orientation of the last

However, informally, every element that could exist given these restrictions does.
Perhaps someday I'll add more precision to this statement, but its consequence is that the order of the cube group is:

$$|G| = \frac{8! 12! 3^7 2^{11}}{2} = 43,252,003,274,489,856,000$$

# Strategy Overview

<!-- # Executing 3-Cycles

## Commutators

## Conjugates

## Repeated Transpositions

# Twisting and Flipping

## Twisting

## Flipping

# Executing a Solution

## Corners

## Edges

# Memorization

# Larger Cubes

# Additional Resources -->

`IN PROGRESS`

In the meantime, check out this video in which a younger version of me solves a 4x4x4 cube blindfolded:

<div class="content-auto-resizable-iframe-full"><div>
<iframe src="https://www.youtube-nocookie.com/embed/UA_jAeGeYKY?rel=0&amp;showinfo=0" frameborder="0" allow="encrypted-media" allowfullscreen></iframe>
</div></div>

<p>&nbsp;</p>
