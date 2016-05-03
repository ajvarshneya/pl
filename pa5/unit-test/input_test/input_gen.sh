#!/bin/bash
for (( i=1; i<=420; i++ ))do
	python int_input.py > $i-input.txt
	printf "%d, " $i
done