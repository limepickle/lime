import threading
import time

def fact(n):
	print("In thread 1 and ")
	time.sleep(1)
	if n == 1:
		return 1
	return fact(n-1)*n

def fib(n):
	print(" thread 2")
	time.sleep(1)
	if n == 0:
		return 0
	elif n == 1:
		return 1
	return fib(n-1)+fib(n-2)
	
	
if __name__ == "__main__":
	
	t1 = threading.Thread(target=fact,args=(9,))
	t2 = threading.Thread(target=fib,args=(4,))
	
	t1.start()
	t2.start()
	
	t1.join()
	t2.join()
