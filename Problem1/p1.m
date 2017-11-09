numbers = [10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000];
answers = zeros(1, 8);
for i = 1:8
    rng(0);
    X = 2*rand(2, numbers(i)) - 1;
    Y = single(X);
    count = 0;
    for j = 1:numbers(i)
        if Y(1, j)^2 + Y(2, j)^2 < 1
            count = count + 1;
        end
    end
    answers(i) = (count/numbers(i)) * 4;
end
display(answers);