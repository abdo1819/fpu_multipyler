import struct ,sys
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
			z2 = struct.pack('>f',float(y[1])).hex() 
			z1 = struct.pack('>f',float(y[0])).hex()
			z_result =struct.pack('>f',float(float(y[0]) * float(y[1]))).hex() 
			print(str(z1)+"_"+str(z2)+"_"+str(z_result))
			if len(sys.argv) ==2:
				if sys.argv[1] == "-t":
					fi = open("testvector.tv","w+")
					fi.write(str(z1)+"_"+str(z2)+"_"+str(z_result)+"\n")
					exit()
				else:
					fi = open("testvector.tv","a+")					
					fi.write(str(z1)+"_"+str(z2)+"_"+str(z_result)+"\n")
