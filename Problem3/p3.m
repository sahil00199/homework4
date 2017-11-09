%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                          end of reading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[images, labels] = generateData('train-images.idx3-ubyte','train-labels.idx1-ubyte');
correctData = double(reshape(images(:,:,1:60000),[],60000));
numbers = zeros(1, 10);
length = numCols*numRows;
means = zeros(10, length);
covariances = zeros(10, length, length);
for i=1:10
    for j = 1:totalImages
        if labels(j) == i - 1
            numbers(i) = numbers(i) + 1;
            data = double(imageCellArray{j});
            data = reshape(data, 1, length);
            means(i, :) = means(i, :) + data;
        end
    end
    means(i, :) = means(i, :)./ numbers(i);
end

eigenvalues = zeros(10, length);
eigenvectors = zeros(10, length);
vectors = zeros(length, length);
values = zeros(length, length);
meansNeg = zeros(10, length);
meansPos = zeros(10, length);

for i=1:10
    covar = zeros(numbers(i),784);
    y = 1;
    for j = 1:totalImages
        if labels(j) == i - 1
            data = double(reshape(imageCellArray{j},1,length)) - means(i,:);
            covar(y,:) = data;
            y = y + 1;
        end
    end
%     covariances(i, :, :) = cov(covar);
%     %size(eig(reshape(covariances(i, :, :), length, length)));
%     cova = covariances(i, :, :);
%     cova = reshape(cova, length, length);
    [vectors, values] = eig(cov(covar));
    for k = 1:length
        eigenvalues(i, k) = values(length-k+1, length-k+1);
    end
    eigenvectors(i, :) = vectors(:,length)';
    meansNeg(i, :) = means(i, :) - sqrt(eigenvalues(i, 1))*eigenvectors(i,:);
    meansPos(i, :) = means(i, :) + sqrt(eigenvalues(i, 1))*eigenvectors(i,:);
end, 
plot(eigenvalues(10,:))
title('Eigenvalues for the digit 9')

 figure;
 title('digit 9')
 subplot(1,3,1)
 imshow(reshape(means(10,:)./255,28,28));
 subplot(1,3,2)
 imshow(reshape(meansNeg(10,:)./255,28,28));
 subplot(1,3,3)
 imshow(reshape(meansPos(10,:)./255,28,28));
% for i=1:10
%     subplot(1,10,i)
%     imshow(reshape(means(i,:),28,28)./255);
% end,
%     

