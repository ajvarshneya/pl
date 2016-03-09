cp ../*.py .

for FILE in *.cl-type
do
python main.py $FILE
cool $FILE > ref-${FILE%%.*}.txt
done
