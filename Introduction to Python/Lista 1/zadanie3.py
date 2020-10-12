def krzyzyk(n):
	for i in range(n):
		print((n-1)*" ", n*"*", n*" ")
	for i in range(n):
		print(3*n*"*")
	for i in range(n):
		print((n-1)*" ", n*"*", n*" ")
	

print (krzyzyk(4))
