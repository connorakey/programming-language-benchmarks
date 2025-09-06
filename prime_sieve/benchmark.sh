#!/bin/bash

# Prime Number Sieve Benchmark Script
# Tests Sieve of Eratosthenes performance across multiple programming languages

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Benchmark configuration
LIMIT=10000000  # 10 million
WARMUP_RUNS=1
BENCHMARK_RUNS=3

echo -e "${BLUE}=== Prime Number Sieve Benchmark ===${NC}"
echo -e "Finding all primes up to ${LIMIT} using Sieve of Eratosthenes"
echo -e "Warmup runs: ${WARMUP_RUNS}, Benchmark runs: ${BENCHMARK_RUNS}"
echo -e "${YELLOW}Note: PHP finds primes up to 1,000,000 (memory limit) - time will be adjusted for fair comparison${NC}"
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
        echo "$name,$avg_time" >> "$BENCHMARK_DIR/sieve_results.csv"
    else
        echo -e "  ${RED}❌ All runs failed${NC}"
    fi
    echo ""
}

# Initialize results file
BENCHMARK_DIR="$(pwd)"
echo "Language,Average_Time_Seconds" > sieve_results.csv

# Python
run_benchmark "Python" "python3 sieve.py" "sieve.py"

# Ruby
run_benchmark "Ruby" "ruby sieve.rb" "sieve.rb"

# Rust
if command -v rustc &> /dev/null; then
    echo -e "${YELLOW}Compiling Rust...${NC}"
    rustc -O sieve.rs -o sieve_rust
    run_benchmark "Rust" "./sieve_rust" "sieve.rs"
    rm -f sieve_rust
else
    echo -e "${RED}❌ Rust compiler not found${NC}"
fi

# C++
if command -v g++ &> /dev/null; then
    echo -e "${YELLOW}Compiling C++...${NC}"
    g++ -O3 sieve.cpp -o sieve_cpp
    run_benchmark "C++" "./sieve_cpp" "sieve.cpp"
    rm -f sieve_cpp
else
    echo -e "${RED}❌ C++ compiler not found${NC}"
fi

# C
if command -v gcc &> /dev/null; then
    echo -e "${YELLOW}Compiling C...${NC}"
    gcc -O3 sieve.c -o sieve_c -lm
    run_benchmark "C" "./sieve_c" "sieve.c"
    rm -f sieve_c
else
    echo -e "${RED}❌ C compiler not found${NC}"
fi

# JavaScript
if command -v node &> /dev/null; then
    run_benchmark "JavaScript" "node sieve.js" "sieve.js"
else
    echo -e "${RED}❌ Node.js not found${NC}"
fi

# TypeScript
if command -v npx &> /dev/null; then
    echo -e "${YELLOW}Compiling TypeScript...${NC}"
    npx tsc sieve.ts --target es2020 --module commonjs --outDir temp_ts
    run_benchmark "TypeScript" "node temp_ts/sieve.js" "sieve.ts"
    rm -rf temp_ts
else
    echo -e "${RED}❌ TypeScript compiler not found${NC}"
fi

# Java
if command -v javac &> /dev/null && command -v java &> /dev/null; then
    echo -e "${YELLOW}Compiling Java...${NC}"
    javac Sieve.java
    run_benchmark "Java" "java Sieve" "sieve.java"
    rm -f Sieve.class
else
    echo -e "${RED}❌ Java compiler/runtime not found${NC}"
fi

