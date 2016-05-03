#!/bin/bash
for (( i=1; i<=420; i++ ))do
	ocaml str.cma main.ml input-in_string.cl-type < $i-s-input.txt > out/$i-s-out.txt
	cool input-in_string.cl < $i-s-input.txt > ref-out/$i-s-out.txt
	diff out/$i-s-out.txt ref-out/$i-s-out.txt
	printf "%d, " $i
done