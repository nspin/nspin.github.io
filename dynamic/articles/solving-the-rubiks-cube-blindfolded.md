---
template: templates/article.html
title: Solving the Rubik's Cube Blindfolded
desc: A math-based explanation from scratch.
date: 2018-02-02
has_math: true
...

Solving the cube blindfolded is a meditative exercise. Contrary to what you might expect, it doesn't even require an above-average memory. All that's necessary is a solid understanding of the basic properties of the cube, and some practice.

This article doesn't assume any knowledge of cube theory, but a reader will find some basic undergraduate math (e.g. group theory) useful.

Furthermore, this article is not a tutorial, but rather an in-depth exploration.

## Preliminaries

### The Game

* I give you a cube in an arbitrary state
* You inspect the cube (the *memorization* phase)
* You don the blindfold
* You solve the cube (the *execution* phase)

It's that simple.

### Notation

The cube has 6 faces:

* `U`p
* `D`own
* `L`eft
* `R`ight
* `F`ront
* `B`ack

Each face contains 9 stickers locations.
A sticker location is either a center (at the center of the face), an edge (adjascent to the center by an edge), or a corner (adjascent to the center by a corner).
We specify sticker locations of each type differently:

* Center stickers are specified by the face they lie on (e.g. `L` is the sticker location at the center of the `L` face).
* Edge stickers are specified by the face they lie on, and then the face they boarder (e.g. `LU` is the sticker location on the `L` face adjascent the the `U` face).
* Corner stickers are specified by the face they lie on, and then the two faces they boarder, in clockwise order around the corner piece (e.g. `LUF` is the sticker location on the `L` that boarders both the `U` and `F` faces).

The cube is composed of 26 piece locations.
Center piece locations contain one sticker location, edges two, and corners three.
One sticker location on each piece location is designated as the primay sticker location, which we use to specify that piece location.
Primary sticker locations are determined as follows:

* Centers: the only sticker location
* Edges: the sticker location on the `U` or `D` face if such a sticker location exists, or the sticker location on the `F` or `B` face otherwise
* Corners: the sticker location on the `U` or `D` face

We can modify the state of the cube by the turns its mechanism permits.
The most basic turns correspond to the 6 faces.
We denote the clockwise turn of a face by the name of the face itself.
For example, the turn denoted `U` is a clockwise turn of `U` face from the perspective of looking at that face from outside of the cube.

We also consider rotations of the entire cube about its axes as modifying the its state.
We denote the clockwise rotations about the `x`, `y`, and `z` axes in the directions of `R`, `U`, and `F` respectively as `x`, `y`, and `z`.

To invert a turn, we append a `'`, which we pronounce "inverse" or "prime".
For example, `U'` denotes a counter-clockwise turn of the `U` face.
A numerical suffix denotes repetition of a turn.
We can also invert and repeat sequences of turns.
For example, `x' (U F)3 = x' U F U F U F` and `(U F' z R')' = R z' F U'`.

I will mention a few additional turns, but their mechanics, along with those already mentioned, are best observed in the widget below.

Double layer turns effect both a face and the layer behind that face. They are denoted by the lower-case equivalent of their corresponding face turn. For example, `u` denotes a simultaneous clockwise turn of the `U` face and the layer beneath it.

Slice turns just effect an inner layer:

* `M`: Turn the *middle* layer behind the `L` face in the same direction as `L`
* `E`: Turn the *equator* layer behind the `D` face in the same direction as `D`
* `S`: Turn the *slice* layer behind the `F` face in the same direction as `F`

<p style="text-align: center;"><iframe height="530px" width="300px" scrolling="no" frameborder="0" src="https://ruwix.com/widget/notation-3d/"></iframe></p>

The effects of certain turns can be achieved by combinations of different turns. For example, `M = x' L' R`.
It is not hard to see how `z` can be written in terms of `x` and `y`.
Furthermore, it is both interesting and non-obvious that any face turn can be written in terms of the five others.
So, the effect of any sequence of moves can be achieved with a sequence of turns drawn only from `<U, D, L, R, F, x, y>`.

