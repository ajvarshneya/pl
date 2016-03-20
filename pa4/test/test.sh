for FILE in *.cl
do
	# FILE=$1
	cp ../*.rb .
	printf "Processing $FILE file...\n"
	cool $FILE --parse --out misc/${FILE%%.*}
	cool $FILE --type --out misc/ref-${FILE%%.*}
	ruby main.rb misc/$FILE-ast > misc/$FILE-type
	diff misc/$FILE-type misc/ref-$FILE-type > diffs/diffs-${FILE%%.*}.txt
	# cat $FILE-type
	# cat diffs-${FILE%%.*}.txt
done
