for FILE in *.cl
do
# FILE=$1
cp ../main.py .
cp ../nodes.py .
printf "Processing $FILE file...\n"
cool $FILE --parse --out ref-${FILE%%.*}
python main.py ref-$FILE-ast > $FILE-ast
diff $FILE-ast ref-$FILE-ast > diffs-${FILE%%.*}.txt
# cat diffs-${FILE%%.*}.txt
done
