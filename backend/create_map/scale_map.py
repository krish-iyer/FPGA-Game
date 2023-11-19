
import typing as t 

def scale_map(dim_x: int, dim_y: int, inputfile: str) -> str: 
    print("scaling pacman.......")
    f = open(inputfile, "r")
    lines:  t.List[str]= f.readlines() 
    line_x: int = len(lines[0])-1 # to skip the endline character
    line_y: int = len(lines)
    # this is in case the new dimensions are not divisible
    # those indices are obtained barely by inspecting
    # and see which columns are safely replicated without 
    # affecting the whole game design 
    rows_x_replicate: t.List[int]= [2,17]
    rows_y_replicate: t.List[int] = [4,15]
    rem_x: int= dim_x%line_x
    rem_y: int= dim_y%line_y
    if not(rem_x==0 and (rem_y==0)): 
        print("WARNING: the scales don't match it is not divisible. Dims({},{}) FileMatrix({}, {})".format(dim_x, dim_y, line_x, line_y))
        print ("Replicating those rows {}".format(rows_x_replicate))
        print ("Replicating those columns {}".format(rows_y_replicate))
        replication_factor_per_row_x: int=  int (rem_x/len(rows_x_replicate))
        replication_factor_per_row_y: int=  int (rem_y/len(rows_y_replicate))

    scale_factor_x: int = int(dim_x/line_x)
    scale_factor_y: int = int(dim_y/line_y)
    output_str: str=""
    for line_index, x in enumerate(lines):
        one_line=""
        # to remove the endline char, to be added later
        x = x[:-1] if x[-1]=="\n" else x
        for ch_index, ch in enumerate(x): 
            
            one_line= one_line + (ch*scale_factor_x)

            # Replicate when the dimensions do not match
            if ch_index in rows_y_replicate:
                one_line= one_line + (ch*replication_factor_per_row_y)



        # added the endline character that was removed 
        one_line = one_line +"\n"
        output_str= output_str + (one_line * scale_factor_y)

        # Replicate when the dimensions do not match 
        if line_index in rows_x_replicate: 
            output_str= output_str + (one_line * replication_factor_per_row_x)

    # to remove the last endline
    output_str = output_str[:-1] if output_str[-1]=="\n" else output_str

    output_filename: str= "zero_one_map{}_{}.txt".format(dim_x, dim_y)
    fwrite= open(output_filename, "w")
    fwrite.write(output_str)
    return output_str

def determine_dot_equal_representation(dim_x: int, dim_y: int, zero_one_representation: str) -> str:
    output_str: str= zero_one_representation.replace("0", "=").replace("1", ".")
    output_filename: str= "dot_equal_map{}_{}.txt".format(dim_x, dim_y)
    fwrite= open(output_filename, "w")
    fwrite.write(output_str)
    return output_str



if __name__ == "__main__":

    dim_x: int
    dim_y: int 

    (dim_x, dim_y) = (80, 50)
    # zero -> wall 
    # 1-> food 
    zero_one_representation: str= scale_map(dim_x,dim_y,"map20_20.txt")
    dot_wall_representation: str= determine_dot_equal_representation(dim_x, dim_y,zero_one_representation )
    # random_positions_pacman: str= random_positions_pacman()