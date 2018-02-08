Solving the cube blindfolded is a medetative exercise. Contrary to what you might expect, it doesn't even require an above-average memory. All that's necessary is a solid understanding of the basic properties of the cube, and a fair bit of practice.

This article doesn't assume any knowledge of cube theory, but a reader might find some basic undergraduate math (e.g. group theory) useful.

Furthermore, this article is not a tutorial, but rather an in-depth exploration.

# Preliminaries

## The Game

* I give you a cube in an arbitrary state
* You inspect the cube (the *morization* phase)
* You don the blindfold
* You solve the cube (the *execution* phase)

It's that simple.

## Notation

We always consider the cube as having a fixed orientation.
Relative to that fixed orientation, the cube has 6 faces:

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

The cube is composed of pieces.
Center pieces contain one sticker, edge pieces two, and corner pieces three.
One sticker location on each piece location is designated as the primay sticker location, which we use to specify that piece location.
Primary sticker location are determined as follows:

* Centers: the only sticker location
* Edges: the sticker location on the `U` or `D` face if such a sticker location exists, or the sticker location on the `F` or `B` face otherwise
* Corners: the sticker location on the `U` or `D` face

We can modify the state of the cube by the turns its mechanics permit.
The most basic turns correspond to the 6 faces.
We denote the clockwise turn of a face by the name of the face itself.
For example, the turn denoted `U` is a clockwise turn of `U` face from the perspective of looking at that face from outside of the cube.

We also consider rotations of the entire cube about its axes as modifying the its state.
We denote the clockwise rotations about the `x`, `y`, and `z` axes in the directions of `R`, `U`, and `F` respectively as `x`, `y`, and `z` respectively.

To invert a turn, we append a `'`, which we pronounce "inverse" or "prime".
For example, `U'` denotes a counter-clockwise turn of the `U` face.
A numerical suffix denotes repetition of a turn.
For these simple turns, the only suffix that really makes sense is `2` (for example, `U3 = U'` and `U1337 = U`).
We can also invert and repeat sequences of moves.
For example, `x' (U F)3 = x' U F U F U F` and `(U F' z R')' = R z' F U'`.

For convenience, we have names for other turns as well.
I will mention their mnemonics, but their mechanics, along with those of those already mentioned, are best observed in the widget below.

Double layer turns effect both a face and the layer behind that face. They are denoted by the lower-case equivalent of their corresponding face turn. For example, `u` denotes a simultaneous clockwise turn of the `U` face and the layer beneath it.

Slice turns just effect an inner layer:

* `M`: Turn the *middle* layer behind the `L` face in the same direction as `L`
* `E`: Turn the *equator* layer behind the `D` face in the same direction as `D`
* `S`: Turn the *slice* layer behind the `F` face in the same direction as `F`

<p style="text-align: center;"><iframe height="530px" width="300px" scrolling="no" frameborder="0" src="https://ruwix.com/widget/notation-3d/"></iframe></p>

The effects of certain moves can be achieved by combinations of different moves. For example, `M = x' L' R`.
It is not hard to see how `z` can be written in terms of `x` and `y`.
Furthermore, it is both interesting and non-obvious that any face turn can be written in terms of the five others.
By the end of this article, you will be able to construct a proof of that fact without much trouble at all!
So, the effect of any sequence of moves can be achieved with a sequence of only `{U, D, L, R, F, x, y}`.

## The Cube Group

Effects on the cube's state have a group structure.
<!-- We shall consider a sequence of groups describing these effects, each a subgroup of the last.
 -->

One approach to using the cube is rearranging the stickers on the surface of the cube.
Accordingly, we can consider effects on the state of the cube (accomplished by a sequence of turns or otherwise) as permutations of sticker locations.
For example, the `U` turn corresponds to the permutation `(UL UF UR UB)(LU FU RU BU)(ULB UFL URF UBR)(LBU FLU RFU BRU)(BUL LUF FUR RUB)`.
However, not every element of this group can be realized within the mechanical constraints of the cube.
For example, there is no sequence of turns to swap the `F` sticker with the `BDR` sticker.

We are really only interested in certain subgroups of the sticker permutations, such as those generated by `{U, D, L, R, F, B}` and `{U, D, L, R, F, B, x, y, z}`.
Let's find other ways of thinking about these subgroups that shed more light on their structure.

Another approach to using the cube is disassembling and rearranging its pieces.
From this perspective, we consider effects on the state of the cube as a rearrangement of pieces.
The effects we can have on the state of the cube in this universe are a strict subgroup of those in the sticker rearrangement case.

Formalizing this perspective is more complicated than simply declaring an isomporphism to $S_{54}$. We do so by considering piece permutation and orientation separately.

`TODO`

<!-- Interestingly, each face turn can be expressed in terms of the five others, so the cube group is generated by the turns `{U, D, L, R, F, x, y}`.

Here are a few important properties of the cube group (proofs are left out for now):

* Permutations of pieces are always even
* The orientations of any 7 corner pieces determine the orientation of the last
* The orientations of any 11 edge pieces determine the orientation of the last

However, informally, every element that could exist given these restrictions does.
Perhaps someday I'll add more precision to this statement, but its consequence is that the order of the cube group is:

$$|G| = \frac{8! 12!}{2} 3^7 2^{11} = 43,252,003,274,489,856,000$$ -->

The elements of the cube group act on the states of the cube.
However, in general, we will specify states of the cube *relative* to a particular "solved" state (for example, that in which the entire `U` face is white, the entire `F` face is green, etc.).
In this sense, states are in direct correspondence with effects.
For example, the state specified by the sequence of turns `(U F)3 D'` is the state resulting from applying that sequence of turns to the solved state.

# Strategy Overview

When I hand you a scrambled cube, you need to gather enough information about its state to be able to execute a solution once you don the blindfold. Here, a solution is a group element whose effect on the scrambled state is returning it to the solved state. To execute a group element means to express it as a sequence of turns (and perhaps physically execute those turns).

A very difficult approach is to use the memorization phase to construct a solution as a sequence of turns by solving the cube using a non-blindfolded approach in your imagination. This approach might be good for minimizing execution time (you could spend a really long time in the memorization phase finding a short solution), but requires special talents. While some people are capable of using this approach, I am not.

An easier approach, which the remainder of this article describes, involves memorizing the solution (that is, the group element corresponding to the inverse of the state of the cube) as a permutation of stickers, breaking that permutation down into the product of simpler permutations (elements which have a small effect on the state of the cube), and then executing those permutation one at a time.

To accomplish this, we need to nail down a few details:

* How to actually observe this permutation given the scrambled cube
* How to encode this permutation in a way that is easy to remember
* How to express this permutation as a product of 3-cycles that we know how to execute
* How to execute 3-cycles

We'll encounter many other details as we go along, but this is the general idea.

# Executing Simple Permutations

First, let's consider ways of executing simple permutations (permutations that don't involve many stickers or pieces).
Which simple permutations are easiest to execute will inform how we choose to break up solutions.

## "Algorithms"

## Commutators

## Conjugation

## 3-Cycles from Conjugated Double Transpositions

# Executing a Solution

# Memorization

# Larger Cubes

# Additional Resources

`IN PROGRESS`

In the meantime, check out this video in which a younger version of me solves a 4x4x4 cube blindfolded:

<div class="content-auto-resizable-iframe-full"><div>
<iframe src="https://www.youtube-nocookie.com/embed/UA_jAeGeYKY?rel=0&amp;showinfo=0" frameborder="0" allow="encrypted-media" allowfullscreen></iframe>
</div></div>

<p>&nbsp;</p>
