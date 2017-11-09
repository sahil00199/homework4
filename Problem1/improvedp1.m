numbers = [10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000];
answers = zeros(1, 8);
for i = 1:7
    rng(0);
    count = 0;
    for j = 1:numbers(i)
        X = 2*rand(2) - 1;
        Y = single(X);
        if Y(1)^2 + Y(2)^2 < 1
            count = count + 1;
        end
    end
    answers(i) = (count/numbers(i)) * 4;
end
display(answers)