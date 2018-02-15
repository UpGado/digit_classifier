function result = sigmoid(x)
% function result = sigmoid(x)
% Implementation of the sigmoid (squashing) function. Used here for 
% activation of neurons.
% Inputs: x : scalar number
% Output: result: sigmoided number
result = 1.0./(1.0+exp(-x));
end