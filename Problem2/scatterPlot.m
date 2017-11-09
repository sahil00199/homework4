    mu = [1;2];
m=1;
C = [1.6250, -1.9486 ; -1.9486 , 3.8750];
[Q, lambda] = eig(C);
A = lambda.^(1/2);
A = Q*A*inv(Q);
numbers = [10, 100, 1000, 10000, 100000];
for i = 1:5
    rng(0);
    X = randn(2, numbers(i));
    Y = A*X;
    Y(1,:) = Y(1,:) + mu(1);
    Y(2,:) = Y(2,:) + mu(2);
    MLmean = [mean(Y(1,:)); mean(Y(2,:))];
    scaledY=zeros(2,numbers(i));
    scaledY(1,:) = Y(1,:) - MLmean(1);
    scaledY(2,:) = Y(2,:) - MLmean(2);
    currentCov = (scaledY*scaledY')./numbers(i);
    pcaVec = zeros(1,2);
    [eigenVec, eigenValues] = eig(currentCov);
    if eigenValues(1,1)>eigenValues(2,2)
        pcaVec = eigenVec(:,1)*eigenValues(1,1);
    else
        pcaVec = eigenVec(:,2)*eigenValues(2,2);
    end
    data2 = MLmean + pcaVec;
    scatter(Y(1,:),Y(2,:));
    hold on;
    plot([MLmean(1),data2(1)],[MLmean(2),data2(2)])
    
end
