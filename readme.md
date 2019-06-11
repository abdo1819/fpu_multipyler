# 32 bit fpu_multiplier

## moudule [mult.sv](file://mult.sv)
can do 32 bit floating point multiplication
with care about special cases  can be tested with [testbench.sv](file://testbench.sv)

## [testbench.sv](file://testbench.sv)
for testing the muodule using input and out from test vector [mult.tv](file://mult.tv)

## [mult.tv](file://mult.tv)
test vector for multiplication containing input and expected output for
special cases _16 lines
random numbers _20 lines
random with special _40 lines
those can be generated using conv.py

## [conv.py](file://conv.py)
python module containing some help scripts with project 

### use case
* to generate test vector
> python conv.py

* to convert a float to 32 hex number
```python
>>> from conv import converter
>>> c = converter.f_h(1.25)
1.25
```
 
* for extra help
```python
>>> from conv import converter
>>> help(converter)
Help on class converter in module conv:

class converter(builtins.object)
 |  creating test vctor with special cases
 |  
 |  Methods defined here:
 |  
 |  __init__(self)
 |      initialize for special cases out as hex
 |      # use case
 |      > from conv import converter as c
 |      > print(c.inf)
 |       '7F800000'
 |  
 |  
 |  f_h(self, f)
 |      convert floating numbers into 32'bit hex format 
 |      example :
 |      > from conv import converter as c
 |      > print(c.f_h(1.25))
 |  
 |  randomtest_multi(self, n)
 |  
 |  special(self)
 |      generating list of all multiplication special cases
 |      as string  in format  xxxxxxxx_xxxxxxxx_xxxxxxxx
 |      # useing example for test vector
 |      > f = open('mult.tv','w') 
 |      > for row in c.special_mult():
 |      >    f.write(row+'\n')
 |      > f.close()
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __dict__
 |      dictionary for instance variables (if defined)
 |  
 |  __weakref__
 |      list of weak references to the object (if defined)
 |  
 |  ----------------------------------------------------------------------
 |  Data and other attributes defined here:
```
