function quicksort(arr) {
    if (arr.length <= 1) {
        return arr;
    }
    const pivot = arr[Math.floor(arr.length / 2)];
    const left = arr.filter(x => x < pivot);
    const middle = arr.filter(x => x === pivot);
    const right = arr.filter(x => x > pivot);
    return [...quicksort(left), ...middle, ...quicksort(right)];
}
function main() {
    const size = 1000000;
    const arr = [];
    // Simple seeded random for reproducible results
    let seed = 42;
    function seededRandom() {
        seed = (seed * 9301 + 49297) % 233280;
        return seed / 233280;
    }
    for (let i = 0; i < size; i++) {
        arr.push(Math.floor(seededRandom() * 1000000) + 1);
    }
    const sorted = quicksort(arr);
    console.log("First 10:", sorted.slice(0, 10).join(" "));
    console.log("Last 10:", sorted.slice(-10).join(" "));
}
main();
