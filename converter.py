import struct
def covert(f):
    return struct.pack('>f', f).hex()


if __name__ == "__main__":
    print(covert(1.455))
    print(float(1.465).hex())
