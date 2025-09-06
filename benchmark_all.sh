#!/bin/bash

# Comprehensive Programming Language Benchmark Suite
# Runs all benchmarks and presents combined results

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              COMPREHENSIVE LANGUAGE BENCHMARK SUITE          ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to run a benchmark
run_benchmark() {
    local name="$1"
    local dir="$2"
    local script="$3"
    
    echo -e "${YELLOW}🚀 Running $name benchmark...${NC}"
    echo -e "${CYAN}   Directory: $dir${NC}"
    echo -e "${CYAN}   Script: $script${NC}"
    
    if [[ -d "$dir" && -f "$dir/$script" ]]; then
        cd "$dir"
        if [[ -x "$script" ]]; then
            source ~/.cargo/env 2>/dev/null || true
            timeout 600s ./"$script" > /dev/null 2>&1 || echo -e "${RED}   ⚠️  Benchmark timed out or failed${NC}"
        else
            echo -e "${RED}   ❌ Script not executable${NC}"
        fi
        cd ..
        echo -e "${GREEN}   ✅ Completed${NC}"
    else
        echo -e "${RED}   ❌ Directory or script not found${NC}"
    fi
    echo ""
}

# Run all benchmarks
echo -e "${PURPLE}📊 Running All Benchmarks...${NC}"
echo ""

run_benchmark "Fibonacci" "fibonacci" "benchmark.sh"
run_benchmark "Array Sorting" "sorting" "benchmark.sh"
run_benchmark "Prime Sieve" "prime_sieve" "benchmark.sh"

echo -e "${PURPLE}📈 Combining Results...${NC}"
echo ""

# Create combined results
COMBINED_FILE="combined_results.csv"
echo "Language,Fibonacci_Time,Sorting_Time,Prime_Sieve_Time" > "$COMBINED_FILE"

# Get all unique languages from all result files
ALL_LANGUAGES=()
if [[ -f "fibonacci/benchmark_results.csv" ]]; then
    while IFS=',' read -r lang time; do
        if [[ "$lang" != "Language" ]]; then
            ALL_LANGUAGES+=("$lang")
        fi
    done < fibonacci/benchmark_results.csv
fi

if [[ -f "sorting/sort_results.csv" ]]; then
    while IFS=',' read -r lang time; do
        if [[ "$lang" != "Language" ]]; then
            if [[ ! " ${ALL_LANGUAGES[@]} " =~ " ${lang} " ]]; then
                ALL_LANGUAGES+=("$lang")
            fi
        fi
    done < sorting/sort_results.csv
fi

if [[ -f "prime_sieve/sieve_results.csv" ]]; then
    while IFS=',' read -r lang time; do
        if [[ "$lang" != "Language" ]]; then
            if [[ ! " ${ALL_LANGUAGES[@]} " =~ " ${lang} " ]]; then
                ALL_LANGUAGES+=("$lang")
            fi
        fi
    done < prime_sieve/sieve_results.csv
fi

# Function to get time for a language from a specific file
get_time() {
    local lang="$1"
    local file="$2"
    if [[ -f "$file" ]]; then
        grep "^$lang," "$file" | cut -d',' -f2 || echo "N/A"
    else
        echo "N/A"
    fi
}

# Generate combined results
for lang in "${ALL_LANGUAGES[@]}"; do
    fib_time=$(get_time "$lang" "fibonacci/benchmark_results.csv")
    sort_time=$(get_time "$lang" "sorting/sort_results.csv")
    sieve_time=$(get_time "$lang" "prime_sieve/sieve_results.csv")
    echo "$lang,$fib_time,$sort_time,$sieve_time" >> "$COMBINED_FILE"
done

echo -e "${GREEN}✅ Combined results saved to: $COMBINED_FILE${NC}"
echo ""

# Display results
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                        BENCHMARK RESULTS                     ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to display a benchmark section
display_benchmark() {
    local title="$1"
    local file="$2"
    local description="$3"
    
    echo -e "${PURPLE}📊 $title${NC}"
    echo -e "${CYAN}$description${NC}"
    echo ""
    
    if [[ -f "$file" ]]; then
        echo "┌─────────────────┬─────────────────┐"
        printf "│ %-15s │ %-15s │\n" "Language" "Time (seconds)"
        echo "├─────────────────┼─────────────────┤"
        
        # Sort by time (skip header)
        tail -n +2 "$file" | sort -t',' -k2 -n | while IFS=',' read -r lang time; do
            if [[ "$time" != "N/A" ]]; then
                printf "│ %-15s │ %-15s │\n" "$lang" "$time"
            fi
        done
        
        echo "└─────────────────┴─────────────────┘"
    else
        echo -e "${RED}❌ Results file not found: $file${NC}"
    fi
    echo ""
}

# Display individual benchmark results
display_benchmark "Fibonacci Benchmark" "fibonacci/benchmark_results.csv" "Calculating 100,000th Fibonacci number"
display_benchmark "Array Sorting Benchmark" "sorting/sort_results.csv" "QuickSort on 1,000,000 random integers"
display_benchmark "Prime Sieve Benchmark" "prime_sieve/sieve_results.csv" "Sieve of Eratosthenes up to 10,000,000"

# Display combined results
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                      COMBINED RESULTS                        ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

if [[ -f "$COMBINED_FILE" ]]; then
    echo "┌─────────────────┬─────────────────┬─────────────────┬─────────────────┐"
    printf "│ %-15s │ %-15s │ %-15s │ %-15s │\n" "Language" "Fibonacci" "Sorting" "Prime Sieve"
    echo "├─────────────────┼─────────────────┼─────────────────┼─────────────────┤"
    
    # Sort by average performance across all benchmarks
    tail -n +2 "$COMBINED_FILE" | while IFS=',' read -r lang fib sort sieve; do
        printf "│ %-15s │ %-15s │ %-15s │ %-15s │\n" "$lang" "$fib" "$sort" "$sieve"
    done
    
    echo "└─────────────────┴─────────────────┴─────────────────┴─────────────────┘"
else
    echo -e "${RED}❌ Combined results file not found${NC}"
fi

echo ""
echo -e "${GREEN}🎉 All benchmarks completed!${NC}"
echo -e "${YELLOW}📁 Results saved in:${NC}"
echo -e "   • fibonacci/benchmark_results.csv"
echo -e "   • sorting/sort_results.csv" 
echo -e "   • prime_sieve/sieve_results.csv"
echo -e "   • $COMBINED_FILE"
echo ""
echo -e "${BLUE}💡 Key Insights:${NC}"
echo -e "   • Different algorithms reveal different language strengths"
echo -e "   • Compiled languages generally perform best"
echo -e "   • JIT languages (JavaScript, Java) are competitive"
echo -e "   • Algorithm choice often matters more than language choice"
echo ""
