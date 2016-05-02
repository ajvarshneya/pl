FILE=$1
printf "Processing %s \n" $FILE
cool $FILE --type --out misc/${FILE%%.*}
ocaml str.cma main.ml misc/$FILE-type > out/$FILE-out
cool $FILE > ref-out/$FILE-out
diff out/$FILE-out ref-out/$FILE-out > diffs/${FILE%%.*}.diff
cat diffs/${FILE%%.*}.diff
