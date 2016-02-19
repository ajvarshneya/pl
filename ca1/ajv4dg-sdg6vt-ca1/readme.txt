README
CS 4501 - Compiler's Practicum
CA1 - Dead Code Elimination
A.J. Varshneya (ajv4dg@virginia.edu)
Spencer Gennari (sdg6vt@virginia.edu)
2/8/16

This program is separated into two files: tacs.py and main.py.

tacs.py
Contains classes covering each type of instruction and basic blocks. We chose this strategy to make our code more flexible and extensible. We also expect that we will be able to use these classes for future assignments involving TAC.

main.py
Contains several functions working together to execute the live variable analysis on input code. These functions include read_tac, make_inst_list, make_bbs, liveness, percolate, and kill_dead_code. The program's execution carries out as follows. First it reads in raw instructions and generates a list of three address code objects. Then it generates a list of basic blocks using those three address code objects and populates their child/parent sets to describe their connections. The program has a loop to refresh the liveness set attributes of every basic block and propogate those changes up the basic block if a removal occurred on its last iteration. 

The idea is that we refresh all the liveness sets, remove dead code, and repeat these two steps until the live in set of each basic block doesn't change. To refresh the liveness sets, we iterate over the blocks and set each block's live_out set to the union of its children's live_in sets before percolating these changes up the block to its own live_in set. Removing dead code works similarly, but in each step we check if the assignee is in the liveness set, and if it isn't then we delete the instruction.

To test our code, we used several of our own cases in addition to the Cool examples provided by the instructors. In 'test1.cl-tac' we included each of the possible instructions to ensure that our program would properly process them in each case. This test also contains instances of dead code as we do many assignments to virtual registers that are used few or no times after. In 'test2.cl-tac' we include the TAC representation of a while loop with an if-statement inside to make sure that the program can appropriately handle cyclic parent-child references. Additionally, this test also propagates a value from the initial basic block to the final basic block without referencing it in the intermediate blocks, ensuring that live in sets were properly handled across all blocks.