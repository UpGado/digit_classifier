function [costVal] = meanSquaredError(output, real, n)
% function [costVal] = meanSquaredError(output, real, n)
% Calculates the Mean Squared Error of the neural network output with
% respect to the true/perfect result.
% Inputs: output: the output column vector represented activation result of
% the output layer.
% real: a column vector representing the correct output for the test data
% n: the number of test data (images in this case) used.
% Outputs: costVal: meanSquaredError function 
costVal = sum(output - real);
costVal = sum(costVal);
costVal = costVal.^2 / (2*n);
return
end

