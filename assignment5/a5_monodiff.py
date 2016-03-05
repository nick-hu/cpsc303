'''
CPSC 303 Assignment 5: Problem 4 Parts (b)-(d)
Automatic Differentiation of Polynomial Interpolation
Nicholas Hu
'''

#!/usr/bin/env python

import autograd.numpy as np
from autograd import grad
import matplotlib.pyplot as plt


def monomial(x, y, x_test):
    n = len(x)

    A = np.vander(x, increasing=True)
    c = np.linalg.solve(A, y)

    y_test = np.zeros_like(x_test)
    for j in xrange(n-1, -1, -1):
        y_test = np.multiply(y_test, x_test) + c[j]

    return y_test


def p(y1, t):
    x = np.array([0.1, 0.15, 0.2, 0.3, 0.35, 0.5, 0.75])
    y = np.array([3.0, y1, 1.2, 2.1, 2.0, 2.5, 2.5])
    return monomial(x, y, t)


def p_vec(y, t):
    x = np.array([0.1, 0.15, 0.2, 0.3, 0.35, 0.5, 0.75])
    return monomial(x, y, t)


# Part (b)

x = np.array([0.1, 0.15, 0.2, 0.3, 0.35, 0.5, 0.75])
y = np.array([3.0, 1.0, 1.2, 2.1, 2.0, 2.5, 2.5])

x_test = np.linspace(0.1, 0.75, 100)

plt.plot(x_test, monomial(x, y, x_test))
plt.plot(x, y, 'ko')
plt.show()

# Part (c)

t = 0.7
print "Analytic derivative: dp({})/dy1 = {}".format(t, p(2.0, t) - p(1.0, t))
grad_p = grad(p)  # By default, takes derivative w.r.t. 0th arg
print "Automatic derivative: dp({})/dy1 = {}".format(t, grad_p(2.0, t))  # WOW!

# Part (d)

grad_p_vec = grad(p_vec)
print "\nAutomatic derivative: dp_vec({})/dy = {}".format(t, grad_p_vec(y, t))
