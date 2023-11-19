
import typing as t 
import random 
import json 

def scale_map(dim_horizontal: int, dim_vertical: int, inputfile: str) -> str: 
    print("scaling pacman.......")
    f = open(inputfile, "r")
    lines:  t.List[str]= f.readlines() 
    line_horizontal: int =  len(lines[0])-1 # to skip the endline character
    line_vertical: int = len(lines)  
    # this is in case the new dimensions are not divisible
    # those indices are obtained barely by inspecting
    # and see which columns are safely replicated without 
    # affecting the whole game design 
    rows_horizontal_replicate: t.List[int]= [4,15]
    rows_vertical_replicate: t.List[int] = [2,17]
    rem_horizontal: int= dim_horizontal%line_horizontal
    rem_vertical: int= dim_vertical%line_vertical
    if not(rem_horizontal==0 and (rem_vertical==0)): 
        print("WARNING: the scales don't match it is not divisible. Dims({},{}) FileMatrix({}, {})".format(dim_horizontal, dim_vertical, line_horizontal, line_vertical))
        print ("Replicating those rows {}".format(rows_horizontal_replicate))
        print ("Replicating those columns {}".format(rows_vertical_replicate))
        replication_factor_per_row_horizontal: int=  int (rem_horizontal/len(rows_horizontal_replicate))
        replication_factor_per_row_vertical: int=  int (rem_vertical/len(rows_vertical_replicate))

    scale_factor_horizontal: int = int(dim_horizontal/line_horizontal)
    scale_factor_vertical: int = int(dim_vertical/line_vertical)
    output_str: str=""
    for line_index, x in enumerate(lines):
        one_line=""
        # to remove the endline char, to be added later
        x = x[:-1] if x[-1]=="\n" else x
        for ch_index, ch in enumerate(x): 
            
            one_line= one_line + (ch*scale_factor_horizontal)

            # Replicate when the dimensions do not match
            if ch_index in rows_horizontal_replicate:
                one_line= one_line + (ch*replication_factor_per_row_horizontal)



        # added the endline character that was removed 
        one_line = one_line +"\n"
        output_str= output_str + (one_line * scale_factor_vertical)

        # Replicate when the dimensions do not match 
        if line_index in rows_vertical_replicate: 
            output_str= output_str + (one_line * replication_factor_per_row_vertical)

    # to remove the last endline
    output_str = output_str[:-1] if output_str[-1]=="\n" else output_str

    output_filename: str= "zero_one_map{}_{}.txt".format(dim_horizontal, dim_vertical)
    fwrite= open(output_filename, "w")
    fwrite.write(output_str)
    return output_str

def determine_dot_equal_representation(dim_horizontal: int, dim_vertical: int, zero_one_representation: str) -> str:
    output_str: str= zero_one_representation.replace("0", "=").replace("1", ".")
    output_filename: str= "dot_equal_map{}_{}.txt".format(dim_horizontal, dim_vertical)
    fwrite= open(output_filename, "w")
    fwrite.write(output_str)
    return output_str
    
def _replace_with_char_at_index(original_str: str, index: int, new_char: str):
    string_list = list(original_str)
    string_list[index] = new_char
    new_string = "".join(string_list)
    return new_string

def determine_random_positions(dim_horizontal: int, dim_vertical: int, dot_equal_representation: str):
    game_characters: int= ['M', 'P', "B", "I", "C"]
    idx_horizontal: int 
    idx_vertical: int  

    # 1280/80; 800/50
    # display:= 1280 X 800
    # matrix:= 80 X 50
    DISPLAY_MAT_FACTOR: int = 16
    MOVE_TO_CENTER: int= 7 
    START_H_VISIBLE: int= 336
    START_V_VISIBLE: int= 27

    all_default_positions={}


    display_pos_horizontal: int 
    display_pos_vertical: int 
    # game_char_index: int =0 
    for game_character in game_characters: 
        found_flag: bool= False
        local_positions= {}
        while not found_flag: 
            idx_horizontal= random.randint(0, dim_horizontal - 1)
            idx_vertical= random.randint(0, dim_vertical - 1)
            print ("idx_horizontal: {}, idx_vertical: {}, string length: {}".format(idx_horizontal, idx_vertical, len(dot_wall_representation)))
            # added one to account for the endline character
            str_idx= idx_horizontal * (dim_vertical+1) + idx_vertical
            if dot_equal_representation[str_idx] == '.':
                found_flag = True 
                # replace the dot with the corresponding character

                dot_equal_representation = _replace_with_char_at_index(dot_equal_representation, str_idx, game_character)
                local_positions ["matrix_index_pos"] = (idx_horizontal, idx_vertical)

                display_pos_horizontal= idx_horizontal * DISPLAY_MAT_FACTOR + MOVE_TO_CENTER + START_H_VISIBLE
                display_pos_vertical= idx_vertical * DISPLAY_MAT_FACTOR + MOVE_TO_CENTER + START_V_VISIBLE

                local_positions ["display_pos"] = (display_pos_horizontal, display_pos_vertical)
                all_default_positions [game_character] = local_positions

    map_filename: str= "character_dot_equal_map{}_{}.txt".format(dim_horizontal, dim_vertical)
    fwrite= open(map_filename, "w")
    fwrite.write(dot_equal_representation)

    rand_pos_filename: str= "random_positions_map{}_{}.txt".format(dim_horizontal, dim_vertical)
    # json_object= json.loads(default_positions)
    pretty_json= json.dumps(all_default_positions, indent=2)
    fwrite= open(rand_pos_filename, "w")
    fwrite.write(pretty_json)

    return dot_equal_representation
                
            



if __name__ == "__main__":

    dim_horizontal: int
    dim_vertical: int 

    (dim_horizontal, dim_vertical) = (80, 50)
    # zero -> wall 
    # 1-> food 
    zero_one_representation: str= scale_map(dim_horizontal,dim_vertical,"map20_20.txt")
    dot_wall_representation: str= determine_dot_equal_representation(dim_horizontal, dim_vertical,zero_one_representation )
    random_positions_pacman: str= determine_random_positions(dim_horizontal, dim_vertical, dot_wall_representation)