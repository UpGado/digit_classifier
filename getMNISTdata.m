function [trainingImages, trainingLabels, testImages, testLabels] = getMNISTdata(n_test)
% function [trainingImages, trainingLabels, testImages, testLabels] = getMNISTdata(n_test)
% Inputs: n_test: number of data to reserve only for tests and not for
% learning
% Outputs: trainingImages, trainingLabels: data for learning
% testImages, testLabels: data for testing

% These functions are the *only* code used from internet (Stanford
% University) http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset
AllImages = loadMNISTImages('MNIST/mnistImages');
AllLabels = loadMNISTLabels('MNIST/mnistLabels');

% Split the 60000 images into learning and test sets
trainingIndices = 1:60000-n_test;
trainingImages = AllImages(:,trainingIndices);
trainingLabels = AllLabels(trainingIndices);

testIndices = 60000-n_test+1:60000;
testImages = AllImages(:,testIndices);
testLabels = AllLabels(testIndices);

return
end
