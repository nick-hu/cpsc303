'''
CPSC 303 Assignment 5: Problem 4 Part (a)
Automatic Differentiation of Hyperbolic Tangent
Nicholas Hu
'''

#!/usr/bin/env python

import autograd.numpy as np
from autograd import grad
import matplotlib.pyplot as plt


def tanh(x):
    y = np.exp(-x)
    return (1.0 - y) / (1.0 + y)


def elementwise_grad(f):
    return grad(lambda x: np.sum(f(x)))


grad_tanh = elementwise_grad(tanh)
grad_tanh_2 = elementwise_grad(grad_tanh)
grad_tanh_3 = elementwise_grad(grad_tanh_2)
grad_tanh_4 = elementwise_grad(grad_tanh_3)
grad_tanh_5 = elementwise_grad(grad_tanh_4)
grad_tanh_6 = elementwise_grad(grad_tanh_5)

x = np.linspace(-7, 7, 200)
plt.plot(x, tanh(x), 'skyblue',
         x, grad_tanh(x), 'cornflowerblue',
         x, grad_tanh_2(x), 'steelblue',
         x, grad_tanh_3(x), 'deepskyblue',
         x, grad_tanh_4(x), 'dodgerblue',
         x, grad_tanh_5(x), 'mediumblue',
         x, grad_tanh_6(x), 'darkblue')
plt.show()
