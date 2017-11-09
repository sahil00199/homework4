m = 99414; %the value of m that we computed
rng(0);
X = 2*rand(2, m) - 1; %generate two random variables in [-1, 1]
Y = single(X); %typecast to single
count = 0;%initialise count of appropriate points
for j = 1:m
    if Y(1, j)^2 + Y(2, j)^2 < 1
    	%if the point lies within the circle, add 1 to the count.
        count = count + 1;
    end
end
answer = (count/m) * 4; %display the estimate pi 
display(answer);