import sys

def fibonacci(n):
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a

if __name__ == "__main__":
    # Increase the limit for integer string conversion
    sys.set_int_max_str_digits(0)  # 0 means no limit
    result = fibonacci(100000)
    print(result)