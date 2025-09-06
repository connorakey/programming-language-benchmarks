<?php

function fibonacci($n) {
    $a = 0;
    $b = 1;
    for ($i = 0; $i < $n; $i++) {
        $temp = $a;
        $a = $b;
        $b += $temp;
    }
    return $a;
}

$result = fibonacci(100000);
echo $result . "\n";

?>
