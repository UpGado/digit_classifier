function saveNeuralNet( filename, network_size, weights, biases )
% function saveNeuralNet( filename, network_size, weights, biases )
%  This function saves a neural network to a .nngfile
% .nng is short for Neural Net Gado (because why not)
% Inputs: filename: name of the file to be saved
% network_size of the neural network to be saved
% weights, biases: parameters of the neural network

% The idea is to save a network_size vector at the first of the file and
% save the data for each neuron in a separate line. This way, the 
% (theoritical/future)load functions knows what to expect


fileID = fopen([filename '.nng'],'w');

fprintf(fileID, 'PARAMETERS FOR A NEURAL NETWORK MADE BY AHMED GADO, ES2, TUFTS UNIVERSITY');
% Save network size in the second row
fprintf(fileID, '%d ', network_size);
fprintf(fileID, '\n');

% Save weights
for i = 1:length(weights)
    [c, d] = size(weights{i});
    % Loop over each neuron
    for n = 1:d
        for p = 1:c
            fprintf(fileID, '%f ', weights{i}(p,n));
        end
        % Add a new line for each neuron
        fprintf(fileID, '\n');
    end
end
% Add a new line before biases (This means two new lines markes the biases
% data start)
fprintf(fileID, '\n');
% Save biases
for i = 1:length(biases)
    for z = 1:length(biases{i});
        fprintf(fileID, '%f ', biases{i}(z));
    end
end

end

