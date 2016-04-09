# refresh programs
cp ../*.py .

for FILE in *.cl
do
	# get annotated ast/assembly
	cool $FILE --type
	python main.py $FILE-type

	# assemble
	sudo gcc ${FILE%%.*}.s

	# execute programs
	cool $FILE < $FILE-input > $FILE-out1
	./a.out < $FILE-input > $FILE-out2

	# get diff
	diff $FILE-out1 $FILE-out2 > ${FILE%%.*}.diff

done