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

A state in $G_2$ is also in $G_3$ if and only if the $2\times 2\times 3$ block around the DL edge of the cube is solved and the permutation of corner pieces satisfies the following: if moves in $G_3$ are used to solve any three corner pieces, the other three end up also being solved.

`TODO: provide explanation and proof sketch`.

First, solve the $2\times 2\times 3$ block around the DL edge of the cube. Next, using moves from $G_3$, solve the DLF and DLB corners. Now, the remaining four corners are one transposition away from being solved relative to one another. Set this transposition up to ULF and URF, and then perform $F^2U^{-1}F^2U^{-1}F^2U^2F^2$.

That last step, explained: Let $a = F^2U^{-1}F^2U^{-1}F^2U^2F^2$ and $b = R^2U^{-1}R^2UR^2UR^2U^2$. Observe that $ab$ is a double transposition which swaps the ULF and URF corners and the UL and DR edges. Setting up our desired transposition to ULF and URF with moves in $G_3$, performing $ab$, and then undoing those setup moves would bring the cube into $G_3$. However, $b$ and the undoing of the setup moves are both in $G_3$, so all that is necessary to bring the cube into $G_3$ are to perform the setup moves and then perform $a$.

From now on, use only moves in $G_3$.

### Phase 4: $\langle U, R^2 \rangle \rightarrow \langle U^2, R^2 \rangle$

Using intuition, form a pair around each of the three remaining S-slice edge pieces. The first and second pairs should face in opposite directions. Next, position these pairs so that each S-slice edge piece is in the S-slice. Now, the cube is in $G_4$.

`TODO: provide explanation and techniques`

### Phase 5: $\langle U^2, R^2 \rangle \rightarrow \{ e \}$

This final phase can be completed using intuition. If in doubt, just remember that $G_4$ is cyclic: $|R^2U^2| = |G_4| = 6$.

### Examples

