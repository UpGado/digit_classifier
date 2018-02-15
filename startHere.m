% - This script uses Stochastic Gradient Descent SGD to make a neural net
% and teach it to identify handwritten digits using MNIST data set
% - It starts the learning process and after each epoch (full iteration on
% the 60,000 learning examples), it runs a test on 5000 test pictures (that
% the neural net did not "see" before). It outputs the accuracy on a graph.
% - In addition, the neural network keeps track of the parameters (weights
% and biases) that maximize the test accuracy. These biases and weights are
% then saved into a file that can be loaded later! The neural net will keep
% running until maximum epoch number is reached or interrupted (Ctl+C)

% ASK User for Configurations

prompt = {'Enter Hidden Layer Size (30 is optimal, try 15 or 100!):','Enter Learning Rate (c > 0):', 'Enter Batch Size (10 is optimal)', 'Optional: number of Epochs to run, Keep 0 for infinite'};
dlg_title = 'Neural Network Configuration';
num_lines = 1;
defaultans = {'30','0.5', '10', '0'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

activation = @(x) sigmoid(x);
cost = @(c,d,e) meanSquaredError(c,d,e);

% Number of images to reserve only for tests and *not* learning
num_test = 5000;
% Load MNIST Data
[trainingImages, trainingLabels, testImages, testLabels] = getMNISTdata(num_test);

BATCH_SIZE = str2double(answer{3});

% Number of Epoch to train the networks
EPOCHS = str2double(answer{4});
% Set to infinity if the user input 0
if EPOCHS == 0
    EPOCHS = Inf;
end

hiddenLayer = str2double(answer{1});
NETWORK_SIZE = [784 hiddenLayer 10]
% Learning rate, used as a factor to learning. Lower c means
% a better "more careful", slower learning.
c = str2double(answer{2});

[weights, biases] = initializeNetwork(NETWORK_SIZE);

costs = [];
l = length(NETWORK_SIZE);
% Epoch number (an epoch is a complete run over all training data)
n = 1;
accuracy = [];
bestAccuracy = 0;

while n <= EPOCHS
    tic
    % Shuffle all Training Data each epoch
    shuffleIndices = randperm(60000-num_test);
    shuffledImages = trainingImages(:,shuffleIndices);
    shuffledLabels = trainingLabels(shuffleIndices);
    
    for batchIndex = 1:60000/BATCH_SIZE
        
        % Initialize current batch data
        batchIndices = batchIndex: batchIndex+BATCH_SIZE -1;
        batchInputs = shuffledImages(:,batchIndices);
        labels = shuffledLabels(batchIndices);
        
        % Initialize learned parameters
        diffWeights{1} = zeros(size(weights{1}));
        diffWeights{2} = zeros(size(weights{2}));
        diffBiases{1} = zeros(size(biases{1}));
        diffBiases{2} = zeros(size(biases{2}));
        
        % Loop over each image in the batch
        for b = 1:BATCH_SIZE
            % Get the individual image from the batch
            input = batchInputs(:,b);
            
            % Create a target vector based on the image's true value.
            % It is zero everywhere and 1 at the correct neuron.
            target = zeros(10,1);
            target(labels(b) +1) = 1;
            
            % Get values output from each layer in the NN
            vals = feedForward(input, weights, biases, activation);
            output = vals{end};
            
            % BACKPROPAGE FOR EACH LAYER
            % The general idea is calculate the error in the output layer.
            % Then using Calculus (partial derivatives) change the
            % parameters in each previous layer in a way that improves the
            % final layer's output.
            
            % OUTPUT LAYER
            dETdO = output - target;
            e = exp(-vals{end-1});
            dOdNet = e./ (1+e).^2;

            dEdNet = dETdO.*dOdNet;

            % Clear variables not to be used again
            clear dETdO
            clear dOdNet
 
            for i = 1: NETWORK_SIZE(l)
                c_dEdNet = dEdNet(i);
                diffWeights{l-1}(:,i) = diffWeights{l-1}(:,i) + c_dEdNet * vals{end-2};
                diffBiases{l-1}(i) = diffBiases{l-1}(i) + c_dEdNet;
            end
            
            dNetdOut = transpose(weights{l-1}(i,:));
            dEdOut = sum(dEdNet(i,:).* dNetdOut);

            e = exp(-vals{1});
            dOdNet = e./ (1+e).^2;

            dEdNet = dEdOut.* dOdNet;

    %       HIDDEN LAYER
            for i = 1: NETWORK_SIZE(l-1)
                c_dEdNet = dEdNet(i);

                diffWeights{l-2}(:,i) = diffWeights{l-2}(:,i) + c_dEdNet .* input;
                diffBiases{l-2}(i) = diffBiases{l-2}(i) + c_dEdNet;
            end
        end
        
        % BATCH FINISHED: Update NN parameters (actual learning is here)
        for i = l-1:-1:l-2
            weights{i} = weights{i} - (c / BATCH_SIZE .* diffWeights{i});
            biases{i} = biases{i} - (c / BATCH_SIZE .* diffBiases{i});
        end
    end
    %         Epoch Finished, Run a test
        
        correctGuesses = 0;
        
        % Process the test images and get the output digits
        guesses = guessResult(testImages,weights,biases,activation);
        for i = 1:num_test
            if (guesses(i) == testLabels(i))
                % Increment correctGuesses if the NN guess is correct
                correctGuesses = correctGuesses+1;
            end
        end

        accuracy(end+1) = correctGuesses*100/num_test;
        
        % Plotting
        plot(accuracy);
        plotTitle = sprintf('SGD Learning for c = %d, batch size = %d, %d neuron hidden layer', c, BATCH_SIZE, NETWORK_SIZE(2));
        title(plotTitle);
        xlabel('Epoch');
        plotYlabel = sprintf('Percentage of correct guesses on %d test data', num_test);
        ylabel(plotYlabel);
        disp(n);
        if accuracy(end) > bestAccuracy
            disp('New best parameters');
            % Save the good parameters!
            saveNeuralNet('best',NETWORK_SIZE, weights, biases);
            bestAccuracy = accuracy(end);
        end
        pause(0.0000001);
        n = n+1;
end

% Save a graph of the learning curve
saveas(gcf, 'AccuracyGraph.png');