### The Cube Group

Let $K$ denote the set containing the 54 sticker locations on the cube.
The cube's state is a map from $K$ to physical stickers.
The objects we wish to study are the effects on this state that can be realized within the mechanical constraints of the cube.
Such effects can be thought of as permutations of $K$.
For example, the `U` turn corresponds to the permutation `(UL UF UR UB)(LU FU RU BU)(ULB UFL URF UBR)(LBU FLU RFU BRU)(BUL LUF FUR RUB)`.

However, there are many permutations of $K$ that do not make sense in the context of the puzzle.
For example, there is no sequence of turns to swap the `FD` sticker with the `BDR` sticker.
We are really only interested in certain subgroups of $S_K$ (the symmetric group on $K$), such as those generated by the turns `<U, D, L, R, F, B>` or `<U, D, L, R, F, B, x, y, z>`.

Consider the subgroup of $S_K$ whose elements are effects achievable by disassembling the cube into its 26 pieces (6 centers, 12 edges, and 8 corners) and then rearranging them.
In order to understand this structure of this group, we must consider piece permutation and piece orientation separately.

For example, the `R` turn causes the following piece permutation, where pieces are specified by their primary sticker locations as described above: `(URF UBR DRB DFR)(UR BR DR FR)`. Additionally, for each edge piece moved, the sticker that was in the primary sticker location of that piece location may or may not be in the primary sticker location of its new piece location. For each corner piece moved, the sticker that was in the primary sticker location of that piece location may be either 0, 1, or 2 clockwise piece twists removed from the primary sticker location of its new piece location. This representation of group elements is a bit unweildy, but it will soon shed light on some important properties of the subgroups we care about.

Let $P_t$ denote the set of center pieces, $P_e$ the edges, and $P_c$ the corners.
We can specify an element of the piece rearrangement subgroup as $(\pi, \sigma, \tau, o_e, o_c)$ where:

* $\pi \in S_{P_t}$ is a permutation of center pieces
* $\sigma \in S_{P_e}$ is a permutation of edge pieces
* $\tau \in S_{P_c}$ is a permutation of corner pieces
* $o_e : P_e \rightarrow \mathbb{Z}/2\mathbb{Z}$ maps edge pieces to their new orientations
* $o_c : P_c \rightarrow \mathbb{Z}/3\mathbb{Z}$ maps corner pieces to their new orientations

Applying $(\pi_1, \sigma_1, \tau_1, {o_e}_1, {o_c}_1)$ and then $(\pi_2, \sigma_2, \tau_2, {o_e}_2, {o_c}_2)$ is equivalent to applying $(\pi_2 \circ \pi_1, \sigma_2 \circ \sigma_1, \tau_2 \circ \tau_1, {o_e}_1 + ({o_e}_2 \circ \sigma_1), {o_c}_1 + ({o_c}_2 \circ \tau_1))%formytexteditor_$

We will now investigate a subgroup of the piece rearrangement group which is often called the cube group.
It is the group generated by `<U, D, L, R, F, B>`.
This group is of particular interest because it contains exactly all of the realizable effects on the cube that do not affect the center pieces.

Below are the elements of the piece rearrangement group corresponding to the basic face turns:

```
                                                     o_e                               o_c
       \pi, \sigma, and \tau         UL UR UF UB DL DR DF DB FL FR BL BR ULB URF UFL UBR DLF DRB DFR DBL 
U | (UL UB UR UF)(ULB UBR URF UFL) | 0  0  0  0  0  0  0  0  0  0  0  0 | 0   0   0   0   0   0   0   0
D | (DL DF DR DB)(DLF DBL DFR DRB) | 0  0  0  0  0  0  0  0  0  0  0  0 | 0   0   0   0   0   0   0   0
L | (UL FL DL BL)(ULB UFL DLF DBL) | 0  0  0  0  0  0  0  0  0  0  0  0 | 1   0   2   0   1   0   0   2
R | (UR BR DR FR)(URF UBR DRB DFR) | 0  0  0  0  0  0  0  0  0  0  0  0 | 0   1   0   2   0   1   2   0
F |
B |                                             ... TODO ...
```

