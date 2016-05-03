#!/bin/bash
for (( i=1; i<=420; i++ ))do
	ocaml str.cma main.ml input-in_int.cl-type < $i-input.txt > out/$i-out.txt
	cool input-in_int.cl < $i-input.txt > ref-out/$i-out.txt
	diff out/$i-out.txt ref-out/$i-out.txt
	printf "%d, " $i
done