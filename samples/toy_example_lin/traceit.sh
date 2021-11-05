#!/bin/bash 

rm -rf cor1_1/  cor1_2/ core2_1
../../pin/pin -t ../../harnessgen/lib/Tracer/library_trace.so -logdir "cor1_1" -trace_mode "all" -only_to_target "$PWD/toy_example" -only_to_lib "example_library.so" -- ./toy_example in/input
../../pin/pin -t ../../harnessgen/lib/Tracer/library_trace.so -logdir "cor1_2" -trace_mode "all" -only_to_target "$PWD/toy_example" -only_to_lib "example_library.so" -- ./toy_example in/input
../../pin/pin -t ../../harnessgen/lib/Tracer/library_trace.so -logdir "cor2_1" -trace_mode "all" -only_to_target "$PWD/toy_example" -only_to_lib "example_library.so" -- ./toy_example in/input2
../../pin/pin -t ../../harnessgen/lib/Tracer/library_trace.so -logdir "dom" -trace_mode "dominator" -only_to_target "$PWD/toy_example" -only_to_lib "example_library.so" -- ./toy_example in/input2