The table above reveals some important properties of the cube group.
First of all, every piece permutation of this generating set is even, so all piece permutations in the subgroup are even.
This means that there is no sequence of face turns that swaps the positions of just two pieces with no side effects.

Secondly, for each face turn, the total edge flip is 0 modulo 2 and the total corner twist is 0 modulo 3.
The total edge flip of the composition of two elements is the sum of those elements' edge flips, and the same is true for corner twists.
So, all elements have total edge flip of 0 modulo 2 and total corner twist of 0 modulo 3.
This means that there is no sequence of face turns that only flips a single edge or twists a single corner.

There do exist, however, sequences of face turns, which we will examine later, to accomplish the following:

* Cycle any three edges
* Cycle any three corners
* Transpose any two edges and transpose any two corners simultaneously
* Flip any two edges
* Twist one corner clockwise and another counter-clockwise

From these fundimental sequences of turns, we can construct elements of the `<U, D, L, R, F, B>` subgroup with arbitrary even permutations and arbitrary corner and edge orientations that sum to 0. There are $\frac{8!12!}{2}$ even permutations, $2^{11}$ legal edge orientations, and $3^7$ legal corner orientations. So, the order of the `<U, D, L, R, F, B>` subgroup is:

$$\frac{8! 12!}{2} 2^{11} 3^7 = 43,252,003,274,489,856,000$$

To summarize, we've considered the following groups, each a subgroup of the last:

* $S_K$
* The piece rearrangement group
* The cube group, which is generated by `<U, D, L, R, F, B>`

The elements of $S_K$ act on the states of the cube. However, in general, we specify states of the cube relative to a particular “solved” state (for example, that in which the entire `U` face is white, the entire `F` face is green, etc.). In this sense, states are in direct correspondence with effects. For example, the state specified by the sequence of turns `(U F)3 D'` is the state resulting the application of that sequence of turns to the solved state.

## Strategy Overview

When I hand you a scrambled cube, you need to gather enough information about its state to be able to execute a solution once you don the blindfold. Here, a solution is a group element whose effect on the scrambled state is returning it to the solved state. To execute a group element means to express it as a sequence of turns (and perhaps physically execute those turns).

A very difficult approach is to use the memorization phase to construct a solution as a sequence of turns by solving the cube using a normal method in your imagination. This approach might be good for minimizing execution time (you could spend a really long time in the memorization phase finding a short solution), but requires special talents. While some people are capable of using this approach, I am not.

An easier approach, which the remainder of this article describes, involves memorizing the solution (that is, the group element corresponding to the inverse of the state of the cube) as a permutation of stickers, breaking that permutation down into the product of simpler permutations (elements which have a small effect on the state of the cube), and then executing those permutation one at a time.

To accomplish this, we need to nail down a few details:

* How to actually observe this permutation given the scrambled cube
* How to encode this permutation in a way that is easy to remember
* How to express this permutation as a product of 3-cycles that we know how to execute
* How to execute 3-cycles

We'll encounter many other details as we go along, but this is the general idea.

## Executing Simple Permutations

First, let's consider ways of executing simple permutations (permutations that don't involve many stickers or pieces).
Which simple permutations are easiest to execute will inform how we choose to break up solutions.

### "Algorithms"

### Commutators

### Conjugation

### 3-Cycles from Conjugated Double-Transpositions

## Executing a Solution

## Memorization

## Larger Cubes

## Additional Resources

`IN PROGRESS`

In the meantime, check out this video in which a younger version of me solves a 4x4x4 cube blindfolded:

<div class="content-auto-resizable-iframe-full">
<div>
<iframe src="https://www.youtube-nocookie.com/embed/UA_jAeGeYKY?rel=0&amp;showinfo=0" frameborder="0" allow="encrypted-media" allowfullscreen></iframe>
</div>
</div>
