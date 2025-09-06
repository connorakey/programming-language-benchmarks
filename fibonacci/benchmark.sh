#!/bin/bash

# Fibonacci Programming Language Benchmark Script
# Runs all fibonacci implementations and measures performance

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Benchmark configuration
FIBONACCI_N=100000
WARMUP_RUNS=1
BENCHMARK_RUNS=3

echo -e "${BLUE}=== Fibonacci Programming Language Benchmark ===${NC}"
echo -e "Calculating the ${FIBONACCI_N}th Fibonacci number"
echo -e "Warmup runs: ${WARMUP_RUNS}, Benchmark runs: ${BENCHMARK_RUNS}"
echo ""

# Function to run a benchmark
run_benchmark() {
    local name="$1"
    local command="$2"
    local file="$3"

    echo -e "${YELLOW}Benchmarking: ${name}${NC}"

    # Check if file exists
    if [[ ! -f "$file" ]]; then
        echo -e "${RED}  ❌ File not found: $file${NC}"
        return 1
    fi

    # Warmup runs
    echo -e "  🔥 Warming up..."
    for ((i=1; i<=WARMUP_RUNS; i++)); do
        eval "$command" > /dev/null 2>&1 || true
    done

    # Benchmark runs
    echo -e "  ⏱️  Running benchmark..."
    local total_time=0
    local successful_runs=0

    for ((i=1; i<=BENCHMARK_RUNS; i++)); do
        local start_time=$(date +%s.%N)
        local result
        result=$(eval "$command" 2>/dev/null)
        local exit_code=$?
        local end_time=$(date +%s.%N)

        if [[ $exit_code -eq 0 && -n "$result" ]]; then
            local duration=$(echo "$end_time - $start_time" | bc -l)
            total_time=$(echo "$total_time + $duration" | bc -l)
            successful_runs=$((successful_runs + 1))
            echo -e "    Run $i: ${duration}s"
        else
            echo -e "    Run $i: ${RED}FAILED${NC}"
        fi
    done

    if [[ $successful_runs -gt 0 ]]; then
        local avg_time=$(echo "scale=4; $total_time / $successful_runs" | bc -l)
        echo -e "  ${GREEN}✅ Average time: ${avg_time}s${NC}"
        echo "$name,$avg_time" >> "$BENCHMARK_DIR/benchmark_results.csv"
    else
        echo -e "  ${RED}❌ All runs failed${NC}"
    fi
    echo ""
}

# Initialize results file
BENCHMARK_DIR="$(pwd)"
echo "Language,Average_Time_Seconds" > benchmark_results.csv

# Python
run_benchmark "Python" "python3 fibonacci.py" "fibonacci.py"

# Ruby
run_benchmark "Ruby" "ruby fibonacci.rb" "fibonacci.rb"

# Rust
if command -v rustc &> /dev/null; then
    echo -e "${YELLOW}Compiling Rust...${NC}"
    rustc -O fibonacci.rs -o fibonacci_rust
    run_benchmark "Rust" "./fibonacci_rust" "fibonacci.rs"
    rm -f fibonacci_rust
else
    echo -e "${RED}❌ Rust compiler not found${NC}"
fi

# C++
if command -v g++ &> /dev/null; then
    echo -e "${YELLOW}Compiling C++...${NC}"
    g++ -O3 fibonacci.cpp -o fibonacci_cpp
    run_benchmark "C++" "./fibonacci_cpp" "fibonacci.cpp"
    rm -f fibonacci_cpp
else
    echo -e "${RED}❌ C++ compiler not found${NC}"
fi

# C
if command -v gcc &> /dev/null; then
    echo -e "${YELLOW}Compiling C...${NC}"
    gcc -O3 fibonacci.c -o fibonacci_c
    run_benchmark "C" "./fibonacci_c" "fibonacci.c"
    rm -f fibonacci_c
else
    echo -e "${RED}❌ C compiler not found${NC}"
fi

# TypeScript (compile first, keep JS)
if command -v npx &> /dev/null; then
    echo -e "${YELLOW}Compiling TypeScript...${NC}"
    npx tsc fibonacci.ts --target es2020 --module commonjs
    run_benchmark "TypeScript" "node fibonacci.js" "fibonacci.ts"
    # Do NOT delete fibonacci.js here — keep it for JS benchmark
else
    echo -e "${RED}❌ TypeScript compiler not found${NC}"
fi

