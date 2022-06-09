---
template: templates/article.html
title: An Elegant Method for Solving the Rubik's Cube
date: 2022-06-08
has_math: true
...

I present a new method based on the idea of reducing the cube to states which can be solved with increasingly limited sets of moves.
This method has the interesting property of ending with intuitive blockbuilding.

For context, see [Thistlethwaite's algorithm](https://www.jaapsch.net/puzzles/thistle.htm) and the [RUP method](https://presleygit.github.io/index_eng.html) .

Consider the following six subgroups of the cube group:

------------------------------------------------- ---------------------------
$G_0 = \langle U, D, L, R, F, B \rangle$          $\;\;|G_0| = \textrm{43,252,003,274,489,856,000}$
$G_1 = \langle U, D, L, R, F^2, B^2 \rangle$      $\;\;|G_1| = \textrm{    21,119,142,223,872,000}$
$G_2 = \langle U, D, L^2, R^2, F^2, B^2 \rangle$  $\;\;|G_2| = \textrm{            19,508,428,800}$
$G_3 = \langle U, R^2 \rangle$                    $\;\;|G_3| = \textrm{                   302,400}$
$G_4 = \langle U^2, R^2 \rangle$                  $\;\;|G_4| = \textrm{                         6}$
$G_5 = \{ e \}$                                   $\;\;|G_5| = \textrm{                         1}$
------------------------------------------------- ---------------------------

Each of the five phases of this method corresponds to a reduction from $G_{n-1}$ to $G_n$ using only moves found in $G_{n-1}$.

### Phase 1: $\langle U, D, L, R, F, B \rangle \rightarrow \langle U, D, L, R, F^2, B^2 \rangle$

A state in $G_0$ is also in $G_1$ if and only if all edge pieces are oriented correctly according to the following definition: an edge pieces is oriented correctly if and only if its primary sticker is on its primary face. An edge piece's primary sticker is its U- or D-colored sticker if it has one, otherwise its F- or B-colored sticker. An edge piece's primary face is U or D if it is located on U or D, otherwise F or B. Equivalently, from another perspective, and edge is piece is oriented correctly if and only if it can be solved using $U$, $D$, $L$, $R$, $F^2$, and $R^2$. The number of misoriented edge pieces is always even.

Observe that moves in $G_1$ do not change the orientation of any edge pieces, whereas $F$, $F^{-1}$, $B$, and $B^{-1}$ each change the orientation of four edge pieces. Furthermore, moves like $FUF^{-1}$ change the orientation of two edge pieces. Use setup moves in $G_1$ to position groups of misoriented edge pieces into the positions that get flipped by these basic edge-flipping moves until all edge pieces are correctly oriented.

From now on, use only moves in $G_1$.

### Phase 2: $\langle U, D, L, R, F^2, B^2 \rangle \rightarrow \langle U, D, L^2, R2, F^2, B^2 \rangle$

A state in $G_1$ is also in $G_2$ if and only if all E-slice edge pieces are in the E-slice and all corner pieces are oriented correctly according to the following definition: a corner piece is correctly oriented if its U- or D-colored sticker is on the U or D face.

Observe that $L$, $L^{-1}$, $R$, and $R^{-1}$ each change the orientation of four corner pieces and replace two edge pieces in the E-slice. Furthermore, observe that moves like $RUR^{-1}$ change the orientation of three corner pieces and replace one edge piece in the E-slice.

Here is one approach to reaching $G_2$: First, place three of the four E-slice edge pieces in the E-slice. Next, using setup moves in $G_2$ around moves like $RUR^{-1}$ (choosing those which affect only the E-slice slot which is not filled with an E-slice piece) flip all but three corner pieces, being careful not to insert the final E-slice piece. Finally, setup to one last $RUR^{-1}$-like move to flip the last three corners and insert the last E-slice piece.

This step can be tricky. Like a puzzle(!).

From now on, use only moves in $G_2$.

### Phase 3: $\langle U, D, L^2, R^2, F^2, B^2 \rangle \rightarrow \langle U, R^2 \rangle$

A state in $G_2$ is also in $G_3$ if and only if the $2\times 2\times 3$ block around the DL edge of the cube is solved and the permutation of corner pieces satisfies the following: if moves in $G_3$ are used to solve any three corner pieces, the other three end up also being solved. `TODO: provide explanation and proof sketch`.

First, solve the $2\times 2\times 3$ block around the DL edge of the cube. Next, using moves from $G_3$, solve the DLF and DLB corners. Now, the remaining four corners are one transposition away from being solved relative to one another. Set this transposition up to ULF and URF, and then perform $F^2U^{-1}F^2U^{-1}F^2U^2F^2$.

That last step, explained: Let $a = F^2U^{-1}F^2U^{-1}F^2U^2F^2$ and $b = R^2U^{-1}R^2UR^2UR^2U^2$. Observe that $ab$ is a double transposition which swaps the ULF and URF corners and the UL and DR edges. Setting up our desired transposition to ULF and URF with moves in $G_3$, performing $ab$, and then undoing those setup moves would bring the cube into $G_3$. However, $b$ and the undoing of the setup moves are both in $G_3$, so all that is necessary to bring the cube into $G_3$ are to perform the setup moves and then perform $a$.

From now on, use only moves in $G_3$.

### Phase 4: $\langle U, R^2 \rangle \rightarrow \langle U^2, R^2 \rangle$

### Phase 5: $\langle U^2, R^2 \rangle \rightarrow \{ e \}$

This final phase can be solved easily using intuition. However, if in doubt, just remember that $G_4$ is cyclic: $|R^2U^2| = |G_4| = 6$.
