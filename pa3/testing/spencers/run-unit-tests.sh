#!/bin/bash

echo "Running..."
ref_file_ext="_ref.cl-ast"
out_file_ext="_out.cl-ast"
for input_file in *.test
do
	filename_length=${#input_file}
	file_base=${input_file:0:(filename_length-5)}

	# Ref file: <name>_ref.cl-ast
	ref_file=$file_base$ref_file_ext

	# Out file: <name>_out.cl-ast
	out_file=$file_base$out_file_ext

	# Run parser on input file
	python2.6 main.py $input_file > $out_file

	# Calculate the difference between the files
	if ! diff -q -b -B -E -w $ref_file $out_file > /dev/null ; then
		echo "FAILED: $input_file"
	else
		# echo "PASSED: $input_file"
		rm $out_file
	fi
done
echo "Done"