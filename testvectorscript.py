import ctypes ,sys
if len(sys.argv) > 2:
	print("invalid arguments!")
else:
	if len(sys.argv)==1:
		sys.argv.append(" ")
	while True:
		x = input()
		x.replace(" ","")
		y=x.split("*")
		if len(y)!=2:
			print("use 2 operands")
		else:
			z2 = ctypes.c_int32.from_buffer(ctypes.c_float(int(y[1]))).value
			z1 = ctypes.c_int32.from_buffer(ctypes.c_float(int(y[0]))).value
			z_result = ctypes.c_int32.from_buffer(ctypes.c_float(int(y[0]) * int(y[1]))).value
			print(hex(z1)+"_"+hex(z2)+"_"+hex(z_result))
			fi = 0
			if len(sys.argv) ==2:
				if sys.argv[1] == "-t":
					fi = open("testvector.tv","w+")
					fi.write(hex(z1)+"_"+hex(z2)+"_"+hex(z_result))
					exit()
				else:
					print("invalid argument")
					exit()
			else:
				fi = open("testvector.tv","a+")					
				fi.write(hex(z1)+"_"+hex(z2)+"_"+hex(z_result))