[Example solution #1](https://alg.cubing.net/?type=reconstruction&setup=R_D2_L_R_B2_U2_B2_D2_L_B2_U2_B-_U-_F-_R-_U-_B_D-_B_U_F&alg=%2F%2F_Phase_1%0A%0AU_L_B-_%2F%2F_flip_4_edges%0AU_F_L_F-_%2F%2F_flip_2_remaining_edges%0A%0A%2F%2F_Phase_2%0A%0AL_U_L-_%2F%2F_finish_placing_all_but_one_E%26%2345%3Bslice_edge_in_E%26%2345%3Bslice%0AR2_D_R-_U_R_%2F%2F_setup_and_flip_three_corners_to_get_to_an_easier_corner_orientation_state%0AU_R-_U_R_%2F%2F_setup_and_flip_three_corners_to_get_to_the_penultimate_corner_orientation_state%0AM2_D_R-_U-_R_%2F%2F_setup_and_flip_final_three_corners_while_inserting_final_E%26%2345%3Bslice_edge%0Ax2_%2F%2F_re%26%2345%3Borient_cube%0A%0A%2F%2F_Phase_3%0A%0AR2_F2_R2_D_R2_D2_%2F%2F_create_2x2x2_block%0AR2_U2_R2_F2_R2_F2_%2F%2F_complete_2x2x3_block%0AR2_U_R2_U-_R2_U-_R2_%2F%2F_solve_DRF_and_DRB%0A%2F%2F_note_that_ULB_and_URB_must_be_swapped_in_order_for_U_corners_to_be_solved_relative_to_one_another%0AU2_%2F%2F_setup_ULB_and_URB_ro_ULF_and_URF%0AF2_U-_F2_U-_F2_U2_F2_%2F%2F_execute_corner_permutation_algorithm%0A%0A%2F%2F_Phase_4%0A%0AR2_%2F%2F_create_first_pair%0AU_R2_U_R2_U_R2_U_R2_%2F%2F_create_second_pair%0A%2F%2F_third_pair_skip%0AU-_R2_U_R2_U-_R2_U_%2F%2F_align_pairs_%0A%0A%2F%2F_Phase_5%0A%0AR2_U2_%2F%2F_finish&view=playback)

<!--

# scramble

R D2 L R B2 U2 B2 D2 L B2 U2 B' U' F' R' U' B D' B U F

# solve

// Phase 1

U L B' // flip 4 edges
U F L F' // flip 2 remaining edges

// Phase 2

L U L' // finish placing all but one E-slice edge in E-slice
R2 D R' U R // setup and flip three corners to get to an easier corner orientation state
U R' U R // setup and flip three corners to get to the penultimate corner orientation state
M2 D R' U' R // setup and flip final three corners while inserting final E-slice edge
x2 // re-orient cube

// Phase 3

R2 F2 R2 D R2 D2 // create 2x2x2 block
R2 U2 R2 F2 R2 F2 // complete 2x2x3 block
R2 U R2 U' R2 U' R2 // solve DRF and DRB
// note that ULB and URB must be swapped in order for U corners to be solved relative to one another
U2 // setup ULB and URB ro ULF and URF
F2 U' F2 U' F2 U2 F2 // execute corner permutation algorithm

// Phase 4

R2 // create first pair
U R2 U R2 U R2 U R2 // create second pair
// third pair skip
U' R2 U R2 U' R2 U // align pairs 

// Phase 5

R2 U2 // finish

-->

[Example solution #2](https://alg.cubing.net/?setup=R2_B2_R2_B2_U2_R2_D_U2_L2_F2_R2_B_L-_F-_L-_B_F_D2_F2_U_F&type=reconstruction&alg=%2F%2F_Phase_1%0A%0AF_%2F%2F_flip_4_edges%0AB_L-_B-_%2F%2F_flip_remaining_2_edges%0A%0A%2F%2F_Phase_2%0A%0A%2F%2F_three_out_of_four_E%26%2345%3Bslice_edges_are_already_in_the_E%26%2345%3Bslice%0AL-_U_L_%2F%2F_setup_and_flip_three_corners_to_get_to_the_penultimate_corner_orientation_state%0AR2_U_D_M2_D_L-_U_L_%2F%2F_setup_and_flip_final_three_corners_while_inserting_final_E%26%2345%3Bslice_edge%0Ax2_%2F%2F_re%26%2345%3Borient_cube%0A%0A%2F%2F_Phase_3%0A%0AF2_L2R2_D_R2_D2_%2F%2F_create_2x2x2_block%0AU-_R2_U2_F2_%2F%2F_complete_2x2x3_block%0AU_R2_U-_R2_U_R2_U_R2_%2F%2F_solve_DRF_and_DRB%0A%2F%2F_note_that_ULB_and_URB_must_be_swapped_in_order_for_U_corners_to_be_solved_relative_to_one_another%0AU2_%2F%2F_setup_ULB_and_URB_ro_ULF_and_URF%0AF2_U-_F2_U-_F2_U2_F2_%2F%2F_execute_corner_permutation_algorithm%0A%0A%2F%2F_Phase_4%0A%0AU-_R2_%2F%2F_create_first_pair%0AU2_R2_U-_R2_%2F%2F_create_second_pair%0AU_R2_U2_R2_%2F%2F_create_third_pair%0AU2_R2_U-_R2_U_R2_U-_%2F%2F_align_pairs%0A%0A%2F%2F_Phase_5%0A%0AR2_U2_R2_U2_%2F%2F_finish&view=playback)

<!--

# scramble

R2 B2 R2 B2 U2 R2 D U2 L2 F2 R2 B L' F' L' B F D2 F2 U F

# solve

// Phase 1

F // flip 4 edges
B L' B' // flip remaining 2 edges

// Phase 2

// three out of four E-slice edges are already in the E-slice
L' U L // setup and flip three corners to get to the penultimate corner orientation state
R2 U D M2 D L' U L // setup and flip final three corners while inserting final E-slice edge
x2 // re-orient cube

// Phase 3

F2 L2R2 D R2 D2 // create 2x2x2 block
U' R2 U2 F2 // complete 2x2x3 block
U R2 U' R2 U R2 U R2 // solve DRF and DRB
// note that ULB and URB must be swapped in order for U corners to be solved relative to one another
U2 // setup ULB and URB ro ULF and URF
F2 U' F2 U' F2 U2 F2 // execute corner permutation algorithm

// Phase 4

U' R2 // create first pair
U2 R2 U' R2 // create second pair
U R2 U2 R2 // create third pair
U2 R2 U' R2 U R2 U' // align pairs

// Phase 5

R2 U2 R2 U2 // finish

-->