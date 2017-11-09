rng(0);
mu = [1;2];
m=100;
C = [1.6250, -1.9486 ; -1.9486 , 3.8750];
squareC = C.^2;
froC = sum(sum(squareC));
[Q, lambda] = eig(C);
A = lambda.^(1/2);
A = Q*A*inv(Q);
meanErrors = zeros(m ,5); 
covErrors = zeros(m, 5);
numbers = [10, 100, 1000, 10000, 100000];
for i = 1:5
    for j = 1:m
        X = randn(2, numbers(i));
        Y = A*X;
        Y(1,:) = Y(1,:) + mu(1);
        Y(2,:) = Y(2,:) + mu(2);
        MLmean = [mean(Y(1,:)); mean(Y(2,:))];
        ScaledMean = MLmean - mu;
        meanErrors(j, i) = (ScaledMean(1)^2 + ScaledMean(2)^2)/5;
        meanErrors(j, i) = sqrt(meanErrors(j, i));
        Y(1,:) = Y(1,:) - MLmean(1);
        Y(2,:) = Y(2,:) - MLmean(2);
        currentCov = Y*Y';
        currentCov = currentCov/numbers(i);
        scaledCov = currentCov - C;
        scaledCov = scaledCov.^2;
        froCurrent = sum(sum(scaledCov));
        covErrors(j, i) = froCurrent/froC;
        covErrors(j, i) = sqrt(covErrors(j, i));
    end
end
save('p2data')
