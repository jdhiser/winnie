#!/bin/bash

python3 ../../harnessgen/synthesizer.py harness -t ./cor1_1/drltrace.*.log  -d ./cor1_1/memdump -s test | tee synharn.c
gcc synharn.c -ldl -fmax-errors=2 -O2 2>&1
