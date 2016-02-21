for FILE in *.cl
do
# FILE=$1
cp ../mylex.py .
cp ../main.py .
cp ../nodes.py .
printf "Processing $FILE file...\n"
cool $FILE --parse --out ref-${FILE%%.*}
cool $FILE --lex --out ${FILE%%.*}
python main.py $FILE-lex
diff $FILE-ast ref-$FILE-ast > diffs-${FILE%%.*}.txt
# cat diffs-${FILE%%.*}.txt
done
