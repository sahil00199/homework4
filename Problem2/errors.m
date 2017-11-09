
rng(0);
mu = [1;2];%initializing the value of the mean
m=100;
C = [1.6250, -1.9486 ; -1.9486 , 3.8750];%calculating the eigenvalues and corresponding eigenvectors
squareC = C.^2;
froC = sum(sum(squareC));
[Q, lambda] = eig(C);%calculating the eigenvalues and corresponding eigenvectors
A = lambda.^(1/2);
A = Q*A*inv(Q);;%calculating A invloved in generating multivariate gaussian
meanErrors = zeros(m ,5); %the array storing the relative errors of mean
covErrors = zeros(m, 5);%the array storing the relative errors of covariance
numbers = [10, 100, 1000, 10000, 100000];%array of number of terms
for i = 1:5
    for j = 1:m
        X = randn(2, numbers(i));
        Y = A*X;
        Y(1,:) = Y(1,:) + mu(1);
        Y(2,:) = Y(2,:) + mu(2);%generating the multivariate gaussian
        MLmean = [mean(Y(1,:)); mean(Y(2,:))];%calculating the experimental mean
        ScaledMean = MLmean - mu;
        meanErrors(j, i) = (ScaledMean(1)^2 + ScaledMean(2)^2)/5;
        meanErrors(j, i) = sqrt(meanErrors(j, i));
        Y(1,:) = Y(1,:) - MLmean(1);
        Y(2,:) = Y(2,:) - MLmean(2);%used in calculation of covariance
        currentCov = Y*Y';
        currentCov = currentCov/numbers(i);%calculating the covariance matrix
        scaledCov = currentCov - C;
        scaledCov = scaledCov.^2;
        froCurrent = sum(sum(scaledCov));
        covErrors(j, i) = froCurrent/froC;%calculating the error in covariance matrix
        covErrors(j, i) = sqrt(covErrors(j, i));
    end
end
save('p2data')
