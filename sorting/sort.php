<?php

function quicksort($arr) {
    if (count($arr) <= 1) {
        return $arr;
    }
    
    $pivot = $arr[count($arr) / 2];
    $left = array();
    $middle = array();
    $right = array();
    
    foreach ($arr as $x) {
        if ($x < $pivot) {
            $left[] = $x;
        } elseif ($x > $pivot) {
            $right[] = $x;
        } else {
            $middle[] = $x;
        }
    }
    
    $left = quicksort($left);
    $right = quicksort($right);
    
    return array_merge($left, $middle, $right);
}

function main() {
    $size = 100000;  // Reduced for memory constraints
    $arr = array();
    
    mt_srand(42);
    for ($i = 0; $i < $size; $i++) {
        $arr[] = mt_rand(1, 1000000);
    }
    
    $sorted = quicksort($arr);
    
    echo "First 10: " . implode(" ", array_slice($sorted, 0, 10)) . "\n";
    echo "Last 10: " . implode(" ", array_slice($sorted, -10)) . "\n";
}

main();

?>
