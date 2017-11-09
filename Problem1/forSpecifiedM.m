m = 99414;
answer = 0;
rng(0);
X = 2*rand(2, m) - 1;
Y = single(X);
count = 0;
for j = 1:m
    if Y(1, j)^2 + Y(2, j)^2 < 1
        count = count + 1;
    end
end
answer = (count/m) * 4;
display(answer);