# for FILE in *.cl
# do
FILE=$1
printf "Processing $FILE file...\n"
cool $FILE --parse --out ref-${FILE%%.*}
cool $FILE --lex --out ref-${FILE%%.*}
python main.py $FILE-lex
diff $FILE-ast ref-$FILE-ast > diffs-${FILE%%.*}.txt
# done
