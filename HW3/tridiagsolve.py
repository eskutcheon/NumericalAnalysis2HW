import numpy as np

def get_diags():
    print("Enter each diagonal as one row vector at a time, separated by spaces.")
    # get 3 row vectors, splitting at spaces, convert to float, arrange as list, then insert list into 2D numpy array
    print("Enter the superdiagonal of your matrix:")
    udiag = np.array(list(map(float, input().split(" "))))
    print("Enter the main diagonal of your matrix:")
    adiag = np.array(list(map(float, input().split(" "))))
    print("Enter the subdiagonal of your matrix")
    ldiag = np.array(list(map(float, input().split(" "))))
    return ldiag, adiag, udiag

def get_RHS(A_size):
    print("Enter the RHS vector in your augmented matrix:")
    RHS = np.array(list(map(float, input().split(" "))))
    if len(RHS) != A_size:
        print("ERROR: Dimensions of matrix and RHS do not match.")
        RHS = get_RHS(A_size)
    return RHS

def tridiagsolve(l, a, u, b):
    N = np.size(a) # dimension size of original matrix
    y = np.zeros((N,))
    print(y)
    x = np.zeros((N,))
    y[0] = b[0]
    # Also, see TDMA or Thomas Algorithm
    #Gaussian Elimination
    for i in range(N-1):
        l[i] = l[i]/a[i]
        a[i+1] -= (l[i]*u[i])
    # Forward substitution
    for j in range(1,N):
        y[j] = b[j] - (l[j-1]*y[j-1])

    x[N-1] = y[N-1]/a[N-1]
    # Backward Substitution
    for k in range(N-2, -1, -1):
        print(k)
        x[k] = (y[k]-(u[k]*x[k+1]))/a[k]

    return x



diag_tuple = get_diags()
x = tridiagsolve(diag_tuple[0], diag_tuple[1], diag_tuple[2], get_RHS(len(diag_tuple[1])))
print(x)