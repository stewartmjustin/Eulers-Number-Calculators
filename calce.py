import numpy

def keepe(n, fname):
	m = 4
	test = (n + 1) * 2.30258509
	while (float(m) * (numpy.log(m) - 1.0) + 0.5 * numpy.log(6.2831852 * float(m))) <= float(test):
		m = m + 1
	coef = []
	for j in range(0, m - 1, 1):
	   coef.append(1)
	d = [2]
	for i in range(1, n + 1, 1):
	   carry = 0
	   for j in range(m, 1, -1):
	   	temp = coef[j - 2] * 10 + carry
	   	carry = temp/j
	   	coef[j - 2] = temp - carry * j
	   d.append(carry)
	f = open(fname, "w")
	f.write(str(d[0]) + ".")
	for x in range(1, n, 1):
		f.write(str(d[x]))

n = input("Enter the number of significant digits to calculate:")
fname = raw_input("Enter the output location file-name:")
keepe(n, fname)