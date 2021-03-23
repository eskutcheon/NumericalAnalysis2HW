import numpy as np

def get_matrix():
	N = int(input("Dimensions of this NxN matrix? N = "))
	print("Enter a banded matrix, one row vector at a time, separated by spaces, pressing ENTER after each vector:")
	# get N lines of row vectors, splitting at spaces, convert to float, arrange as list, then insert list into 2D numpy array
	matrix_A = np.array([list(map(float, input().split(" "))) for _ in range(N)])
	print("Matrix A = ")
	print(matrix_A)
	return matrix_A

def get_diagonals(bands):
	temp_mat = get_matrix()
	band_range = range(bands[0], -1*bands[1]-1, -1)
	diags = np.array([temp_mat.diagonal(i) for i in band_range])
	return diags

def get_bands():
	print("Enter the upper bandwidth for your banded matrix.")
	p = int(input("p = "))
	print("Enter the lower bandwidth for your banded matrix.")
	q = int(input("q = "))
	return p, q # returns bandwidths in a tuple

# part a
# finds LU decomposition of a tridiagonal matrix, returning L and U
def tridiaglu(A):
	sup_u = np.copy(A[0]) # superdiagonal of U, initialized with super-diag of A
	main_u = np.copy(A[1]) # main diagonal of U from main diagonal of A
	sub_l = np.copy(A[2]) # instantiates deep copy of subdiagonal of L
	N = main_u.size # dimension size of original matrix
	# Also, see TDMA or Thomas Algorithm
	for k in range(N-1): # algorithm for tridiagonal matrix factorization
		sub_l[k] = sub_l[k]/main_u[k]
		main_u[k+1] = main_u[k+1]-(sub_l[k]*sup_u[k])
	L = np.diagflat(sub_l, -1) # creates matrix L with subdiagonal sub_l
	L[np.diag_indices(N)] = 1 # fills main diagonal with 1
	print("L =")
	print(L)
	U = np.diagflat(main_u) # creates matrix with main diagonal main_u
	for i in range(N-1):
		U.flat[i*(N+1)+1] = sup_u[i] # couldn't get diag_indices working right here,
		# so I instead flattened it and accessed the superdiagonal indices
	print("U = ")
	print(U)
	return L, U # returns L and U in a tuple

# part b
def bandedlu(A, p, q):
	n = A.shape[0]-1
	L = np.eye(n+1)
	for j in range(n): # from j=0:m-2 where m is the user input of dimension
		phat = min(n, j+p) # uses j+p up until j+p > n
		qhat = min(n, j+q)
		for k in range(j+1,qhat+1): # begins each iteration at first nonzero row element
			L[k][j] = ((A[k][j])/(A[j][j])) # saves subdiagonals of L
			for m in range(j+1,phat+1): # begins at first nonzero column element
				A[k][m] = A[k][m] - ((L[k][j])*(A[j][m])) # performs elimination on A for the remaining "U" part
	return L, np.triu(A) 
	

t_decomp = tridiaglu(get_diagonals((1,1)))
np.set_printoptions(precision = 4)
bands = get_bands()
b_decomp = bandedlu(get_matrix(), bands[0], bands[1])

# Future fixes: improve modularity with class definition with option for more comprehensive user input
	# Optimize for processing diagonal vectors

# part c:
	# LU Decomposition of tridiagonal matrices processed in the manner of tridiaglu takes O(n) flops
	# LU Decomposition of band matrices processed in the manner of bandedlu takes O(npq) flops