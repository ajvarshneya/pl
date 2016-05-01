FILE=$1
printf "Processing %s \n" $FILE
cool $FILE --type --out misc/${FILE%%.*}
ocaml str.cma main.ml misc/$FILE-type
printf "\n"
