#!/bin/bash

ast_ext="-ast"

echo "Running..."
for source_file in "$@"
do
	echo "$source_file"
	ast_file=$source_file$ast_ext

	# Generate the parse file
	cool --parse $source_file

	# Generate the error while making the type file
	cool --type $source_file

	# Run main.rb on the file
	ruby main.rb $ast_file

	echo
done
echo "Complete"