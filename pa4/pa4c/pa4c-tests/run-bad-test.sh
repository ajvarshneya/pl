#!/bin/bash

ast_ext="-ast"
type_ext="-type"
cp ../../*.rb .
echo "Running..."
for source_file in bad*.cl
do
	echo "$source_file"
	ast_file=$source_file$ast_ext

	# # Generate the parse file
	cool --parse $source_file

	# # Generate the error while making the type file
	cool --type $source_file > ref-$source_file-error

	# # Run main.rb on the file
	ruby main.rb $ast_file > $source_file-error

	diff $source_file-error ref-$source_file-error > diff-$source_file-error

	cat diff-$source_file-error
	# echo
done
echo "Complete"