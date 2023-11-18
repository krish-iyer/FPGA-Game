
import typing as t 

def scale_map(dim_x: int, dim_y: int, inputfile: str, outputfile: str): 
    print("scaling pacman.......")
    f = open(inputfile, "r")
    lines:  t.List[str]= f.readlines() 
    line_x: int = len(lines[0])-1 # to skip the endline character
    line_y: int = len(lines)

    if not(dim_x%line_x==0 and (dim_y%line_y==0)): 
        print("the scales don't match it is not divisible. Dims({},{}) FileMatrix({}, {})".format(dim_x, dim_y, line_x, line_y))
        exit(0)

    scale_factor_x: int = int(dim_x/line_x)
    scale_factor_y: int = int(dim_y/line_y)
    output_str: str=""
    for x in lines:
        one_line=""
        # to remove the endline char, to be added later
        x = x[:-1] if x[-1]=="\n" else x
        for ch in x: 
            
            one_line= one_line + (ch*scale_factor_x)

        # added the endline character that was removed 
        one_line = one_line +"\n"
        output_str= output_str + (one_line * scale_factor_y)

    # to remove the last endline
    output_str = output_str[:-1] if output_str[-1]=="\n" else output_str
    fwrite= open(outputfile, "w")
    fwrite.write(output_str)
            
        



if __name__ == "__main__":
    scale_map(40,40,"map20_20.txt", "map1280_80.txt")