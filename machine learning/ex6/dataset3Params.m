function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.


% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
C = 1;
sigma = 0.1;
C_final = C;
sigma_final = sigma;

model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
predictions = svmPredict(model, Xval);
error1 = mean(double(predictions ~= yval));

vec = [0.01 0.05 0.1 0.5 1 3 6 10 15 50];


for i=1:length(vec)
  C = vec(i);
  fprintf("i = %d",i);
  for j=1:length(vec)
    sigma = vec(j);
    fprintf("j = %d",j);
    model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    predictions = svmPredict(model, Xval);
    if(error1 >= mean(double(predictions ~= yval)))
      error1 = mean(double(predictions ~= yval));
      C_final = C;
      sigma_final = sigma;
    endif

  endfor
endfor


C = C_final;
sigma = sigma_final;



% =========================================================================

end
