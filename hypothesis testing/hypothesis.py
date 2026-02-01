import math
from scipy.stats import norm

def hypothesis_test_cv(mu, xbar, sigma, n, alpha=0.05, tail=1):
    # Standard error
    se = sigma / math.sqrt(n)

    # TWO-TAILED
    if tail == 1:
        zc = norm.ppf(1 - alpha/2)
        LCV = mu - zc * se
        UCV = mu + zc * se

        decision = (
            "Fail to Reject H0"
            if LCV <= xbar <= UCV
            else "Reject H0"
        )

        return {
            "Test": "Two-tailed",
            "z_critical": zc,
            "LCV": LCV,
            "UCV": UCV,
            "xbar": xbar,
            "\nDecision": decision
        }

    # RIGHT-TAILED 
    elif tail == 2:
        zc = norm.ppf(1 - alpha)
        UCV = mu + zc * se

        decision = (
            "Fail to Reject H0"
            if xbar <= UCV
            else "Reject H0"
        )

        return {
            "Test": "Right-tailed",
            "z_critical": zc,
            "UCV": UCV,
            "xbar": xbar,
            "\nDecision": decision
        }

    # LEFT-TAILED 
    elif tail == 3:
        zc = norm.ppf(1 - alpha)
        LCV = mu - zc * se

        decision = (
            "Fail to Reject H0"
            if xbar >= LCV
            else "Reject H0"
        )

        return {
            "Test": "Left-tailed",
            "z_critical": zc,
            "LCV": LCV,
            "xbar": xbar,
            "\nDecision": decision
        }

    else:
        raise ValueError("tail must be 1 (two), 2 (right), or 3 (left)")


if __name__ == "__main__":
    print("Hypothesis Testing - Critical Value Method\n")

    sigma = float(input("Enter population standard deviation (sigma): "))
    population_mean = float(input("Enter hypothesized population mean (μ₀): "))
    sample_mean = float(input("Enter sample mean (x̄): "))
    sample_size = int(input("Enter sample size (n): "))
    alpha = float(input("Enter significance level (alpha): "))

    print("\nSelect test type:")
    print("1. Two-tailed test (H₁: μ ≠ μ₀)")
    print("2. Right-tailed test (H₁: μ > μ₀)")
    print("3. Left-tailed test (H₁: μ < μ₀)")
        
    test_choice = int(input("Enter choice (1/2/3): "))

    print("\nResults: ")

    result = hypothesis_test_cv(population_mean, sample_mean, sigma, sample_size, alpha, test_choice)

    for k, v in result.items():
        print(f"{k}: {v}")

    print("\n")
