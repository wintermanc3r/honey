#!/usr/bin/python3

with open("AS_results", "r") as f:
    for line in f:
        if line[0:3] != "AS ":
            print(line, end="")
