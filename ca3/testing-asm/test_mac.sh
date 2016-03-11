cp ../*.py .

for FILE in *.cl-type
do
printf "Processing $FILE file...\n"
python main.py $FILE
done