# JavaScript (run only if fibonacci.js exists)
if command -v node &> /dev/null; then
    if [[ ! -f "fibonacci.js" ]]; then
        echo -e "${YELLOW}Compiling JavaScript from TypeScript...${NC}"
        if command -v npx &> /dev/null; then
            npx tsc fibonacci.ts --target es2020 --module commonjs
        else
            echo -e "${RED}❌ TypeScript compiler not found, cannot build JS${NC}"
        fi
    fi
    run_benchmark "JavaScript" "node fibonacci.js" "fibonacci.js"
else
    echo -e "${RED}❌ Node.js not found${NC}"
fi

# Java
if command -v javac &> /dev/null && command -v java &> /dev/null; then
    echo -e "${YELLOW}Compiling Java...${NC}"
    javac Fibonacci.java
    run_benchmark "Java" "java Fibonacci" "Fibonacci.java"
    rm -f Fibonacci.class
else
    echo -e "${RED}❌ Java compiler/runtime not found${NC}"
fi

# PHP
if command -v php &> /dev/null; then
    run_benchmark "PHP" "php fibonacci.php" "fibonacci.php"
else
    echo -e "${RED}❌ PHP not found${NC}"
fi

# C#
if command -v dotnet &> /dev/null; then
    echo -e "${YELLOW}Compiling C#...${NC}"
    # Create temporary project dir
    rm -rf temp_cs
    dotnet new console -n temp_cs --force > /dev/null 2>&1
    cp fibonacci.cs temp_cs/Program.cs
    cd temp_cs
    dotnet build -c Release > /dev/null 2>&1
    run_benchmark "C#" "dotnet run -c Release" "Program.cs"
    cd ..
    rm -rf temp_cs
else
    echo -e "${RED}❌ .NET SDK not found${NC}"
fi

# Go
if command -v go &> /dev/null; then
    echo -e "${YELLOW}Compiling Go...${NC}"
    go build -o fibonacci_go fibonacci.go
    run_benchmark "Go" "./fibonacci_go" "fibonacci.go"
    rm -f fibonacci_go
else
    echo -e "${RED}❌ Go compiler not found${NC}"
fi


# Lisp (SBCL)
if command -v sbcl &> /dev/null; then
    run_benchmark "Lisp (SBCL)" "sbcl --script fibonacci.lisp" "fibonacci.lisp"
else
    echo -e "${RED}❌ SBCL not found${NC}"
fi

# Bash
run_benchmark "Bash" "bash fibonacci.sh" "fibonacci.sh"

# Assembly (x86-64)
if command -v gcc &> /dev/null; then
    echo -e "${YELLOW}Compiling Assembly...${NC}"
    gcc -no-pie fibonacci.s -o fibonacci_asm
    run_benchmark "Assembly" "./fibonacci_asm" "fibonacci.s"
    rm -f fibonacci_asm
else
    echo -e "${RED}❌ GCC not found for Assembly compilation${NC}"
fi

# Zig
if command -v zig &> /dev/null; then
    echo -e "${YELLOW}Compiling Zig...${NC}"
    zig build-exe fibonacci.zig -O ReleaseFast -fstrip -fno-stack-check
    run_benchmark "Zig" "./fibonacci" "fibonacci.zig"
    rm -f fibonacci
else
    echo -e "${RED}❌ Zig compiler not found${NC}"
fi

# Kotlin
if command -v kotlinc &> /dev/null && command -v kotlin &> /dev/null; then
    echo -e "${YELLOW}Compiling Kotlin...${NC}"
    kotlinc fibonacci.kt -include-runtime -d fibonacci_kt.jar
    run_benchmark "Kotlin" "kotlin fibonacci_kt.jar" "fibonacci.kt"
    rm -f fibonacci_kt.jar
else
    echo -e "${RED}❌ Kotlin compiler/runtime not found${NC}"
fi

# Perl
if command -v perl &> /dev/null; then
    run_benchmark "Perl" "perl fibonacci.pl" "fibonacci.pl"
else
    echo -e "${RED}❌ Perl not found${NC}"
fi

# Display results
echo -e "${BLUE}=== Benchmark Results ===${NC}"
if [[ -f benchmark_results.csv ]]; then
    echo ""
    echo -e "${GREEN}Results (sorted by performance):${NC}"
    echo "----------------------------------------"
    printf "%-15s %s\n" "Language" "Time (seconds)"
    echo "----------------------------------------"

    # Sort by time (skip header)
    tail -n +2 benchmark_results.csv | sort -t',' -k2 -n | while IFS=',' read -r lang time; do
        printf "%-15s %.4f\n" "$lang" "$time"
    done

    echo "----------------------------------------"
    echo ""
    echo -e "${YELLOW}Detailed results saved to: benchmark_results.csv${NC}"
else
    echo -e "${RED}No results to display${NC}"
fi

echo -e "${BLUE}Benchmark completed!${NC}"