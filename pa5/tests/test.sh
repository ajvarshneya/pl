cp ../*.ml .

for FILE in *.cl
do
	printf "Processing %s \n" $FILE
	cool $FILE --type --out misc/${FILE%%.*}
	ocaml str.cma main.ml misc/$FILE-type
	printf "\n"
done
