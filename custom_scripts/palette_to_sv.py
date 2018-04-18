count = 0
out = open("mapper.txt", 'w')
with open("palette.txt") as f:
    for line in f:
        out.write("16'd" + str(count) + ":\n")
        out.write("begin\n")
        out.write("\tVGA_R = 8'h" + str(line[2]) + str(line[3]) + ";\n")
        out.write("\tVGA_G = 8'h" + str(line[4]) + str(line[5]) + ";\n")
        out.write("\tVGA_B = 8'h" + str(line[6]) + str(line[7]) + ";\n")
        out.write("end\n")
        count += 1
out.write("default:\n")
out.write("begin\n")
out.write("\tVGA_R = 8'h00;\n")
out.write("\tVGA_G = 8'h00;\n")
out.write("\tVGA_B = 8'h00;\n")
out.write("end\n")
