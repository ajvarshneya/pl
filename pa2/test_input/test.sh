for FILE in *.cl
do
  echo "Processing $FILE file..."
  cool $FILE --lex --out ref-${FILE%%.*}
  node main.js $FILE
  diff $FILE-lex ref-$FILE-lex > diffs-${FILE%%.*}.txt
done
