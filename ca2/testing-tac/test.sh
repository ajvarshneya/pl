# for FILE in *.cl
# do
FILE=$1
cp ../main.py .
cp ../nodes.py .
cp ../tacs.py .
# printf "Processing $FILE file...\n"
cool $FILE --parse --out ref-${FILE%%.*}
python main.py ref-$FILE-ast
# cool $FILE-tac
# diff $FILE-ast ref-$FILE-ast > diffs-${FILE%%.*}.txt
# cat diffs-${FILE%%.*}.txt
# done
