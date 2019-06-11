import struct
import sys

class converter():
    ''' creating test vctor with special cases '''
    zero ='fds'
    def __init__(self):
        self.zero = '00000000'
        self.inf =  '7F800000'
        self.inf_=  'FF800000'
        self.undef ='7F800001'

    def f_h(self,f):
        '''convert floating numbers into 32'bit hex format '''
        return struct.pack('>f',f).hex() 
    
    def special(self):
        special = [self.zero,self.inf,self.inf_,self.undef]
        special_hex = []
        for i in special:
            for j in special:
                if (i == self.undef or j == self.undef):#undef,any -> undef
                    out = self.undef
                elif((i == self.inf and j == self.zero) or (j == self.inf and i == self.zero) or
                    (i == self.inf_ and j == self.zero) or (j == self.inf_ and i == self.zero)):
                    out = self.undef
                elif(i == self.inf and j== self.inf)or(i == self.inf_ and j== self.inf_):
                    out = self.inf
                elif (i == self.inf_ and j== self.inf)or (i == self.inf and j== self.inf_):
                    out = self.inf_
                elif (i == self.zero or j == self.zero):
                    out = self.zero
                else:
                    out = 'error'

                special_hex.append(i+'_'+j+'_'+out)
        return special_hex



    def print_(self):
        print(self.zero+'_'+self.inf+'_'+self.inf_+'_'+self.undef)

            
if __name__ == "__main__":
    n=sys.argv
    c = converter()
    if len(n) == 3:    
        f1 = float(n[1])
        f2 = float(n[2])
        print(c.f_h(f1),'_',c.f_h(f2),'_',c.f_h(f1*f2),sep='')
    
    f = open('mult.tv','w')
    for row in c.special():
        f.write(row+'\n')
    f.close()


