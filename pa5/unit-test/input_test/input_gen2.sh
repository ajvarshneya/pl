#!/bin/bash
for (( i=1; i<=420; i++ ))do
	python string_input.py > $i-s-input.txt
	printf "%d, " $i
done