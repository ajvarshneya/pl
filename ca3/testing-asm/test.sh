cool big_test.cl --type
cool div.cl --type
cool less_than.cl --type
cool multi_spill.cl --type
cool overflow_in_int.cl --type
cool small_test3.cl --type
cool unit_if.cl --type
cool unit_in_int.cl --type
cool unit_while.cl --type
cool big_test2.cl --type
cool div_params.cl --type
cool many_registers.cl --type
cool overflow_add.cl --type
cool overflow_mult.cl --type
cool unit_arith.cl --type
cool unit_if_2.cl --type
cool unit_out_int.cl --type
cool comp_bool.cl --type
cool io.cl --type
cool min.cl --type
cool overflow_combined.cl --type
cool overflow_sub.cl --type
cool unit_comp.cl --type
cool unit_if_3.cl --type
cool unit_plus.cl --type

python main.py big_test.cl-type > big_test.s
python main.py div.cl-type > div.s
python main.py less_than.cl-type > less_than.s
python main.py multi_spill.cl-type > multi_spill.s
python main.py overflow_in_int.cl-type > overflow_in_int.s
python main.py small_test3.cl-type > small_test3.s
python main.py unit_if.cl-type > unit_if.s
python main.py unit_in_int.cl-type > unit_in_int.s
python main.py unit_while.cl-type > unit_while.s
python main.py big_test2.cl-type > big_test2.s
python main.py div_params.cl-type > div_params.s
python main.py many_registers.cl-type > many_registers.s
python main.py overflow_add.cl-type > overflow_add.s
python main.py overflow_mult.cl-type > overflow_mult.s
python main.py unit_arith.cl-type > unit_arith.s
python main.py unit_if_2.cl-type > unit_if_2.s
python main.py unit_out_int.cl-type > unit_out_int.s
python main.py comp_bool.cl-type > comp_bool.s
python main.py io.cl-type > io.s
python main.py min.cl-type > min.s
python main.py overflow_combined.cl-type > overflow_combined.s
python main.py overflow_sub.cl-type > overflow_sub.s
python main.py unit_comp.cl-type > unit_comp.s
python main.py unit_if_3.cl-type > unit_if_3.s
python main.py unit_plus.cl-type > unit_plus.s

sudo gcc big_test.s 
cool big_test.cl
sudo gcc div.s 
cool div.cl
sudo gcc less_than.s 
cool less_than.cl
sudo gcc multi_spill.s 
cool multi_spill.cl
sudo gcc overflow_in_int.s 
cool overflow_in_int.cl
sudo gcc small_test3.s 
cool small_test3.cl
sudo gcc unit_if.s 
cool unit_if.cl
sudo gcc unit_in_int.s 
cool unit_in_int.cl
sudo gcc unit_while.s 
cool unit_while.cl
sudo gcc big_test2.s 
cool big_test2.cl
sudo gcc div_params.s 
cool div_params.cl
sudo gcc many_registers.s 
cool many_registers.cl
sudo gcc overflow_add.s 
cool overflow_add.cl
sudo gcc overflow_mult.s 
cool overflow_mult.cl
sudo gcc unit_arith.s 
cool unit_arith.cl
sudo gcc unit_if_2.s 
cool unit_if_2.cl
sudo gcc unit_out_int.s 
cool unit_out_int.cl
sudo gcc comp_bool.s 
cool comp_bool.cl
sudo gcc io.s 
cool io.cl
sudo gcc min.s 
cool min.cl
sudo gcc overflow_combined.s 
cool overflow_combined.cl
sudo gcc overflow_sub.s 
cool overflow_sub.cl
sudo gcc unit_comp.s 
cool unit_comp.cl
sudo gcc unit_if_3.s 
cool unit_if_3.cl
sudo gcc unit_plus.s 
cool unit_plus.cl

sudo gcc $FILE
./a.out > $FILE-out1.txt
cool $FILE > $FILE-out2.txt
diff $FILE-out1.txt $FILE-out2.txt > $FILE.diff