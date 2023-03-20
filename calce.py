#
#     Created by: Justin Stewart
#     Email: stewartm.justin@outlook.com
#

import numpy

#Print e to n significant digits to the file
def keepe(n, fname, d):
	f = open(fname, "w")
	f.write(str(d[0]) + ".")
	for x in range(1, n, 1):
		f.write(str(d[x]))

#calculate e to n siginficant digits
def ecalculation(n, fname):
	m = 4
	test = (n + 1) * 2.30258509

	while (float(m) * (numpy.log(m) - 1.0) + 0.5 * numpy.log(6.2831852 * float(m))) <= float(test):
		m = m + 1
	coef = []

	for j in range(0, m - 1, 1):
	   coef.append(1)

	#d[] holds e to n sigificant digits
	d = [2]

	for i in range(1, n + 1, 1):
	   carry = 0
	   for j in range(m, 1, -1):
	   	temp = int(coef[j - 2] * 10 + carry);
	   	carry = int(temp/j);
	   	coef[j - 2] = int(temp - carry * j);
	   d.append(int(carry))
	
	keepe(n, fname, d)

#collect the number of sigificant digits and a file name from the user
#and call all other subprograms
n = input("Enter the number of significant digits to calculate:");
n = int(n);
fname = input("Enter the output location file-name:");
ecalculation(n, fname)