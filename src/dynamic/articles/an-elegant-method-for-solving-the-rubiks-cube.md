---
template: templates/article.html
title: An Elegant Method for Solving the Rubik's Cube
date: 2022-06-08
has_math: true
...

I present a new method based on the idea of reducing the cube to states which can be solved with increasingly limited sets of turns.
This method has the interesting property of ending with intuitive blockbuilding.

For context, see [Thistlethwaite's algorithm](https://www.jaapsch.net/puzzles/thistle.htm) and the [RUP method](https://presleygit.github.io/index_eng.html) .

Consider the following six nested subgroups of the cube group:

------------------------------------------------- ---------------------------
$G_0 = \langle U, D, L, R, F, B \rangle$          $\;\;|G_0| = \textrm{43,252,003,274,489,856,000}$
$G_1 = \langle U, D, L, R, F^2, B^2 \rangle$      $\;\;|G_1| = \textrm{    21,119,142,223,872,000}$
$G_2 = \langle U, D, L^2, R^2, F^2, B^2 \rangle$  $\;\;|G_2| = \textrm{            19,508,428,800}$
$G_3 = \langle U, R^2 \rangle$                    $\;\;|G_3| = \textrm{                   302,400}$
$G_4 = \langle U^2, R^2 \rangle$                  $\;\;|G_4| = \textrm{                         6}$
$G_5 = \{ e \}$                                   $\;\;|G_5| = \textrm{                         1}$
------------------------------------------------- ---------------------------

Each phase of this method corresponds to a reduction from $G_{n-1}$ to $G_n$ using only turns found in $G_{n-1}$.

You may find the following interactive, annotated examples helpful as you read through each phase. On the example pages, click on a point in the annotated text to bring the virtual cube to that point in the solution.

- [Example solution #1](https://alg.cubing.net/?type=reconstruction&setup=R_D2_L_R_B2_U2_B2_D2_L_B2_U2_B-_U-_F-_R-_U-_B_D-_B_U_F&alg=%2F%2F_Phase_1%0A%0AU_L_B-_%2F%2F_flip_4_edges%0AU_F_L_F-_%2F%2F_flip_2_remaining_edges%0A%0A%2F%2F_Phase_2%0A%0AL_U_L-_%2F%2F_finish_placing_all_but_one_E%26%2345%3Bslice_edge_in_E%26%2345%3Bslice%0AR2_D_R-_U_R_%2F%2F_setup_and_flip_three_corners_to_get_to_an_easier_corner_orientation_state%0AU_R-_U_R_%2F%2F_setup_and_flip_three_corners_to_get_to_the_penultimate_corner_orientation_state%0AM2_D_R-_U-_R_%2F%2F_setup_and_flip_final_three_corners_while_inserting_final_E%26%2345%3Bslice_edge%0Ax2_%2F%2F_re%26%2345%3Borient_cube%0A%0A%2F%2F_Phase_3%0A%0AR2_F2_R2_D_R2_D2_%2F%2F_create_2x2x2_block%0AR2_U2_R2_F2_R2_F2_%2F%2F_complete_2x2x3_block%0AR2_U_R2_U-_R2_U-_R2_%2F%2F_solve_DRF_and_DRB%0A%2F%2F_note_that_ULB_and_URB_must_be_swapped_in_order_for_U_corners_to_be_solved_relative_to_one_another%0AU2_%2F%2F_setup_ULB_and_URB_ro_ULF_and_URF%0AF2_U-_F2_U-_F2_U2_F2_%2F%2F_execute_corner_permutation_algorithm%0A%0A%2F%2F_Phase_4%0A%0AR2_%2F%2F_create_first_pair%0AU_R2_U_R2_U_R2_U_R2_%2F%2F_create_second_pair%0A%2F%2F_third_pair_skip%0AU-_R2_U_R2_U-_R2_U_%2F%2F_align_pairs_%0A%0A%2F%2F_Phase_5%0A%0AR2_U2_%2F%2F_finish&view=playback)
- [Example solution #2](https://alg.cubing.net/?setup=R2_B2_R2_B2_U2_R2_D_U2_L2_F2_R2_B_L-_F-_L-_B_F_D2_F2_U_F&type=reconstruction&alg=%2F%2F_Phase_1%0A%0AF_%2F%2F_flip_4_edges%0AB_L-_B-_%2F%2F_flip_remaining_2_edges%0A%0A%2F%2F_Phase_2%0A%0A%2F%2F_three_out_of_four_E%26%2345%3Bslice_edges_are_already_in_the_E%26%2345%3Bslice%0AL-_U_L_%2F%2F_setup_and_flip_three_corners_to_get_to_the_penultimate_corner_orientation_state%0AR2_U_D_M2_D_L-_U_L_%2F%2F_setup_and_flip_final_three_corners_while_inserting_final_E%26%2345%3Bslice_edge%0Ax2_%2F%2F_re%26%2345%3Borient_cube%0A%0A%2F%2F_Phase_3%0A%0AF2_L2R2_D_R2_D2_%2F%2F_create_2x2x2_block%0AU-_R2_U2_F2_%2F%2F_complete_2x2x3_block%0AU_R2_U-_R2_U_R2_U_R2_%2F%2F_solve_DRF_and_DRB%0A%2F%2F_note_that_ULB_and_URB_must_be_swapped_in_order_for_U_corners_to_be_solved_relative_to_one_another%0AU2_%2F%2F_setup_ULB_and_URB_ro_ULF_and_URF%0AF2_U-_F2_U-_F2_U2_F2_%2F%2F_execute_corner_permutation_algorithm%0A%0A%2F%2F_Phase_4%0A%0AU-_R2_%2F%2F_create_first_pair%0AU2_R2_U-_R2_%2F%2F_create_second_pair%0AU_R2_U2_R2_%2F%2F_create_third_pair%0AU2_R2_U-_R2_U_R2_U-_%2F%2F_align_pairs%0A%0A%2F%2F_Phase_5%0A%0AR2_U2_R2_U2_%2F%2F_finish&view=playback)
- [Example solution #3](https://alg.cubing.net/?setup=D_L2_U_L2_U_L2_U2_L2_U-_F2_D-_L_U-_L2_D2_L_B2_U_B-_L2_U&type=reconstruction&alg=%2F%2F_Phase_1%0A%0AU-_L2_B_%2F%2F_setup_and_flip_all_4_misoriented_edges%0A%0A%2F%2F_Phase_2%0A%0AU2_R-_U_R%0A%2F%2F_three_out_of_four_E%26%2345%3Bslice_edges_are_already_in_the_E%26%2345%3Bslice%0AR2_D-_U-__%2F%2F_setup_and_flip_three_corners_to_get_to_an_easier_corner_orientation_state%0AU2_R_U-_R-_%2F%2F_setup_and_flip_three_corners_to_get_to_the_penultimate_corner_orientation_state%0AR-_D_R_%2F%2F_flip_final_three_corners_while_inserting_final_E%26%2345%3Bslice_edge%0A%0A%2F%2F_Phase_3%0A%0AD_U-_B2_D2_L2_%2F%2F_create_2x2x2_block%0AU-_R2_U_R2_U_R2__B2_%2F%2F_complete_2x2x3_block%0AU2_R2_U_R2_%2F%2F_solve_DRF_and_DRB%0A%2F%2F_note_that_URF_and_URB_must_be_swapped_in_order_for_U_corners_to_be_solved_relative_to_one_another%0AU_%2F%2F_setup_ULB_and_URB_ro_ULF_and_URF%0AF2_U-_F2_U-_F2_U2_F2_%2F%2F_execute_corner_permutation_algorithm%0A%0A%2F%2F_Phase_4%0A%0A%2F%2F_first_pair_skip%0AU2_R2_U-_R2_%2F%2F_create_second_pair%0AU_R2_U2_R2_%2F%2F_create_third_pair%0AU2_R2_U-_R2_U_R2_U_%2F%2F_align_pairs%0A%0A%2F%2F_Phase_5%0A%0A%2F%2F_skip&view=playback)

### Phase 1: $\langle U, D, L, R, F, B \rangle \rightarrow \langle U, D, L, R, F^2, B^2 \rangle$

A state in $G_0$ is also in $G_1$ if and only if all edge pieces are oriented correctly according to the following definition: an edge pieces is oriented correctly if and only if its primary sticker is on its primary face. An edge piece's primary sticker is its U- or D-colored sticker if it has one, otherwise its F- or B-colored sticker. An edge piece's primary face is U or D if it is located on U or D, otherwise F or B. Equivalently, from another perspective, and edge is piece is oriented correctly if and only if it can be solved using $U$, $D$, $L$, $R$, $F^2$, and $B^2$. The number of misoriented edge pieces is always even.

Observe that turns in $G_1$ do not change the orientation of any edge pieces, whereas $F$, $F'$, $B$, and $B'$ each change the orientation of four edge pieces. Furthermore, gadgets like $FUF'$ change the orientation of two edge pieces. Use setup moves in $G_1$ to position groups of misoriented edge pieces into the positions that get flipped by these basic edge-flipping turns and gadgets until all edge pieces are correctly oriented.

From now on, use only turns in $G_1$.

### Phase 2: $\langle U, D, L, R, F^2, B^2 \rangle \rightarrow \langle U, D, L^2, R^2, F^2, B^2 \rangle$

A state in $G_1$ is also in $G_2$ if and only if all E-slice edge pieces are in the E-slice and all corner pieces are oriented correctly according to the following definition: a corner piece is correctly oriented if and only if its U- or D-colored sticker is on the U or D face.

Observe that $L$, $L'$, $R$, and $R'$ each change the orientation of four corner pieces and replace two edge pieces in the E-slice. Furthermore, observe that gadgets like $RUR'$ change the orientation of three corner pieces and replace one edge piece in the E-slice.

Here is one approach to reaching $G_2$: First, place three of the four E-slice edge pieces in the E-slice. Next, using setup moves in $G_2$ around gadgets like $RUR'$ (choosing those which affect only the E-slice slot which is not filled with an E-slice piece) flip all but three corner pieces, being careful not to insert the final E-slice piece. Finally, setup to one last $RUR'$-like gadgets to flip the last three corners and insert the last E-slice piece.

This step can be tricky at first, like a puzzle(!). Note that $M^2$ and $S^2$ can be useful for setting up the remaining E-slice edge in relation to the final three misoriented corners. $M^2$ and $S^2$ are in $G_2$ because they are equivalent to legal face turns followed by legal whole-cube rotations.

From now on, use only turns in $G_2$.

### Phase 3: $\langle U, D, L^2, R^2, F^2, B^2 \rangle \rightarrow \langle U, R^2 \rangle$

States in $G_3$ have a solved $2\times 2\times 3$ block around the DL edge of the cube. The rest of the charactarization of states in $G_3$ pertains to the permutation of the remaining six corner pieces.

Jaap Scherphuis provides a [proof](https://www.jaapsch.net/puzzles/pgl25.htm) that, in $\langle U, R \rangle$, the permutation of the remaining six corner pieces is isomorphic to $S_5$. By a near identical proof, the same turns out to be true for $G_3 = \langle U, R^2 \rangle$. It follows, as a corollary whose proof is left as an exercise for the reader, that, in $G_3$, the positions of any three non-DL corners determine the positions of the remaining three.

Now, a procedure for reaching $G_3$ from $G_2$: First, solve the $2\times 2\times 3$ block around the DL edge of the cube. Next, using moves from $G_3$, solve the DLF and DLB corners. Now, the remaining four corners are one transposition away from being solved relative to one another. Set this transposition up to ULF and URF, and then perform $F^2U'F^2U'F^2U^2F^2$.

That last step, explained: Let $a = F^2U'F^2U'F^2U^2F^2$ and $b = R^2U'R^2UR^2UR^2U^2$. Observe that $ab$ is a double transposition which swaps the ULF and URF corners and the UL and DR edges. Setting up our desired transposition to ULF and URF with moves in $G_3$, performing $ab$, and then undoing those setup moves would bring the cube into $G_3$. However, $b$ and the undoing of the setup moves are both in $G_3$, so all that is necessary to bring the cube into $G_3$ are to perform the setup moves and then perform $a$.

$a$ works by breaking and then restoring the $2\times 2\times 3$ block, disrupting the U and R layers in the process. $b$ restores the DRF and DRB corner pieces and then does as $U$ turn to place the remaining four corner pieces. You can think of $a$ as having the effect of causing the cube's state to jump between left cosets of $G_3$ in the containing group of states in $G_2$ with a solved $2\times 2\times 3$ block around DL. $b$ just helps us identify which left coset we have landed in.

From now on, use only turns in $G_3$.

### Phase 4: $\langle U, R^2 \rangle \rightarrow \langle U^2, R^2 \rangle$

Consider the appearance of the U and R layers in states in $G_4$: two $1\times 1\times 3$ blocks consisting of one center piece and two edge pieces, and three $1\times 1\times 3$ blocks consisting of one edge piece and two corner pieces. Although we will reach $G_4$ using blockbuilding, thanks to the properties of $G_3$, we will only have to focus on three $1\times 1\times 2$ blocks consisting of one S-slice edge piece and one corner piece. Once we have created and aligned these three smaller blocks, the rest of the pieces will already be positioned correctly(!).

Our blockbuilding goal will be to place each S-slice edge piece in the S-slice as part of a corner-edge pair. Note that ever since $G_2$, E-slice edge pieces have been restricted to the E-slice. So, once the three remaining S-slice edge pieces are in the S-slice, the only two remaining edge pieces, which are M-slice edge pieces, will be in the M-slice. Furthermore, as we know from the characterization of $G_4$, the positions of the three remaining corner pieces are determined by the positions of the three corner pieces that are part of our blocks. So, once we reach this blockbuilding goal, we will already be in $G_4$.

Form each of the three corner-edge pairs one at a time. Avoid breaking up formed pairs while forming subsequent pairs. The first two pairs should be chosen so that they face in opposite directions. That is, when they are on opposite sides of the same layer, they should not be able to be interchaged with a half-turn. Finally, position the three pairs so that each S-slice edge piece is in the S-slice. Now, the cube is in $G_4$.

From now on, use only turns in $G_4$.

### Phase 5: $\langle U^2, R^2 \rangle \rightarrow \{ e \}$

Using intuition, solve the cube. If in doubt, just remember that $G_4$ is cyclic: $|R^2U^2| = |G_4| = 6$.

<!--

###

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

###

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

###

# scramble

D L2 U L2 U L2 U2 L2 U' F2 D' L U' L2 D2 L B2 U B' L2 U

# solve

// Phase 1

U' L2 B // setup and flip all 4 misoriented edges

// Phase 2

U2 R' U R
// three out of four E-slice edges are already in the E-slice
R2 D' U'  // setup and flip three corners to get to an easier corner orientation state
U2 R U' R' // setup and flip three corners to get to the penultimate corner orientation state
R' D R // flip final three corners while inserting final E-slice edge

// Phase 3

D U' B2 D2 L2 // create 2x2x2 block
U' R2 U R2 U R2  B2 // complete 2x2x3 block
U2 R2 U R2 // solve DRF and DRB
// note that URF and URB must be swapped in order for U corners to be solved relative to one another
U // setup ULB and URB ro ULF and URF
F2 U' F2 U' F2 U2 F2 // execute corner permutation algorithm

// Phase 4

// first pair skip
U2 R2 U' R2 // create second pair
U R2 U2 R2 // create third pair
U2 R2 U' R2 U R2 U // align pairs

// Phase 5

// skip

-->
