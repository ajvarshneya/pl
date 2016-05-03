cp ../*.ml .

FILE=abort.cl
INPUT=abort.input
printf "Processing %s \n" $FILE
cool $FILE --type --out misc/${FILE%%.*}
ocaml str.cma main.ml misc/$FILE-type > out/$FILE-out
cool $FILE > ref-out/$FILE-out
diff out/$FILE-out ref-out/$FILE-out > diffs/${FILE%%.*}.diff
cat diffs/${FILE%%.*}.diff

FILE=alias.cl
INPUT=${FILE%%.*}.input
printf "Processing %s \n" $FILE
cool $FILE --type --out misc/${FILE%%.*}
ocaml str.cma main.ml misc/$FILE-type > out/$FILE-out
cool $FILE > ref-out/$FILE-out
diff out/$FILE-out ref-out/$FILE-out > diffs/${FILE%%.*}.diff
cat diffs/${FILE%%.*}.diff

FILE=assignments.cl
INPUT=${FILE%%.*}.input
printf "Processing %s \n" $FILE
cool $FILE --type --out misc/${FILE%%.*}
ocaml str.cma main.ml misc/$FILE-type > out/$FILE-out
cool $FILE > ref-out/$FILE-out
diff out/$FILE-out ref-out/$FILE-out > diffs/${FILE%%.*}.diff
cat diffs/${FILE%%.*}.diff

FILE=bigexpr.cl
INPUT=${FILE%%.*}.input
printf "Processing %s \n" $FILE
cool $FILE --type --out misc/${FILE%%.*}
ocaml str.cma main.ml misc/$FILE-type > out/$FILE-out
cool $FILE > ref-out/$FILE-out
diff out/$FILE-out ref-out/$FILE-out > diffs/${FILE%%.*}.diff
cat diffs/${FILE%%.*}.diff
