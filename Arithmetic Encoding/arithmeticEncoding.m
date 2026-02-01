%% Arithmetic Encoding
%
% Input  : Message
% Output : A range or fractional value assigned for entire message as encoding

%% Defaults
clc;
clear all;
close all;

%% Inputs, Variables, Constants
alphabets = ["A", "B", "C"];
probabs   = [0.2 0.5 0.3];
MESSAGE   = 'ABBAC';

%% Interactive Inputs (Optional)
% alphabets = input("Enter alphabets array in ascending order: ");
% probabs   = input("Enter respectively probability array: ");
% MESSAGE   = input("Enter message: ");

%% Algorithm
cumProbs = [0 cumsum(probabs)];

low  = 0;
high = 1;

fprintf('Initial range: [%.6f , %.6f)\n\n', low, high);

for k = 1:length(MESSAGE)
    
    % Find index of current symbol
    idx = find(alphabets == MESSAGE(k));
    
    % Current range width
    range = high - low;
    
    % Calculate new boundaries
    low_new  = low  + range * cumProbs(idx);
    high_new = low  + range * (cumProbs(idx) + probabs(idx));
    
    % Update range
    low  = low_new;
    high = high_new;
    
    fprintf('After %c : [%.6f , %.6f)\n', MESSAGE(k), low, high);
end

%% Results
fprintf('\nEncoded range for the message "%s" is: [%.6f , %.6f)\n', MESSAGE, low, high);

res = (low + high) / 2;
fprintf('Assigned average value for the message is: %.6f\n', res);
