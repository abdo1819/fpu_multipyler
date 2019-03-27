def build(exp, fra,sign):
    exp +=127
    if(sign == 1):
        sign = 0
    else:
        sign = 1
    print(sign,bin(exp)[2:],fra)

build(-1,000,1)
