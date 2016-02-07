for FILE in *.cl
do
  printf "Processing $FILE file...\n"
  cool $FILE --lex --out ref-${FILE%%.*}
  node main.js $FILE
  diff $FILE-lex ref-$FILE-lex > diffs-${FILE%%.*}.txt
done
