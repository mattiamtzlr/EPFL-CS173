#!/bin/bash

iverilog -o $1.out $1.v $1_tb.v
./$1.out
