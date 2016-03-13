for FILE in *.cl
do
# FILE=$1
cp ../*.rb .
printf "Processing $FILE file...\n"
cool $FILE --class-map --out ref-${FILE%%.*}
ruby main.rb ref-$FILE-ast > $FILE-ast
diff $FILE-ast ref-$FILE-ast > diffs-${FILE%%.*}.txt
cat diffs-${FILE%%.*}.txt
done
