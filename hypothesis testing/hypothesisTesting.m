clc;
clear;

disp('Hypothesis Testing - Critical Value Method');

sigma = input('Enter population standard deviation (sigma): ');
mu0   = input('Enter hypothesized population mean (μ0): ');
xbar  = input('Enter sample mean (x̄): ');
n     = input('Enter sample size (n): ');
alpha = input('Enter significance level (alpha): ');

disp(' ');
disp('Select test type:');
disp('1. Two-tailed test (H1: μ ≠ μ0)');
disp('2. Right-tailed test (H1: μ > μ0)');
disp('3. Left-tailed test (H1: μ < μ0)');

tail = input('Enter choice (1/2/3): ');

% Standard error
se = sigma / sqrt(n);

fprintf('\nResults:\n');

if tail == 1
    % Two-tailed
    zc  = norminv(1 - alpha/2);
    LCV = mu0 - zc * se;
    UCV = mu0 + zc * se;

    if xbar >= LCV && xbar <= UCV
        decision = 'Fail to Reject H0';
    else
        decision = 'Reject H0';
    end

    fprintf('Test: Two-tailed\n');
    fprintf('z critical: %.4f\n', zc);
    fprintf('LCV: %.4f\n', LCV);
    fprintf('UCV: %.4f\n', UCV);

elseif tail == 2
    % Right-tailed
    zc  = norminv(1 - alpha);
    UCV = mu0 + zc * se;

    if xbar <= UCV
        decision = 'Fail to Reject H0';
    else
        decision = 'Reject H0';
    end

    fprintf('Test: Right-tailed\n');
    fprintf('z critical: %.4f\n', zc);
    fprintf('UCV: %.4f\n', UCV);

elseif tail == 3
    % Left-tailed
    zc  = norminv(1 - alpha);
    LCV = mu0 - zc * se;

    if xbar >= LCV
        decision = 'Fail to Reject H0';
    else
        decision = 'Reject H0';
    end

    fprintf('Test: Left-tailed\n');
    fprintf('z critical: %.4f\n', zc);
    fprintf('LCV: %.4f\n', LCV);

else
    error('Invalid choice');
end

fprintf('Sample Mean (x̄): %.4f\n', xbar);
fprintf('Decision: %s\n', decision);
