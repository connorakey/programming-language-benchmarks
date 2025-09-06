s u#!/bin/bash

# Large Array Sorting Benchmark Script
# Tests QuickSort performance across multiple programming languages

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Benchmark configuration
ARRAY_SIZE=1000000
WARMUP_RUNS=1
BENCHMARK_RUNS=3

echo -e "${BLUE}=== Large Array Sorting Benchmark ===${NC}"
echo -e "Sorting ${ARRAY_SIZE} random integers using QuickSort"
echo -e "Warmup runs: ${WARMUP_RUNS}, Benchmark runs: ${BENCHMARK_RUNS}"
echo -e "${YELLOW}Note: PHP sorts 100,000 elements (memory limit) - time will be adjusted by 10x for fair comparison${NC}"
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
        echo "$name,$avg_time" >> "$BENCHMARK_DIR/sort_results.csv"
    else
        echo -e "  ${RED}❌ All runs failed${NC}"
    fi
    echo ""
}

# Initialize results file
BENCHMARK_DIR="$(pwd)"
echo "Language,Average_Time_Seconds" > sort_results.csv

# Python
run_benchmark "Python" "python3 sort.py" "sort.py"

# Ruby
run_benchmark "Ruby" "ruby sort.rb" "sort.rb"

# Rust
if command -v rustc &> /dev/null; then
    echo -e "${YELLOW}Compiling Rust...${NC}"
    rustc -O sort.rs -o sort_rust
    run_benchmark "Rust" "./sort_rust" "sort.rs"
    rm -f sort_rust
else
    echo -e "${RED}❌ Rust compiler not found${NC}"
fi

# C++
if command -v g++ &> /dev/null; then
    echo -e "${YELLOW}Compiling C++...${NC}"
    g++ -O3 sort.cpp -o sort_cpp
    run_benchmark "C++" "./sort_cpp" "sort.cpp"
    rm -f sort_cpp
else
    echo -e "${RED}❌ C++ compiler not found${NC}"
fi

# C
if command -v gcc &> /dev/null; then
    echo -e "${YELLOW}Compiling C...${NC}"
    gcc -O3 sort.c -o sort_c
    run_benchmark "C" "./sort_c" "sort.c"
    rm -f sort_c
else
    echo -e "${RED}❌ C compiler not found${NC}"
fi

# JavaScript
if command -v node &> /dev/null; then
    run_benchmark "JavaScript" "node sort.js" "sort.js"
else
    echo -e "${RED}❌ Node.js not found${NC}"
fi

# TypeScript
if command -v npx &> /dev/null; then
    echo -e "${YELLOW}Compiling TypeScript...${NC}"
    npx tsc sort.ts --target es2020 --module commonjs --outDir temp_ts
    run_benchmark "TypeScript" "node temp_ts/sort.js" "sort.ts"
    rm -rf temp_ts
else
    echo -e "${RED}❌ TypeScript compiler not found${NC}"
fi

# Java
if command -v javac &> /dev/null && command -v java &> /dev/null; then
    echo -e "${YELLOW}Compiling Java...${NC}"
    javac Sort.java
    run_benchmark "Java" "java Sort" "sort.java"
    rm -f Sort.class
else
    echo -e "${RED}❌ Java compiler/runtime not found${NC}"
fi

# PHP
if command -v php &> /dev/null; then
    echo -e "${YELLOW}Benchmarking: PHP (100,000 elements - will be adjusted by 10x)${NC}"
    
    # Check if file exists
    if [[ ! -f "sort.php" ]]; then
        echo -e "${RED}  ❌ File not found: sort.php${NC}"
    else
        # Warmup runs
        echo -e "  🔥 Warming up..."
        for ((i=1; i<=WARMUP_RUNS; i++)); do
            php sort.php > /dev/null 2>&1 || true
        done
        
        # Benchmark runs
        echo -e "  ⏱️  Running benchmark..."
        total_time=0
        successful_runs=0
        
        for ((i=1; i<=BENCHMARK_RUNS; i++)); do
            start_time=$(date +%s.%N)
            result=$(php sort.php 2>/dev/null)
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
            adjusted_time=$(echo "scale=4; $avg_time * 10" | bc -l)
            echo -e "  ${GREEN}✅ Average time: ${avg_time}s (adjusted to ${adjusted_time}s for 1M elements)${NC}"
            echo "PHP,$adjusted_time" >> "$BENCHMARK_DIR/sort_results.csv"
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
    cp sort.cs temp_cs/Program.cs
    cd temp_cs
    dotnet build -c Release > /dev/null 2>&1
    run_benchmark "C#" "dotnet run -c Release" "../sort.cs"
    cd ..
    rm -rf temp_cs
else
    echo -e "${RED}❌ .NET SDK not found${NC}"
fi

# Go
if command -v go &> /dev/null; then
    echo -e "${YELLOW}Compiling Go...${NC}"
    go build -o sort_go sort.go
    run_benchmark "Go" "./sort_go" "sort.go"
    rm -f sort_go
else
    echo -e "${RED}❌ Go compiler not found${NC}"
fi

# Lisp (SBCL)
if command -v sbcl &> /dev/null; then
    run_benchmark "Lisp (SBCL)" "sbcl --script sort.lisp" "sort.lisp"
else
    echo -e "${RED}❌ SBCL not found${NC}"
fi

# Bash - Removed (too slow for fair compar/ison)

# Zig
if command -v zig &> /dev/null; then
    echo -e "${YELLOW}Compiling Zig...${NC}"
    zig build-exe sort.zig -O ReleaseFast -fstrip -fno-stack-check
    run_benchmark "Zig" "./sort" "sort.zig"
    rm -f sort
else
    echo -e "${RED}❌ Zig compiler not found${NC}"
fi

# Kotlin
if command -v kotlinc &> /dev/null && command -v kotlin &> /dev/null; then
    echo -e "${YELLOW}Compiling Kotlin...${NC}"
    kotlinc sort.kt -include-runtime -d sort_kt.jar
    run_benchmark "Kotlin" "kotlin sort_kt.jar" "sort.kt"
    rm -f sort_kt.jar
else
    echo -e "${RED}❌ Kotlin compiler/runtime not found${NC}"
fi

# Perl
if command -v perl &> /dev/null; then
    run_benchmark "Perl" "perl sort.pl" "sort.pl"
else
    echo -e "${RED}❌ Perl not found${NC}"
fi

# Display results
echo -e "${BLUE}=== Benchmark Results ===${NC}"
if [[ -f sort_results.csv ]]; then
    echo ""
    echo -e "${GREEN}Results (sorted by performance):${NC}"
    echo "----------------------------------------"
    printf "%-15s %s\n" "Language" "Time (seconds)"
    echo "----------------------------------------"
    
    # Sort by time (skip header)
    tail -n +2 sort_results.csv | sort -t',' -k2 -n | while IFS=',' read -r lang time; do
        printf "%-15s %.4f\n" "$lang" "$time"
    done
    
    echo "----------------------------------------"
    echo ""
    echo -e "${YELLOW}Detailed results saved to: sort_results.csv${NC}"
else
    echo -e "${RED}No results to display${NC}"
fi

echo -e "${BLUE}Benchmark completed!${NC}"
