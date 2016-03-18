for FILE in *.cl
do
	# FILE=$1
	cp ../*.rb .
	printf "Processing $FILE file...\n"
	cool $FILE --parse --out ref-${FILE%%.*}
	cool $FILE --class-map --out ref-${FILE%%.*}
	ruby main.rb ref-$FILE-ast > $FILE-type
	diff $FILE-type ref-$FILE-type > diffs-${FILE%%.*}.txt
	# cat $FILE-type
	cat diffs-${FILE%%.*}.txt
done
