numbers = [10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000]; %array consisting the different values for the size
%of the data set
answers = zeros(1, 8); %array to store the answers obtained
for i = 1:8
	%run for each value of the size of the data size
    rng(0);%set the seed
    Y = 2*rand(2, numbers(i),'single') - 1; %Generate a vector that is drawn from the uniform distribution on 
    %[-1,1]x[-1,1]
    count = 0; %set the count of numbers inside the circle to 0
    for j = 1:numbers(i)
        if Y(1, j)^2 + Y(2, j)^2 < 1
        	%if the point lies within the circle, we update the count 
            count = count + 1;
        end
    end
    answers(i) = (count/numbers(i)) * 4; %the estimate is the proportion of points lying inside the circle times 4.
end
display(answers); %show the answers for all different values.