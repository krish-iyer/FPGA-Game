# Pacman Backend Design

# Description of VGA

1. Dimension: 1679 X 827
2. After both numbers, you should wrap around horizontally and vertically
3. The visible region horizontally is between `336` and `1615` inclusive, and vertically between `27` and `826` inclusive.
4. so it is  `1280 x 800`

# Some Helpful Maps

## map
    
- latest map [20 X 20]
    
    ```
    ====================
    =..................=
    =.=.============.=.=
    =.=.============.=.=
    =.=..............=.=
    =.================.=
    =..................=
    =.=======..=======.=
    =.......==.=.......=
    =.=====.=..=.=====.=
    ........=.==........
    =.=====.=..=.=====.=
    =.=====......=====.=
    =.=====.====.=====.=
    =.=====......=====.=
    =.=====.====.=====.=
    =.=====.====.=====.=
    =.=====.====.=====.=
    =..................=
    ====================
    ```
    
- latest_map with numbers [20 X 20] 0 → wall 1→ food
    
    ```
    00000000000000000000
    01111111111111111110
    01010000000000001010
    01010000000000001010
    01011111111111111010
    01000000000000000010
    01111111111111111110
    01000000011000000010
    01111111001011111110
    01000001011010000010
    11111111010011111111
    01000001011010000010
    01000001111110000010
    01000001000010000010
    01000001111110000010
    01000001000010000010
    01000001000010000010
    01000001000010000010
    01111111111111111110
    00000000000000000000
    ```
    

# Resource

[Part 1 — Pac Man Tutorial 1.0 documentation (pygamezero-pacman.readthedocs.io)](https://pygamezero-pacman.readthedocs.io/en/latest/part1.html)

# Functions to implement

1. BlockMemory IP
2. Input module to translate the input to move direction
3. Helper:: Map index to display function
4. Helper:: Display to Matrix index function [requires division - will be ignored]
5. Position Update function
6. ghost control functions
7. valid move detector
8. collision detector
9. top module to return the updated positions at every cycle.

## Block Memory IP

## Input Module

```verilog
// move direction is encoded
// it is left when the bit on the left is 1 and so for the right 
// position, it is right when the bit on the right is 1
// move_dir is one_hot_encoded 
// 0001-> right [most right position is 1]
// 1000-> left
// 0010-> up
// 0100-> down
module input_board (input key_input,
										output [3:0]move_direction);
// here goes your code 
endmodule
```

## Map index to display Function

```verilog

// this function maps a matrix position to the actual display positions

// this function also should  the resolution of the VGA
// and the dimension of the matrix to represent how
// many pixels is at every index
// for now we will not make a division as the circuit is not 
// synthesizable; instead we will allow fixed combinations

// 1615 -> horizontal display max [11 bits]
// 826 -> vertical display max [10 bits]
// make sure you wrap around those two numbers
// The visible region is
// horizontally between 336 and 1615 inclusive,
// vertically between 27 and 826 inclusive.
// that gives us a display of 1280 X 800 

// we chose the matrix to be 80 X 50 or 64 X 40 [20x20 multiple]
// this matches the original ratio as well 
// each pixel represents 16x16 pixels in the original display
// matrix_idx_x -> 7 bits
// matrix_idx_y -> 6 bits 
module _map_index_to_display (input [6:0]matrix_idx_x,
															input [5:0]matrix_idx_y,
															output [10:0]display_pos_x,
															output [9:0]display_pos_y);
// here goes your code 
endmodule
 
module _display_to_map_index (input [6:0]display_pos_x,
															input [5:0]display_pos_y,
															output [10:0]matrix_idx_x,
															output [9:0]matrix_idx_y);
endmodule
```

## Position Update Function

```verilog
// this function takes the move direction from the input function
// it also takes the current position (x,y)
// it returns the updated position for any sprite
// it uses Map index to display Helper Function
// it also uses teh valid move detector function to detect if the move is valid 
// it takes the sprite input to specify reset position 
// each sprite will take a certain number
// Pacman         -> 0 
// Blinky (red)   -> 1
// Pinky (pink)   -> 2 
// Inky (cyan)    -> 3
// Clyde (orange) -> 4 
module position_update_function ( input clk,
																	input rst, 
																	input [10:0] curr_pos_x,
																	input [9:0]curr_pos_y,
																	input [3:0] move_direction,
																	input [2:0] which_sprite,
																	output [10:0]new_pos_x,
																	output [9:0]new_pos_y);

endmodule

```

## Ghost Control Function

```verilog
// this function takes the positions of the ghost and the pacman
// return move_direction for the ghost
module ghost_control (input [10:0]ghost_curr_pos_x,
											input [9:0]ghost_curr_pos_y,
											input [10:0]pacman_curr_pos_x,
											input [9:0]pacman_curr_pos_y,
											output [3:0]move_direction);

endmodule
```

## Valid Move Detector

```verilog
// this function takes the position of pacman or ghosts 
// it returns valid moves 
// this module interacts with the block memory 
// it should read the map in the four directions
// it returns the valid moves
// it is one_hot_encoded 
// 0001-> right [most right position is 1]
// 1000-> left
// 0010-> up
// 0100-> down
// 0110 -> it can move up and down but not right and left
module valid_move_detector (input clk,
														input rst, 
														input [10:0]curr_pos_x,
														input [9:0]curr_pos_y, 
														output [3:0] valid_moves);

endmodule 
```

## Collision Detection

```verilog
// this module takes all the positions of a ghost and pacman
// it returns if pacman is dead or not
// it should use the display to matrix index mapping function
module collision_detection (input [10:0]ghost_curr_pos_x,
														input [9:0]ghost_curr_pos_y,
														input [10:0]pacman_curr_pos_x,
														input [9:0]pacman_curr_pos_y,
														output pacman_is_dead);
											

endmodule 
```