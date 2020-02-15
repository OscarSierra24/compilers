#!/usr/bin/python

import sys
import re

file_path = sys.argv[1]

# Instructions and its freq
ins_frq = {}
# functions and virtual address
funct_virtaddr = {}

RE_LINE_FUNCTION = r"(?P<virtaddr>[0-9a-f]{16}) <(?P<funct>.*)>:"
RE_LINE_INSTR = r"\s[0-9a-f]{3}:\t(([0-9a-f]{2}\s)*)\s*(?P<instr>[a-z]+)"

f = open(file_path, "r")
for line in f:
  line_match_function = re.match(RE_LINE_FUNCTION, line)
  if line_match_function:
    d = line_match_function.groupdict()
    funct_virtaddr[d["funct"]] = d["virtaddr"]

  line_match_instr = re.match(RE_LINE_INSTR, line)
  if line_match_instr:
    d = line_match_instr.groupdict()
    ins_frq[d["instr"]] = ins_frq.get(d["instr"], 0) + 1

f.close()

print("Hi, this is the output of the analysis:")
print(" You have %d kind of instructions in this object file:" % len(ins_frq))
for instr, freq in ins_frq.items():
  print("\t%s\t: Executed %s times" % (instr, freq))
print(" You have %d functions:" % len(funct_virtaddr))
for funct, virtaddr in funct_virtaddr.items():
  print("\t%s: Located at %s addr" % (funct, virtaddr))
