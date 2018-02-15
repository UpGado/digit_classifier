
Topic: MNIST Digit Recognition Neural Network
Author: A. Gado
Date: 05/12/2017

OVERVIEW

The goal of this project was to create a Neural Net handwritten digit classifier, without using any libraries or looking at any code that is available online. As a challenge, I strictly only read about how Neural Networks work in plain English and tried to implement the ideas in MATLAB.
This project was submitted as the final project for ES2: Matlab for Engineering at Tufts University. The professor's name is Brian Tracey (whom I will always love and appreciate!)

WHERE TO START

A good starting point is startHere.m, which will guide the user through configuring the running the neural network


RUN SCRIPTS

1) startHere.m - a script that initializes a neural network and starts learning using SGD

2) runBoxSizeEffect.m - script that examines how the number of collisions with the wall 
(a surrogate for pressure of a gas) depends on the size of the enclosing box


CALCULATION FUNCTIONS

1) feedFoward.m - this function runs input data through a neural network.
2) guessResult.m - this function guesses the digit of an image using a neural network
3) initializeNetwork.m - this function creates a random neural network with given layers' dimensions
4) meanSquaredError.n - this function calculates how far the neural network's output is from the real/perfect output
5) sigmoid.m - this function calculates the sigmoid value for a scalar input


DATA/SUPPORT FUNCTIONS

1) getMNISTdata.m - this function returns the MNIST data used for learning
2) loadMNISTImages.m & loadMNISTLabels.m - these functions manage low level file reading for MNIST data set
         These functions are the only foreign code used. Source: http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset
3) saveNeuralNet.m - this function saves a .nng file containing all the neural network data. At some time in the future, I will make a loadNeuralNet function!
