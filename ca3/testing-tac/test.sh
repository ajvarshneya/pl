# for FILE in *.cl
# do
FILE=$1
cp ../main.py .
cp ../ast.py .
cp ../ast_gen.py .
cp ../tacs.py .
cp ../tacs_gen.py .
# printf "Processing $FILE file...\n"
cool $FILE --type --out ref-${FILE%%.*}
python main.py ref-$FILE-type
# cool $FILE-tac
# diff $FILE-ast ref-$FILE-ast > diffs-${FILE%%.*}.txt
# cat diffs-${FILE%%.*}.txt
# done
