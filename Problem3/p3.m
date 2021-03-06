numCols = 28;
numRows = 28;
totalImages = 60000;
[images, labels] = generateData('train-images.idx3-ubyte','train-labels.idx1-ubyte'); %call the 
%function to read the data we took from the link
correctData = double(reshape(images(:,:,1:60000),[],60000)); %reshape the data into vectors as needed
numbers = zeros(1, 10); %maintain a count of how many times each number is present in the given data set
length = numCols*numRows; %length of the vector formed by converting the matrix into a vector
means = zeros(10, length); %10 cross 28^2 matrix to store the means for every digit
covariances = zeros(10, length, length);
for i=1:10 
    %run a loop for every digit
    for j = 1:totalImages
        % check every image and do more stuff if the digit is the one being considered currently (i.e. i)
        if labels(j) == i - 1
            numbers(i) = numbers(i) + 1; %increase count by 1
            data = double(correctData(:,j)); 
            data = reshape(data, 1, length);
            means(i, :) = means(i, :) + data; %add the current data to the mean array
        end
    end
    means(i, :) = means(i, :)./ numbers(i); %divide by the number of times the digit occurs
    %to obtain the appropriate mean
end

eigenvalues = zeros(10, length); %store the eigenvalues corresponding to
%the largest eigen values for each digit
eigenvectors = zeros(10, length);%store all the eigenvalues for each digit
vectors = zeros(length, length);%store all the eigenvectors for the current digit
values = zeros(length, length);%store the diagonal matrix with all eigenvalues
%for the current digit
meansNeg = zeros(10, length);%store the values for mu - sqrt(lambda)v1
meansPos = zeros(10, length);%store the values for mu + sqrt(lambda)v1

for i=1:10
    %for every digit
    covar = zeros(numbers(i),784); %store the values corresponding to the current digit 
    y = 1;
    for j = 1:totalImages
        if labels(j) == i - 1
            data = double(reshape(correctData(:,j),1,length)) - means(i,:);
            covar(y,:) = data; %add current vector to the data
            y = y + 1;
        end
    end
    [vectors, values] = eig(cov(covar)); %find the covariance of all the data
    %for a given digit and then find its eigenvalues and eigenvectors
    for k = 1:length
        eigenvalues(i, k) = values(length-k+1, length-k+1);
        %store the eigenvalues in a vector instead of a diagonal matrix
        %and reverse the order so that the largest value is the first one
    end
    eigenvectors(i, :) = vectors(:,length)';
    %store the eigenvector corresponding to the largets eigenvalue
    meansNeg(i, :) = means(i, :) - sqrt(eigenvalues(i, 1))*eigenvectors(i,:);
    %update the corresponding vectors
    meansPos(i, :) = means(i, :) + sqrt(eigenvalues(i, 1))*eigenvectors(i,:);
end, 
plot(eigenvalues(6,:)) %plot the eigenvalues for a particular digit
title('Eigenvalues for the digit 5') %title of the plot

 figure;
 title('digit 5')
 subplot(1,3,1)
 imshow(reshape(means(6,:)./255,28,28)); %show the image corresponding to the 
 %mean vector
 subplot(1,3,2)
 imshow(reshape(meansNeg(6,:)./255,28,28)); % show the image corresponding the
 %mean minus sqrt(lambda)v1 vector
 subplot(1,3,3)
 imshow(reshape(meansPos(6,:)./255,28,28)); % show the image corresponding the
 %mean plus sqrt(lambda)v1 vector
% for i=1:10
%     subplot(1,10,i)
%     imshow(reshape(means(i,:),28,28)./255);
% end,
%     

