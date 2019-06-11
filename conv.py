import struct
import sys
import random

class converter():
    ''' creating test vctor with special cases '''
    zero ='fds'
    def __init__(self):
        '''initialize for special cases out as hex
            # use case
            > from conv import converter as c
            > print(c.inf)
             '7F800000'
        '''
        self.zero = float('0')
        self.zero_ = float('-0')
        self.inf =  float('inf')
        self.inf_=  float('-inf')
        self.undef =float('NAN')

    def f_h(self,f):
        '''convert floating numbers into 32'bit hex format 
        example :
        > from conv import converter as c
        > print(c.f_h(1.25))
        '''
        return struct.pack('>f',f).hex() 
    
    def special(self):
        ''' generating list of all multiplication special cases
            as string  in format  xxxxxxxx_xxxxxxxx_xxxxxxxx
            # useing example for test vector
            > f = open('mult.tv','w') 
            > for row in c.special_mult():
            >    f.write(row+'\\n')
            > f.close()
        '''
  
        sp = [self.zero,self.zero_,self.inf,self.inf_,self.undef]
        special_hex = []
        for i in sp:
            for j in sp:
                special_hex.append(self.f_h(i)+'_'+self.f_h(j)+'_'+self.f_h(i*j))
        return special_hex

                

    
    def randomtest_multi(self, n):
        random_hex =[]
        for i in range(n):
            f1 = random.random()
            f2 = random.random()
            random_hex.append(self.f_h(f1)+'_'+self.f_h(f2)+'_'+self.f_h(f1*f2))
        return random_hex

            
if __name__ == "__main__":
    n=sys.argv
    c = converter()
    if len(n) == 3:    
        f1 = float(n[1])
        f2 = float(n[2])
        print(c.f_h(f1),'_',c.f_h(f2),'_',c.f_h(f1*f2),sep='')
    
    f = open('mult.tv','w') #write in new file
    for row in c.special():
        f.write(row+'\n')

    for row in c.randomtest_multi(20):
        f.write(row+'\n')

    f.close()


