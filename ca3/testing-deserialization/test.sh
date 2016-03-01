for FILE in *.cl
do
# FILE=$1
cp ../main.py .
cp ../nodes.py .
cp ../tacs.py .
printf "Processing $FILE file...\n"
cool $FILE --parse --out ref-${FILE%%.*}
cool $FILE --type --out ref-${FILE%%.*}
python main.py ref-$FILE-type > $FILE-ast
diff $FILE-ast ref-$FILE-ast > diffs-${FILE%%.*}.txt
cat diffs-${FILE%%.*}.txt
done
