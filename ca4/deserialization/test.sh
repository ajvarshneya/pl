cp ../*.py .

for FILE in *.cl
do
	# FILE=$1
	cool $FILE --type --out misc/ref-${FILE%%.*}
	python main.py misc/ref-$FILE-type > misc/$FILE-type
	diff misc/$FILE-type misc/ref-$FILE-type > diffs/${FILE%%.*}.diffs
	cat diffs/${FILE%%.*}.diffs
done
