for FILE in *.cl
do
	# FILE=$1
	cp ../*.rb .
	printf "Processing $FILE file...\n"
	
	# eliminates annoying error message
	echo " " > misc/ref-$FILE-type
	echo " " > misc/$FILE-type

	# parse/typecheck the file w/ reference
	cool $FILE --parse --out misc/${FILE%%.*}
	cool $FILE --type --out misc/ref-${FILE%%.*}

	# typecheck with mine
	ruby main.rb misc/$FILE-ast

	# compare the differences if anything printed
	diff misc/$FILE-type misc/ref-$FILE-type > diffs/${FILE%%.*}.diff
	# cat $FILE-type
	# cat diffs-${FILE%%.*}.txt
done
