def make_inst_list(tac):
	inst_list = []
	for tac_inst in tac:
		inst = tac_inst.split(' ');
		if inst == 'label':
			label = inst[0]
			inst_list.append(TACLabel(label))
		else if inst == 'jmp':
			label = inst[0]
			inst_list.append(TACLabel(label))
		else if inst == 'bt':
			label = inst[1]
		else if inst == 'return':
		else if inst == 'comment':
		else:



def read_tac(filename):
	f = open(filename)
	tac = []
	for line in f:
		tac.append(line.rstrip('\n').rstrip('\r'))
	f.close()
	return tac

def main():
	filename = sys.argv[1]

	tac = read_tac(filename)
	insts = make_inst_list(tac)
	bbs = make_bbs(insts)


if __name__ == '__main__':
	main()