# PHP
if command -v php &> /dev/null; then
    echo -e "${YELLOW}Benchmarking: PHP (1,000,000 limit - will be adjusted for fair comparison)${NC}"
    
    # Check if file exists
    if [[ ! -f "sieve.php" ]]; then
        echo -e "${RED}  ❌ File not found: sieve.php${NC}"
    else
        # Warmup runs
        echo -e "  🔥 Warming up..."
        for ((i=1; i<=WARMUP_RUNS; i++)); do
            php sieve.php > /dev/null 2>&1 || true
        done
        
        # Benchmark runs
        echo -e "  ⏱️  Running benchmark..."
        total_time=0
        successful_runs=0
        
        for ((i=1; i<=BENCHMARK_RUNS; i++)); do
            start_time=$(date +%s.%N)
            result=$(php sieve.php 2>/dev/null)
            exit_code=$?
            end_time=$(date +%s.%N)
            
            if [[ $exit_code -eq 0 && -n "$result" ]]; then
                duration=$(echo "$end_time - $start_time" | bc -l)
                total_time=$(echo "$total_time + $duration" | bc -l)
                successful_runs=$((successful_runs + 1))
                echo -e "    Run $i: ${duration}s"
            else
                echo -e "    Run $i: ${RED}FAILED${NC}"
            fi
        done
        
        if [[ $successful_runs -gt 0 ]]; then
            avg_time=$(echo "scale=4; $total_time / $successful_runs" | bc -l)
            # Adjust for 10x smaller dataset (1M vs 10M)
            # The sieve algorithm is O(n log log n), so the adjustment is approximately sqrt(10) ≈ 3.16
            adjusted_time=$(echo "scale=4; $avg_time * 3.16" | bc -l)
            echo -e "  ${GREEN}✅ Average time: ${avg_time}s (adjusted to ${adjusted_time}s for 10M limit)${NC}"
            echo "PHP,$adjusted_time" >> "$BENCHMARK_DIR/sieve_results.csv"
        else
            echo -e "  ${RED}❌ All runs failed${NC}"
        fi
        echo ""
    fi
else
    echo -e "${RED}❌ PHP not found${NC}"
fi

# C#
if command -v dotnet &> /dev/null; then
    echo -e "${YELLOW}Compiling C#...${NC}"
    rm -rf temp_cs
    dotnet new console -n temp_cs --force > /dev/null 2>&1
    cp sieve.cs temp_cs/Program.cs
    cd temp_cs
    dotnet build -c Release > /dev/null 2>&1
    run_benchmark "C#" "dotnet run -c Release" "../sieve.cs"
    cd ..
    rm -rf temp_cs
else
    echo -e "${RED}❌ .NET SDK not found${NC}"
fi

# Go
if command -v go &> /dev/null; then
    echo -e "${YELLOW}Compiling Go...${NC}"
    go build -o sieve_go sieve.go
    run_benchmark "Go" "./sieve_go" "sieve.go"
    rm -f sieve_go
else
    echo -e "${RED}❌ Go compiler not found${NC}"
fi

# Lisp (SBCL)
if command -v sbcl &> /dev/null; then
    run_benchmark "Lisp (SBCL)" "sbcl --script sieve.lisp" "sieve.lisp"
else
    echo -e "${RED}❌ SBCL not found${NC}"
fi

# Zig
if command -v zig &> /dev/null; then
    echo -e "${YELLOW}Compiling Zig...${NC}"
    zig build-exe sieve.zig -O ReleaseFast -fstrip -fno-stack-check
    run_benchmark "Zig" "./sieve" "sieve.zig"
    rm -f sieve
else
    echo -e "${RED}❌ Zig compiler not found${NC}"
fi

# Kotlin
if command -v kotlinc &> /dev/null && command -v kotlin &> /dev/null; then
    echo -e "${YELLOW}Compiling Kotlin...${NC}"
    kotlinc sieve.kt -include-runtime -d sieve_kt.jar
    run_benchmark "Kotlin" "kotlin sieve_kt.jar" "sieve.kt"
    rm -f sieve_kt.jar
else
    echo -e "${RED}❌ Kotlin compiler/runtime not found${NC}"
fi

# Perl
if command -v perl &> /dev/null; then
    run_benchmark "Perl" "perl sieve.pl" "sieve.pl"
else
    echo -e "${RED}❌ Perl not found${NC}"
fi

# Display results
echo -e "${BLUE}=== Benchmark Results ===${NC}"
if [[ -f sieve_results.csv ]]; then
    echo ""
    echo -e "${GREEN}Results (sorted by performance):${NC}"
    echo "----------------------------------------"
    printf "%-15s %s\n" "Language" "Time (seconds)"
    echo "----------------------------------------"
    
    # Sort by time (skip header)
    tail -n +2 sieve_results.csv | sort -t',' -k2 -n | while IFS=',' read -r lang time; do
        printf "%-15s %.4f\n" "$lang" "$time"
    done
    
    echo "----------------------------------------"
    echo ""
    echo -e "${YELLOW}Detailed results saved to: sieve_results.csv${NC}"
else
    echo -e "${RED}No results to display${NC}"
fi

echo -e "${BLUE}Benchmark completed!${NC}"
