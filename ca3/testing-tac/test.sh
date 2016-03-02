# for FILE in *.cl
# do
FILE=$1
cp ../main.py .
cp ../ast.py .
cp ../ast_gen.py .
cp ../tacs.py .
cp ../tacs_gen.py .
printf "Processing $FILE file...\n"
cool $FILE --tac --out ref-${FILE%%.*}
cool $FILE --type --out ref-${FILE%%.*}
python main.py ref-$FILE-type > $FILE-tac
cool $FILE-tac
# cool $FILE > ref-$FILE-out
# diff $FILE-out ref-$FILE-out > diffs-${FILE%%.*}.txt
# cat diffs-${FILE%%.*}.txt
# done
 